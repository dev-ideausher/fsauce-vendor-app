import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/allPhotosAndVideos/controllers/all_photos_and_videos_controller.dart';
import 'package:fsauce_vendor_app/app/modules/profileDetails/controllers/profile_details_controller.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditResturantDetailsController extends GetxController {
  //TODO: Implement EditResturantDetailsController

  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController averagePriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  RxString selectedBannerImage = ''.obs;
  RxString selectedLogoImage = ''.obs;

  Future<void> pickLogo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedLogoImage.value = pickedFile.path;
    }
  }

  Future<void> pickBanner() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedBannerImage.value = pickedFile.path;
    }
  }

  @override
  void onInit() {
    getInitialRestaurantDetails();
    super.onInit();
  }

  void getInitialRestaurantDetails(){
    RestaurantDetails details = Get.find<ProfileDetailsController>().restaurantDetails.value;
    restaurantNameController.text = details.restaurantName;
    addressController.text = details.location;
    averagePriceController.text = details.avgPrice.toString();
    descriptionController.text = details.description;
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> updateDetails() async{
    if(restaurantNameController.text.trim().isEmpty){
      DialogHelper.showError(StringConstant.resNameEmpty);
    }
    if(addressController.text.trim().isEmpty){
      DialogHelper.showError(StringConstant.addressNameEmpty);
    }
    if(averagePriceController.text.trim().isEmpty){
      DialogHelper.showError(StringConstant.avgPriceEmpty);
    }
    if(selectedLogoImage.isEmpty){
      DialogHelper.showError(StringConstant.selectedLogoImageEmpty);
    }
    if(selectedBannerImage.isEmpty){
      DialogHelper.showError(StringConstant.selectedBannerImageEmpty);
    }
    else{
      String logoUrl = ''; String bannerUrl = '';
      var uploadLogoResponse = await APIManager.uploadFile(filePath: selectedLogoImage.value);
      if(!uploadLogoResponse.data['status']){
        DialogHelper.showError(StringConstant.logoImageUploadError);
      } else if(uploadLogoResponse.data['status']){
        logoUrl = uploadLogoResponse.data['data'];
        var uploadBannerResponse = await APIManager.uploadFile(filePath: selectedLogoImage.value);
        if(!uploadBannerResponse.data['status']){
          DialogHelper.showError(StringConstant.bannerImageUploadError);
        } else if(uploadLogoResponse.data['status']){
          bannerUrl = uploadBannerResponse.data['data'];
          var response = await APIManager.updateVendor(
              restaurantDetails: RestaurantDetails(
                restaurantName: restaurantNameController.text,
                restaurantLogo: logoUrl,
                restaurantBanner: bannerUrl,
                location: addressController.text,
                avgPrice: int.parse(averagePriceController.text),
                description: descriptionController.text,
                features: Get.find<ProfileDetailsController>().restaurantDetails.value.features,
                timing: Get.find<ProfileDetailsController>().restaurantDetails.value.timing,
                media: Get.find<ProfileDetailsController>().restaurantDetails.value.media,
              )
          );
          if(response.data["status"]){
            restaurantNameController.text = "";
            addressController.text = "";
            averagePriceController.text = "";
            descriptionController.text = "";
            DialogHelper.showSuccess(StringConstant.detailsUpdatedSuccessfully);
            Get.find<ProfileDetailsController>().getRestaurantDetails();
          }
          else if(!response.data["status"]){
            DialogHelper.showError(StringConstant.anErrorOccurred);
          }
        }
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    restaurantNameController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    averagePriceController.dispose();
  }
}
