import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/plan_model.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../components/added_successfull_bottomsheet.dart';
import '../../../components/confirmation_dialog.dart';
import '../../../models/all_plan_model.dart';
import '../../../models/card_data_model.dart';
import '../../../services/enigma.dart';
import '../../../services/snackbar.dart';

class SubscriptionController extends GetxController {
  RxList<AllPlanModelData> allPlans = <AllPlanModelData>[].obs;

  TextEditingController promoCodeController = TextEditingController();

  late TextEditingController eCardHolderName = TextEditingController();
  final cardNumber = ''.obs;
  final expiryDate = ''.obs;
  final cardHolderName = ''.obs;
  final cvvCode = ''.obs;
  final isCvvFocused = false.obs;
  var cardDetails = Rx<CardFieldInputDetails?>(null);
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Rx<PlanModelData> subscriptionPlans = PlanModelData().obs;
  Rx<AllPlanModelData> selectedPlan = AllPlanModelData().obs;

  RxList<CardModel> cardsList = <CardModel>[].obs;
  Rx<CardModel> selectedCard = CardModel().obs;

  RxBool showList = true.obs;

  RxBool isCancelled = false.obs;

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
      var response = await APIManager.getVendorSubscriptionList();
      if (response.data['status']) {
        Get.find<HomeController>().getRestaurantDetails();
        showList.value = false;
        subscriptionPlans.value = PlanModel.fromJson(response.data).data ?? PlanModelData();

        isCancelled.value = subscriptionPlans.value.isCancelled ?? false;
      } else {
        showList.value = true;
        getAllPlans();
      }
    } catch (e) {
      print("An error occurred while getting subscription plans: $e");
    }
  }

  @override
  void onClose() {
    super.onClose();
    promoCodeController.dispose();
    nameController.dispose();
  }

  static Future<String?> generateStripeToken({required String card, required String name, required String expiryDate, required String cvv}) async {
    var prAge = expiryDate.split("/");
    var month = prAge[0].trim();
    var year = prAge[1].trim();
    CardTokenParams cardParams = CardTokenParams(type: TokenType.Card, name: name, currency: "MAD");
    await Stripe.instance.dangerouslyUpdateCardDetails(CardDetails(number: card, cvc: cvv, expirationMonth: int.tryParse(month), expirationYear: int.tryParse("20$year")));
    try {
      TokenData token = await Stripe.instance.createToken(CreateTokenParams.card(params: cardParams));
      return token.id;
    } on StripeException catch (e) {
      // showMySnackbar(title: e.error.message ?? "", msg: '');
      DialogHelper.showError(e.error.message ?? "");
    }
    return null;
  }

  Future<void> addCard() async {
    if (cardDetails.value == null || !(cardDetails.value?.complete ?? false)) {
      showMySnackbar(msg: 'Please enter valid card details');
      return;
    }

    if (eCardHolderName.text.trim().isEmpty) {
      showMySnackbar(msg: 'Please enter cardholder name');
      return;
    }
    TokenData? tokenData;
    try {
      tokenData = await Stripe.instance.createToken(
        CreateTokenParams.card(
          params: CardTokenParams(
            name: nameController.text.trim(),
            currency: 'MAD', // Or gbp etc
          ),
        ),
      );
    } on StripeException catch (error) {
      showMySnackbar(msg: error.error.message.toString());
      return;
    } catch (e) {
      print(e);
      return;
    }

    final token = tokenData.id;
    if (token.isNotEmpty) {
      print("Token is not empty: $token");
      final String encryptToken = encryptAESCryptoJS(jsonEncode({"token": token, "default": "true"}));
      try {
        print("Below is the encrypt token: $encryptToken");
        final response = await APIManager.addCard(data: {
          "token": encryptToken,
        });
        if (response.data['status']) {
          await getCardList();
          Get.back();
        } else {
          print("-------> ${response.data}");
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
      print("GetCardList Response Data: ${response.data}");
      if (response.statusCode == 200) {
        cardsList.assignAll([]);
        for (Map<String, dynamic> cardData in response.data['data']) {
          cardsList.add(CardModel.fromJson(cardData));
        }
        if (cardsList.isNotEmpty) {
          if (selectedCard.value.id != null) {
            CardModel? previouslySelected = cardsList.firstWhereOrNull((c) => c.id == selectedCard.value.id);
            if (previouslySelected != null) {
              selectedCard.value = previouslySelected;
            } else {
              CardModel? defaultCard = cardsList.firstWhereOrNull((c) => c.isDefautl == true);
              selectedCard.value = defaultCard ?? cardsList.first;
            }
          } else {
            CardModel? defaultCard = cardsList.firstWhereOrNull((c) => c.isDefautl == true);
            selectedCard.value = defaultCard ?? cardsList.first;
          }
        } else {
          selectedCard.value = CardModel();
        }
        print("Cards fetched: ${cardsList.length}");
        print("Selected Card ID: ${selectedCard.value.id}");
        cardsList.refresh();
        selectedCard.refresh();
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
    Get.dialog(ConfrimationDialog(
        title: "Delete card?",
        subTitle: "This card will be removed from saved cards.",
        onYesTap: () async {
          String id = card.id ?? "";
          if (id.isNotEmpty) {
            print("Entered dialog for delete card");
            await delCard(card);
          } else if (id.isEmpty) {
            Get.snackbar(StringConstant.error, "Cannot delete card");
          }
        },
        onNoTap: Get.back));
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
    // Auto-select first card if none selected but cards are available
    if (selectedCard.value.id == null && cardsList.isNotEmpty) {
      debugPrint("Auto-selecting first card as fallback.");
      selectedCard.value = cardsList.first;
    }

    // Validate plan selection
    if (selectedPlan.value.Id == null || selectedPlan.value.billedFrequency == null) {
      DialogHelper.showError("No plan selected!");
      return;
    }

    // Validate card selection
    if (selectedCard.value.id == null) {
      final message = cardsList.isEmpty 
          ? "Please add a payment method first." 
          : "No card selected!";
      showMySnackbar(msg: message);
      return;
    }

    // Prepare subscription data
    final Map<String, dynamic> data = {
      "planId": selectedPlan.value.Id,
      "cardId": selectedCard.value.id,
      "billedFrequency": selectedPlan.value.billedFrequency,
    };

    try {
      final response = await APIManager.addVendorSubscription(data: data);
      
      if (response.data['status']) {
        // Reset selected plan
        selectedPlan = AllPlanModelData().obs;
        isCancelled.value = false;
        
        // Show success message
        Get.bottomSheet(
          const AddedSuccessfullBottomSheet(
            subTitle: StringConstant.membershipPurchaseSuccess
          ),
        );
        
        // Refresh data
        Get.find<HomeController>().getRestaurantDetails();
        await getPlans();
        
        // Go back to previous screen
        Get.back();
        Get.back();
      } else {
        DialogHelper.showError(response.data['message']);
      }
    } catch (e) {
      debugPrint("Error adding vendor subscription: $e");
      DialogHelper.showError("Failed to process subscription. Please try again.");
    }
  }

  void confirmCancelSubscription() async {
    Get.dialog(ConfrimationDialog(
        title: "Cancel Subscription?",
        subTitle: "The current subscription will be cancelled.",
        onYesTap: () async {
          await cancelSubscription();
        },
        onNoTap: Get.back));
  }

  Future<void> cancelSubscription() async {
    final Map<String, dynamic> data = {"subscriptionId": subscriptionPlans.value.subscriptionId};
    try {
      final response = await APIManager.cancelSubscription(data: data);
      if (response.data['code'] == 201 || response.data['code'] == 200) {
        Get.snackbar(StringConstant.success, "Subscription cancelled successfully!");
        isCancelled.value = true;
        return;
      } else if (response.data['code'] != 201 || response.data['code'] != 200) {
        Get.snackbar("Message", response.data['message']);
        isCancelled.value = true;
        await getPlans();
        return;
      }
    } catch (e) {
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

  Future<void> getAllPlans() async {
    try {
      final res = await APIManager.getSubscriptionPlans();
      AllPlanModel allPlanModel = AllPlanModel.fromJson(res.data);
      allPlans.value = allPlanModel.data!;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
