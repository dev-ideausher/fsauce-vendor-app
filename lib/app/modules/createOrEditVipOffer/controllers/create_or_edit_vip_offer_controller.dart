import 'package:flutter/cupertino.dart';
import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/coupon_model.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/controllers/vip_offers_controller.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

class CreateOrEditVipOfferController extends GetxController {
  //TODO: Implement CreateOrEditVipOfferController

  final count = 0.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController termsAndConditionsController = TextEditingController();
  TextEditingController validTillDateController = TextEditingController();
  TextEditingController scheduleDateController = TextEditingController();
  TextEditingController scheduleTimeController = TextEditingController();

  RxInt selectedTypeOfOffer = 0.obs;
  RxInt selectedValidForOption = 0.obs;

  List<String> typeOfOffers = [
    "Deal of the day",
    "Normal Offer"
  ];

  List<String> validForOptions = [
    "Dine-In",
    "Take-away"
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    titleController.dispose();
    descriptionController.dispose();
    termsAndConditionsController.dispose();
  }

  void showCreatedBottomSheet() {
    Get.bottomSheet(AddedSuccessfullBottomSheet(
      subTitle: StringConstant.vipOfferCreatedSuccessfully,
    ));
  }

  void showUpdatedBottomSheet() {
    Get.bottomSheet(AddedSuccessfullBottomSheet(
      subTitle: StringConstant.vipOfferEditedSuccessfully,
    ));
  }

  Future<bool> addCoupon() async {
    if (titleController.text
        .trim()
        .isEmpty) {
      DialogHelper.showError("Title can't be empty");
      return false;
    }
    if (validTillDateController.text.isEmpty) {
      DialogHelper.showError("Please select a date");
      return false;
    }
    if (descriptionController.text.isEmpty) {
      DialogHelper.showError("Description can't be empty");
      return false;
    }
    if (termsAndConditionsController.text.isEmpty) {
      DialogHelper.showError("Terms and conditions can't be empty");
      return false;
    }

    try{
      var response = await APIManager.addCoupon(
        title: titleController.text,
        typeOfOffer: "Normal offer",
        validFor: "Dine-In",
        validTill: validTillDateController.text,
        description: descriptionController.text,
        termsAndConditions: [termsAndConditionsController.text],
        isActive: true,
      );
      if (response.data['status']) {
        Get.find<VipOffersController>().getCoupons();
        DialogHelper.showSuccess("Item added successfully");
        titleController.text = '';
        validTillDateController.text = '';
        descriptionController.text = '';
        termsAndConditionsController.text = '';
        return true;
      }
      return false;
    } catch(e){
      print("Error: $e");
      rethrow;
    }
  }

  Future<bool> editCoupon() async {
    if (titleController.text
        .trim()
        .isEmpty) {
      DialogHelper.showError("Title can't be empty");
      return false;
    }
    if (validTillDateController.text.isEmpty) {
      DialogHelper.showError("Please select a date");
      return false;
    }
    if (descriptionController.text.isEmpty) {
      DialogHelper.showError("Description can't be empty");
      return false;
    }
    if (termsAndConditionsController.text.isEmpty) {
      DialogHelper.showError("Terms and conditions can't be empty");
      return false;
    }
    // try{
    //   // var response = await APIManager.editCoupon(Coupon(
    //   //     title: titleController.text,
    //   //     typeOfOffer: 'Normal offer',
    //   //     validFor: 'Dine-In',
    //   //     validTill: validTillDateController.text,
    //   //     description: descriptionController.text,
    //   //     termsAndConditions: [termsAndConditionsController.text]
    //   // )
    //   );
    //   if (response.data['status']) {
    //     DialogHelper.showSuccess("Item added successfully");
    //     return true;
    //   }
    //   return false;
    // } catch(e){
    //   print("Error: $e");
    //   rethrow;
    // }
    return false;
  }

  void increment() => count.value++;
}
