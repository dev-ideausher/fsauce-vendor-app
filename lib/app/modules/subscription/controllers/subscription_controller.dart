import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/plan_model.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';

import '../../../components/added_successfull_bottomsheet.dart';
import '../../../components/confirmation_dialog.dart';
import '../../../models/card_data_model.dart';
import '../../../services/enigma.dart';
import '../../../services/snackbar.dart';

class SubscriptionController extends GetxController {
  TextEditingController promoCodeController = TextEditingController();

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiresController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxList<PlanModel> subscriptionPlans = <PlanModel>[].obs;
  Rx<PlanModel> selectedPlan = PlanModel().obs;

  RxList<CardModel> cardsList = <CardModel>[].obs;
  Rx<CardModel> selectedCard = CardModel().obs;

  RxBool showList = true.obs;

  Rx<PlanModel> currentPlan = PlanModel().obs;
  RxBool isCancelled = false.obs;

  RxString planId = "".obs;
  RxString subscriptionId = "".obs;

  @override
  void onInit() {
    super.onInit();
    getPlans();
    getCardList();
  }

  String formatDateString(String isoDateStr) {
    try {
      DateTime dateTime = DateTime.parse(isoDateStr);
      DateFormat formatter = DateFormat('d MMMM yyyy');
      return formatter.format(dateTime);
    } catch (e) {
      // Handle any parsing errors
      print('Error parsing date: $e');
      return 'Invalid date';
    }
  }

  Future<void> getPlans() async {
    try {
      var response = await APIManager.getSubscriptionPlans();
      if (response.statusCode == 200) {
        subscriptionPlans.value = [];
        Get.find<HomeController>().getRestaurantDetails();
        for (Map<String, dynamic> planData in response.data["data"]) {
          subscriptionPlans.add(PlanModel.fromJson(planData));
        }
        String? currentPlanId = Get.find<HomeController>().restaurantDetails.value.subscriptionModel == null ?
        "" : Get.find<HomeController>().restaurantDetails.value.subscriptionModel!.plan ?? "";
        planId.value = currentPlanId ?? "";
        print("This is the plan id: $planId");

        String? currentSubscriptionId = Get.find<HomeController>().restaurantDetails.value.subscriptionModel == null ?
        "" : Get.find<HomeController>().restaurantDetails.value.subscriptionModel!.stripeSubscriptionObj == null ? ""
        : Get.find<HomeController>().restaurantDetails.value.subscriptionModel!.stripeSubscriptionObj!.id ?? "";
        subscriptionId.value = currentSubscriptionId ?? "";
        print("This is the subscription id: $subscriptionId");

        bool? isCancelledSub = Get.find<HomeController>().restaurantDetails.value.subscriptionModel == null ?
        false : Get.find<HomeController>().restaurantDetails.value.subscriptionModel!.isCancelled ?? false;
        isCancelled.value = isCancelledSub;
        print("Was the sub cancelled: ${isCancelled.value}");

        showList.value = subscriptionId.isEmpty;
        if(subscriptionId.isNotEmpty){
          currentPlan.value = subscriptionPlans.firstWhere((
              PlanModel model) => model.Id == planId.value);
        }
      } else {
        DialogHelper.showError(response.data["message"] ?? "");
      }
    } catch (e) {
      print("An error occurred while getting subscription plans: $e");
      DialogHelper.showError(
          "An error occurred while getting subscription plans");
    }
  }

  @override
  void onClose() {
    super.onClose();
    promoCodeController.dispose();
    cardNumberController.dispose();
    cvvController.dispose();
    expiresController.dispose();
    nameController.dispose();
  }

  static Future<String?> generateStripeToken(
      {required String card, required String name, required String expiryDate, required String cvv}) async {
    var prAge = expiryDate.split("/");
    var month = prAge[0].trim();
    var year = prAge[1].trim();
    CardTokenParams cardParams = CardTokenParams(
        type: TokenType.Card, name: name, currency: "MAD");
    await Stripe.instance
        .dangerouslyUpdateCardDetails(CardDetails(number: card,
        cvc: cvv,
        expirationMonth: int.tryParse(month),
        expirationYear: int.tryParse("20$year")));
    try {
      TokenData token = await Stripe.instance.createToken(
          CreateTokenParams.card(params: cardParams));
      return token.id;
    } on StripeException catch (e) {
      // showMySnackbar(title: e.error.message ?? "", msg: '');
      DialogHelper.showError(e.error.message ?? "");
    }
    return null;
  }

  Future<void> addCard() async {
    final String token =
        await generateStripeToken(card: cardNumberController.text,
            name: nameController.text,
            expiryDate: expiresController.text,
            cvv: cvvController.text) ??
            "";
    if (token.isNotEmpty) {
      print("Token is not empty: $token");
      final String? encryptToken = encryptAESCryptoJS(
          jsonEncode({"token": token, "default": "true"}));
      try {
        print("Below is the encrypt token: $encryptToken");
        final response = await APIManager.addCard(data: {
          "token": encryptToken,
        });
        if (response.data['status']) {
          Get.back();
          DialogHelper.showSuccess("Card Added!");
          getCardList();
        } else {
          DialogHelper.showError(response.data['message'] ?? "");
        }
      } catch (e) {
        print("Error while adding card: ${e.toString()}");
        DialogHelper.showError(e.toString() ?? "");
      }
    }
  }

  Future<void> getCardList() async {
    try {
      final response = await APIManager.getCardDataList();
      if (response.statusCode == 200) {
        cardsList.value = [];
        for (Map<String, dynamic> cardData in response.data['data']) {
          cardsList.add(CardModel.fromJson(cardData));
        }
      } else {
        // showMySnackbar(msg: response.data['message'] ?? "");
        DialogHelper.showError(response.data['message'] ?? "");
      }
      return;
    } catch (e) {
      print("An error occurred while getting card list: $e");
      DialogHelper.showError(e.toString() ?? "");
      return;
    }
  }

  void showDelCardDialog(CardModel card) {
    Get.dialog(
        ConfrimationDialog(
            title: "Delete card?",
            subTitle: "This card will be removed from saved cards.",
            onYesTap: () async {
              String id = card.id ?? "";
              if(id.isNotEmpty){
                print("Entered dialog for delete card");
                await delCard(card);
              } else if(id.isEmpty){
                Get.snackbar(StringConstant.error, "Cannot delete card");
              }
            },
            onNoTap: Get.back)
    );
  }

  Future<void> delCard(CardModel card) async {
    String id = card.id ?? "";
    print("Here is the id: $id");
    try {
      if (id.isNotEmpty) {
        final response = await APIManager.deleteCard(id);
        if (response.data['status']) {
          cardsList.remove(card);
        } else {
          DialogHelper.showError(response.data['message']);
        }
      }
    } catch (e) {
      print("An error occurred while deleting card: ${e.toString()}");
      DialogHelper.showError(e.toString());
    }
  }

  Future<void> addVendorSubscription() async {
    if (selectedPlan.value.Id == null ||
        selectedPlan.value.billedFrequency == null) {
      DialogHelper.showError("No plan selected!");
      return;
    } else if (selectedCard.value.id == null) {
      DialogHelper.showError("No card selected!");
      return;
    } else {
      Map<String, dynamic> data = {
        "planId": selectedPlan.value.Id,
        "cardId": selectedCard.value.id,
        "billedFrequency": selectedPlan.value.billedFrequency,
      };
      try {
        final response = await APIManager.addVendorSubscription(data: data);
        if (response.data['status']) {
          Get.bottomSheet(const AddedSuccessfullBottomSheet(
              subTitle: StringConstant.membershipPurchaseSuccess));
          Get.find<HomeController>().getRestaurantDetails();
          getPlans();
          isCancelled.value = false;
          return;
        }
        else {
          DialogHelper.showError(response.data['message']);
          return;
        }
      } catch (e) {
        print("An error occurred while adding vendor subscription $e");
        DialogHelper.showError(e.toString());
        return;
      }
    }
  }

  void confirmCancelSubscription() async{
    Get.dialog(
        ConfrimationDialog(
            title: "Cancel Subscription?",
            subTitle: "The current subscription will be cancelled.",
            onYesTap: () async {
              print("Entered dialog for cancel subscription");
              if(subscriptionId.value.isNotEmpty){
                await cancelSubscription();
              } else if(subscriptionId.value.isEmpty){
                Get.snackbar(StringConstant.error, "No current subscription plan");
              }
            },
            onNoTap: Get.back)
    );
  }

  Future<void> cancelSubscription() async{
    String subId = subscriptionId.value ?? "";
    print("Here is the subId: $subId");
    final Map<String, dynamic> data = {
      "subscriptionId":"$subId"
    };
    try{
      final response = await APIManager.cancelSubscription(data: data);
      if(response.data['code'] == 201 || response.data['code'] == 200){
        Get.snackbar(StringConstant.success, "Subscription cancelled successfully!");
        isCancelled.value = true;
        return;
      }
      else if(response.data['code'] != 201 || response.data['code'] != 200){
        Get.snackbar("Message", response.data['message']);
        isCancelled.value = true;
        return;
      }
    } catch(e){
      print("An error occurred while cancelling subscription! ${e.toString()}");
      Get.snackbar(StringConstant.error, e.toString());
    }
  }

  void goToPurchasePlanView() {
    Get.toNamed(Routes.PURCHASEPLAN);
  }

  void goToPaymentMethodView() {
    Get.toNamed(Routes.PAYMENTDETAILS);
  }

  void goToCardDetailsView() {
    Get.toNamed(Routes.CARDDETAILS);
  }
}