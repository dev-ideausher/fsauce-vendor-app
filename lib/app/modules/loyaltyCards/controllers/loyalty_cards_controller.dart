import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/loyalty_card.dart';
import 'package:fsauce_vendor_app/app/modules/loyaltyCards/views/active_loyalty_cards.dart';
import 'package:fsauce_vendor_app/app/modules/loyaltyCards/views/inactive_loyalty_cards.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

class LoyaltyCardsController extends GetxController {
  //TODO: Implement LoyaltyCardsController

  int currentActivePage = 1;
  final int activeLimit = 5;
  var isActiveLoading = false.obs;
  var isMoreActiveDataAvailable = true.obs;

  int currentInactivePage = 1;
  final int inActiveLimit = 5;
  var isInActiveLoading = false.obs;
  var isMoreInactiveDataAvailable = true.obs;

  @override
  void onInit() {
    getLoyaltyCards();
    activeScrollController = ScrollController()..addListener(_scrollListener);
    inActiveScrollController = ScrollController()..addListener(_inactiveScrollListener);
    super.onInit();
  }

  ScrollController activeScrollController = ScrollController();
  ScrollController inActiveScrollController = ScrollController();

  _scrollListener() {
    if (activeScrollController.position.extentAfter <= 0 && isActiveLoading.value == false) {
      addActiveCards();
    }
  }

  _inactiveScrollListener(){
    if(inActiveScrollController.position.extentAfter <= 0 && isInActiveLoading.value == false){
      addInactiveCards();
    }
  }

  @override
  void onClose() {
    activeScrollController.removeListener(_scrollListener);
    inActiveScrollController.removeListener(_inactiveScrollListener);
    super.onClose();
  }

  List<Widget> tabs = [
    const ActiveLoyaltyCards(),
    const InactiveLoyaltyCards(),
  ];

  RxList<LoyaltyCardModel> activeLoyaltyCards = <LoyaltyCardModel>[].obs;
  RxList<LoyaltyCardModel> inActiveLoyaltyCards = <LoyaltyCardModel>[].obs;

  void addActiveCards() async{
    if (isActiveLoading.value || !isMoreActiveDataAvailable.value) return;

    isActiveLoading.value = true;
    try{
      var response = await APIManager.getLoyaltyCards(page: currentActivePage + 1, limit: activeLimit, status: true);
      List<LoyaltyCardModel> fetchedCards = (response.data['data'] as List).map((card) => LoyaltyCardModel.fromJson(card)).toList();

      if(fetchedCards.length < activeLimit){
        isMoreActiveDataAvailable.value = false;
      } else{
        ++currentActivePage;
      }

      activeLoyaltyCards.addAll(fetchedCards);
    } catch(e){
      print("An error occurred while adding active cards!: $e");
    } finally {
      isActiveLoading.value = false;
    }
    return;
  }

  void addInactiveCards() async{
    if (isInActiveLoading.value || !isMoreInactiveDataAvailable.value) return;

    isInActiveLoading.value = true;
    try{
      var response = await APIManager.getLoyaltyCards(page: currentInactivePage + 1, limit: inActiveLimit, status: false);
      List<LoyaltyCardModel> fetchedCards = (response.data['data'] as List).map((card) => LoyaltyCardModel.fromJson(card)).toList();

      if(fetchedCards.length < inActiveLimit){
        isMoreInactiveDataAvailable.value = false;
      } else{
        ++currentInactivePage;
      }

      inActiveLoyaltyCards.addAll(fetchedCards);
    } catch(e){
      print("An error occurred while adding inactive coupons!: $e");
    } finally {
      isInActiveLoading.value = false;
    }
    return;
  }

  Future<void> getLoyaltyCards() async{

    currentActivePage = 1;
    isMoreActiveDataAvailable.value = true;
    isActiveLoading.value = false;

    var response = await APIManager.getLoyaltyCards(status: true);
    if(response.data['status']){
      activeLoyaltyCards.value = [];
      for(Map<String, dynamic> card in response.data['data']){
        activeLoyaltyCards.add(LoyaltyCardModel.fromJson(card));
      }
    } else{

    }

    currentInactivePage = 1;
    isMoreInactiveDataAvailable.value = true;
    isInActiveLoading.value = false;

    var cardsResponse = await APIManager.getLoyaltyCards(status: false);
    if(cardsResponse.data['status']){
      inActiveLoyaltyCards.value = [];
      for(Map<String, dynamic> card in cardsResponse.data['data']){
        inActiveLoyaltyCards.add(LoyaltyCardModel.fromJson(card));
      }
    } else{

    }
  }

  void gotoEditLoyaltyPage() {
    Get.toNamed(Routes.LOYALTY);
  }
}
