import 'package:flutter/cupertino.dart';
import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/coupon_model.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/controllers/vip_offers_controller.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  RxString selectedCouponImage = ''.obs;

  DateTime scheduledDate = DateTime.now();

  RxString couponImageLink = "".obs;

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
  void onClose() {
    super.onClose();
    titleController.dispose();
    descriptionController.dispose();
    termsAndConditionsController.dispose();
    validTillDateController.dispose();
    scheduleDateController.dispose();
    scheduleTimeController.dispose();
  }

  Future<void> pickCouponImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedCouponImage.value = pickedFile.path;
    }
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
      couponImageLink.value = coupon.image;
      if(coupon.isSheduled! && coupon.sheduleDate!.isNotEmpty){
        scheduleDateController.value = TextEditingValue(text: coupon.sheduleDate!.substring(0, 10));
      }
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

  Future<void> addCoupon() async {
    if (titleController.text
        .trim()
        .isEmpty) {
      DialogHelper.showError("Title can't be empty");
      return;
    }
    if(selectedCouponImage.isEmpty){
      DialogHelper.showError(StringConstant.emptyCouponImage);
      return;
    }
    if (validTillDateController.text.isEmpty) {
      DialogHelper.showError("Please select a date");
      return;
    }
    if (descriptionController.text.isEmpty) {
      DialogHelper.showError("Description can't be empty");
      return;
    }
    if (termsAndConditionsController.text.isEmpty) {
      DialogHelper.showError("Terms and conditions can't be empty");
      return;
    }
    else{
      String couponImageLink = "";
      try{
        var uploadCouponImageResponse = await APIManager.uploadFile(filePath: selectedCouponImage.value);
        if(!uploadCouponImageResponse.data['status']){
          DialogHelper.showError(StringConstant.anErrorOccurred);
          return;
        } else if(uploadCouponImageResponse.data['status']){
          couponImageLink = uploadCouponImageResponse.data['data'];
          bool isSheduled = false; String sheduledDate = "";
          if(scheduleDateController.text.isNotEmpty){
            isSheduled = true;
            sheduledDate = scheduledDate.toString();
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
              "isSheduled": isSheduled ?? "",
              "sheduleDate": sheduledDate,
              "image": couponImageLink,
            };
            var response = await APIManager.addCoupon(data: data);
            if (response.data['status']) {
              Get.find<VipOffersController>().getCoupons();
              Get.back();
              DialogHelper.showSuccess(StringConstant.vipOfferCreatedSuccessfully);
              showCreatedBottomSheet();
              titleController.text = '';
              validTillDateController.text = '';
              descriptionController.text = '';
              termsAndConditionsController.text = '';
              selectedTypeOfOffer.value = 0;
              selectedValidForOption.value = 0;
              selectedCouponImage.value = "";
              return;
            }
          } catch(e){
            print("Error: $e");
            rethrow;
          }
        }
      } catch(e){
        print("Error: $e");
        rethrow;
      }
    }
  }

  Future<void> editCoupon(bool isActive) async {
    if (titleController.text
        .trim()
        .isEmpty) {
      DialogHelper.showError("Title can't be empty");
      return;
    }
    if (validTillDateController.text.isEmpty) {
      DialogHelper.showError("Please select a date");
      return;
    }
    if (descriptionController.text.isEmpty) {
      DialogHelper.showError("Description can't be empty");
      return;
    }
    if(selectedCouponImage.isEmpty && couponImageLink.isEmpty){
      DialogHelper.showError(StringConstant.emptyCouponImage);
      return;
    }
    if (termsAndConditionsController.text.isEmpty) {
      DialogHelper.showError("Terms and conditions can't be empty");
      return;
    }
    try{
      if(couponImageLink.isEmpty){
        String selectedCouponImageLink = "";
        try{
          var uploadResponse = await APIManager.uploadFile(filePath: selectedCouponImage.value);
          if(uploadResponse.data['status']){
            selectedCouponImageLink = uploadResponse.data['data'];
            bool isSheduled = false; String sheduledDate = "";
            if(scheduleDateController.text.isNotEmpty){
              isSheduled = true;
              sheduledDate = scheduledDate.toString();
            }
            var response = await APIManager.editCoupon(
                Coupon(title: titleController.text,
                  typeOfOffer: typeOfOffers[selectedTypeOfOffer.value],
                  validFor: validForOptions[selectedValidForOption.value],
                  validTill: validTillDateController.text,
                  description: descriptionController.text,
                  termsAndConditions: termsAndConditionsController.text.split('\n'),
                  id: Get.find<VipOffersController>().selectedCoupon.value.id,
                  isActive: isActive,
                  image: selectedCouponImageLink,
                  isSheduled: isSheduled,
                  sheduleDate: sheduledDate ?? "",
                ), true
            );
            if (response.data['status']) {
              Get.find<VipOffersController>().getCoupons();
              Get.back();
              DialogHelper.showSuccess(StringConstant.vipOfferEditedSuccessfully);
              showUpdatedBottomSheet();
              titleController.text = '';
              validTillDateController.text = '';
              descriptionController.text = '';
              termsAndConditionsController.text = '';
              selectedTypeOfOffer.value = 0;
              selectedCouponImage.value = "";
              selectedValidForOption.value = 0;
            }
          }
          else if(!uploadResponse.data['status']){
            DialogHelper.showError(StringConstant.anErrorOccurred);
            return;
          }
        } catch(e){
          print("Error: $e");
          rethrow;
        }
      } else if(couponImageLink.isNotEmpty){
        bool isSheduled = false; String sheduledDate = "";
        if(scheduleDateController.text.isNotEmpty){
          isSheduled = true;
          sheduledDate = scheduledDate.toString();
        }
        var response = await APIManager.editCoupon(
            Coupon(title: titleController.text,
              typeOfOffer: typeOfOffers[selectedTypeOfOffer.value],
              validFor: validForOptions[selectedValidForOption.value],
              validTill: validTillDateController.text,
              description: descriptionController.text,
              termsAndConditions: termsAndConditionsController.text.split('\n'),
              id: Get.find<VipOffersController>().selectedCoupon.value.id,
              isActive: isActive,
              image: couponImageLink.value,
              isSheduled: isSheduled,
              sheduleDate: sheduledDate ?? "",
            ), true
        );
        if (response.data['status']) {
          Get.find<VipOffersController>().getCoupons();
          Get.back();
          DialogHelper.showSuccess(StringConstant.vipOfferEditedSuccessfully);
          showUpdatedBottomSheet();
          titleController.text = '';
          validTillDateController.text = '';
          descriptionController.text = '';
          termsAndConditionsController.text = '';
          selectedTypeOfOffer.value = 0;
          selectedCouponImage.value = "";
          selectedValidForOption.value = 0;
          return;
        }
      }
    } catch(e){
      print("Error: $e");
      rethrow;
    }
  }
}
