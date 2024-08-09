import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/subscription_model.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

import '../../../services/snackbar.dart';

class SubscriptionController extends GetxController{

  TextEditingController promoCodeController = TextEditingController();

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiresController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxList<SubscriptionModel> subscriptionPlans = <SubscriptionModel>[].obs;
  Rx<SubscriptionModel> selectedPlan = SubscriptionModel().obs;

  @override
  void onInit(){
    super.onInit();
    getPlans();
  }

  Future<void> getPlans() async{
    try{
      var response = await APIManager.getSubscriptionPlans();
      if(response.statusCode == 200) {
        for(Map<String, dynamic> planData in response.data["data"]){
          subscriptionPlans.add(SubscriptionModel.fromJson(planData));
        }
      } else{
        DialogHelper.showError(response.data["message"]);
      }
    } catch(e){
      print("An error occurred while getting subscription plans");
      DialogHelper.showError("An error occurred while getting subscription plans");
    }
  }

  @override
  void onClose(){
    super.onClose();
    promoCodeController.dispose();
    cardNumberController.dispose();
    cvvController.dispose();
    expiresController.dispose();
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
      showMySnackbar(title: e.error.message ?? "", msg: '');
    }
    return null;
  }

  Future<void> addCard() async{
    final String token = await generateStripeToken(
        card: cardNumberController.text,
        name: nameController.text,
        expiryDate: expiresController.text,
        cvv: cvvController.text) ?? "";
    if(token.isNotEmpty){
      try{
        final response = await APIManager.addCard(
            data: {
              "token": token,
            }
        );
        if(response.data['status']){
          DialogHelper.showSuccess("Card Added!");
        } else{
          DialogHelper.showError(response.data['message']);
        }
      } catch(e){
        print("An error occurred while adding card: $e");
        DialogHelper.showError(e.toString());
      }
    }
  }

  void goToPurchasePlanView(){
    Get.toNamed(Routes.PURCHASEPLAN);
  }

  void goToPaymentMethodView(){
    Get.toNamed(Routes.PAYMENTDETAILS);
  }

  void goToCardDetailsView(){
    Get.toNamed(Routes.CARDDETAILS);
  }
}