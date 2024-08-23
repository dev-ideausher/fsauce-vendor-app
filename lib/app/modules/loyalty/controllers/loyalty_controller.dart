import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/loyalty_card.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/modules/loyalty/views/loyalty_view.dart';
import 'package:fsauce_vendor_app/app/modules/loyaltyCards/controllers/loyalty_cards_controller.dart';
import 'package:fsauce_vendor_app/app/modules/loyaltyCards/views/active_loyalty_cards.dart';
import 'package:fsauce_vendor_app/app/modules/loyaltyCards/views/inactive_loyalty_cards.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';


class LoyaltyController extends GetxController {
  //TODO: Implement LoyaltyController

  TextEditingController cardTitleController = TextEditingController();
  RxInt noOfStamps = 1.obs;
  DateTime validTill = DateTime.now();
  TextEditingController validTillDateController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit(){
    super.onInit();
    Get.find<HomeController>().getRestaurantDetails();
  }

  @override
  void onClose() {
    cardTitleController.dispose();
    validTillDateController.dispose();
    super.onClose();
  }

  Future<void> createLoyaltyCard() async{
    if(
    Get.find<HomeController>().restaurantDetails.value.subscriptionModel != null
    ){
      if(cardTitleController.text.isEmpty){
        Get.snackbar("Error", StringConstant.offerTitleErrorMsg);
        return;
      }
      else if(backgroundColor.value.toString().isEmpty){
        Get.snackbar("Error", StringConstant.bgColorCannotBeEmpty);
        return;
      }
      else if(textColor.value.toString().isEmpty){
        Get.snackbar("Error", StringConstant.textColorCannotBeEmpty);
        return;
      }
      else if(stampBackgroundColor.value.toString().isEmpty){
        Get.snackbar("Error", StringConstant.stampBGErrorMsg);
        return;
      }
      else if(stampTextColor.value.toString().isEmpty){
        Get.snackbar("Error", StringConstant.stampColorErrorMsg);
        return;
      }

      String vendorId = Get.find<HomeController>().vendor;
      Map<String, dynamic> data = {
        "title": cardTitleController.text,
        "noOfStamps": noOfStamps.value,
        "cardBackgroundColor": backgroundColor.value.value.toString(),
        "cardTextColor": textColor.value.toString(),
        "stampBackgroundColor": stampBackgroundColor.value.toString(),
        "stampColor": stampTextColor.value.toString(),
        "vendor": vendorId, //"66728075a065bac72ace0f09"
        "validTill": validTill.toString(),
        "isActive": true
      };
      var response = await APIManager.addLoyaltyCard(data: data);
      if(response.data['status']){
        Get.back();
        Get.bottomSheet(const AddedSuccessfullBottomSheet(subTitle: StringConstant.loyaltyCardCreatedSuccessfully));
        DialogHelper.showSuccess(StringConstant.loyaltyAddedMessage);
        Get.find<LoyaltyCardsController>().getLoyaltyCards();
      } else if(!response.data['status']){
        Get.snackbar("Error",StringConstant.anErrorOccurred);
      }
    } else{
      Get.snackbar("Subscription Required", "Kindly subscribe to a plan to access this feature!");
      return;
    }
  }

  final backgroundColor = Color.fromARGB(255, 10, 27, 255).obs;

  void openBackgroundColorpalet() {
    Get.dialog(ColorPickerDialog(
      initialColor: Colors.white,
      onColorChanged: (val) {
        backgroundColor.value = val;
      },
    ));
  }

  final textColor = Color(0xffFFFFFF).obs;

  void openTextColorpalet() {
    Get.dialog(ColorPickerDialog(
      initialColor: Colors.white,
      onColorChanged: (val) {
        textColor.value = val;
      },
    ));
  }

  final stampBackgroundColor = Color(0xffFFFFFF).obs;

  void openStampBackgroundColorpalet() {
    Get.dialog(ColorPickerDialog(
      initialColor: Colors.white,
      onColorChanged: (val) {
        stampBackgroundColor.value = val;
      },
    ));
  }

  final stampTextColor = Color(0xffFFFFFF).obs;

  void openStampTextColorpalet() {
    Get.dialog(ColorPickerDialog(
      initialColor: Colors.white,
      onColorChanged: (val) {
        stampTextColor.value = val;
      },
    ));
  }

  void gotoPreviewScreen() {
    Get.toNamed(Routes.LOYALTY_CARD_PREVIEW);
  }
}
