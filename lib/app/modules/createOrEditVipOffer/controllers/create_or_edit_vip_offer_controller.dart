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

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController termsAndConditionsController = TextEditingController();
  TextEditingController validTillDateController = TextEditingController();
  TextEditingController scheduleDateController = TextEditingController();
  TextEditingController scheduleTimeController = TextEditingController();

  RxInt selectedTypeOfOffer = 0.obs;
  RxInt selectedValidForOption = 0.obs;

  List<String> typeOfOffers = [
    StringConstant.dealOfTheDay,
    StringConstant.normalOfferCoupon,
  ];

  List<String> validForOptions = [
    StringConstant.dineIn,
    StringConstant.takeAwayCoupon,
  ];

  @override
  void onInit() {
    super.onInit();
    getSelectedCouponDetails();
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
    validTillDateController.dispose();
    scheduleDateController.dispose();
    scheduleTimeController.dispose();
  }

  void getSelectedCouponDetails(){
    Coupon coupon = Get.find<VipOffersController>().selectedCoupon.value;
    if(Get.arguments[0]){
      titleController.text = coupon.title;
      descriptionController.text = coupon.description;
      validTillDateController.text = coupon.validTill.substring(0, 10);
      termsAndConditionsController.text = coupon.termsAndConditions.join(" ");
      selectedTypeOfOffer.value = typeOfOffers.indexOf(coupon.typeOfOffer);
      selectedValidForOption.value = validForOptions.indexOf(coupon.validFor);
    }
  }

  void showCreatedBottomSheet() {
    Get.bottomSheet(const AddedSuccessfullBottomSheet(
      subTitle: StringConstant.vipOfferCreatedSuccessfully,
    ));
  }

  void showUpdatedBottomSheet() {
    Get.bottomSheet(const AddedSuccessfullBottomSheet(
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
      Map<String, dynamic> data = {
        "title": titleController.text,
        "typeOfOffer": typeOfOffers[selectedTypeOfOffer.value],
        "validFor": validForOptions[selectedValidForOption.value],
        "validTill": validTillDateController.text,
        "description": descriptionController.text,
        "termsAndConditions": [termsAndConditionsController.text],
        "isActive": true,
      };
      var response = await APIManager.addCoupon(data: data);
      if (response.data['status']) {
        Get.find<VipOffersController>().getCoupons();
        DialogHelper.showSuccess(StringConstant.vipOfferCreatedSuccessfully);
        showCreatedBottomSheet();
        titleController.text = '';
        validTillDateController.text = '';
        descriptionController.text = '';
        termsAndConditionsController.text = '';
        selectedTypeOfOffer.value = 0;
        selectedValidForOption.value = 0;
        Get.back();
        return true;
      }
      return false;
    } catch(e){
      print("Error: $e");
      rethrow;
    }
  }

  Future<bool> editCoupon(bool isActive) async {
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
      var response = await APIManager.editCoupon(
          Coupon(title: titleController.text,
              typeOfOffer: typeOfOffers[selectedTypeOfOffer.value],
              validFor: validForOptions[selectedValidForOption.value],
              validTill: validTillDateController.text,
              description: descriptionController.text,
              termsAndConditions: termsAndConditionsController.text.split('\n'),
              id: Get.find<VipOffersController>().selectedCoupon.value.id,
              isActive: isActive
          ), true
      );
      if (response.data['status']) {
        Get.find<VipOffersController>().getCoupons();
        DialogHelper.showSuccess(StringConstant.vipOfferEditedSuccessfully);
        showUpdatedBottomSheet();
        titleController.text = '';
        validTillDateController.text = '';
        descriptionController.text = '';
        termsAndConditionsController.text = '';
        selectedTypeOfOffer.value = 0;
        selectedValidForOption.value = 0;
        return true;
      }
      return false;
    } catch(e){
      print("Error: $e");
      rethrow;
    }
  }
}
