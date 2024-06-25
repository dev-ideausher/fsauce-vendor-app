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

  List<Widget> tabs = [
    ActiveLoyaltyCards(),
    InactiveLoyaltyCards(),
  ];

  RxList<LoyaltyCardModel> activeLoyaltyCards = <LoyaltyCardModel>[].obs;
  RxList<LoyaltyCardModel> inActiveLoyaltyCards = <LoyaltyCardModel>[].obs;

  Future<void> getLoyaltyCards() async{
    var response = await APIManager.getLoyaltyCards(status: true);
    if(response.data['status']){
      activeLoyaltyCards.value = [];
      for(Map<String, dynamic> card in response.data['data']){
        activeLoyaltyCards.add(LoyaltyCardModel.fromJson(card));
      }
    } else{
      DialogHelper.showError(StringConstant.couldntGetLoyaltyCards);
    }

    var cardsResponse = await APIManager.getLoyaltyCards(status: false);
    if(cardsResponse.data['status']){
      inActiveLoyaltyCards.value = [];
      for(Map<String, dynamic> card in cardsResponse.data['data']){
        inActiveLoyaltyCards.add(LoyaltyCardModel.fromJson(card));
      }
    } else{
      DialogHelper.showError(StringConstant.couldntGetLoyaltyCards);
    }
  }

  @override
  void onInit() {
    getLoyaltyCards();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void gotoEditLoyaltyPage() {
    Get.toNamed(Routes.LOYALTY);
  }
}
