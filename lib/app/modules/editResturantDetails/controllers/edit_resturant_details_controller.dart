import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/allPhotosAndVideos/controllers/all_photos_and_videos_controller.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/modules/profileDetails/controllers/profile_details_controller.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/cuisine_model.dart';

class EditResturantDetailsController extends GetxController {
  //TODO: Implement EditResturantDetailsController

  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController averagePriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cuisineController = TextEditingController();

  RxString selectedBannerImage = ''.obs;
  RxString selectedLogoImage = ''.obs;
  RxString selectedCuisineType = "".obs;
  RxList<CuisineModel> initialCuisineModels = <CuisineModel>[].obs;
  RxList<CuisineModel> cuisines = <CuisineModel>[].obs;
  Rx<CuisineModel> selectedCuisine = CuisineModel(id: "id", name: "name", image: "").obs;
  // List<DropdownMenuItem<CuisineModel>> cuisineOptions = <DropdownMenuItem<CuisineModel>>[];
  final formKey = GlobalKey<FormState>();

  String restaurantLogo = "";
  String restaurantBanner = "";

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
    getCuisines();
    getInitialRestaurantDetails();
    super.onInit();
  }

  Future<void> getCuisines() async{
    try{
      var response = await APIManager.getCuisines();
      if(response.data['status']){
        List<dynamic> data = response.data['data'];
        cuisines.value = [];
        cuisines.value = data.map((e) => CuisineModel.fromJson(e)).toList();
      } else{
        DialogHelper.showError(response.data['message']);
      }
    } catch(error){
      DialogHelper.showError(error.toString());
    }
  }

  void getInitialRestaurantDetails(){
    RestaurantDetails details = Get.find<HomeController>().restaurantDetails.value;
    restaurantNameController.text = details.restaurantName;
    addressController.text = details.location;
    averagePriceController.text = details.avgPrice.toString();
    descriptionController.text = details.description;
    initialCuisineModels.value = [details.cuisine.first];
    print("selected cuisine of the user: ${details.cuisine.first.name}");
    restaurantLogo = details.restaurantLogo;
    restaurantBanner = details.restaurantBanner;
  }

  Future<String> uploadRestaurantMedia(String filePath) async{
    String fileUrl = "";
    try{
      var response = await APIManager.uploadFile(filePath: filePath);
      if(response.data['status']){
        fileUrl = response.data['data'];
      }
    } catch(e){
      print("An error occurred while uploading logo! $e");
      DialogHelper.showError(StringConstant.somethingWentWrong);
    }
    return fileUrl;
  }

  Future<void> updateDetails() async{
    if(restaurantNameController.text.trim().isEmpty){
      DialogHelper.showError(StringConstant.resNameEmpty);
      return;
    }
    if(addressController.text.trim().isEmpty){
      DialogHelper.showError(StringConstant.addressNameEmpty);
      return;
    }
    if(averagePriceController.text.trim().isEmpty){
      DialogHelper.showError(StringConstant.avgPriceEmpty);
      return;
    }
    if(selectedLogoImage.isEmpty && Get.find<HomeController>().restaurantDetails.value.restaurantLogo.isEmpty){
      DialogHelper.showError(StringConstant.selectedLogoImageEmpty);
      return;
    }
    if(selectedBannerImage.isEmpty && Get.find<HomeController>().restaurantDetails.value.restaurantBanner.isEmpty){
      DialogHelper.showError(StringConstant.selectedBannerImageEmpty);
      return;
    }
    else if(restaurantNameController.text.trim().isNotEmpty && addressController.text.isNotEmpty && averagePriceController.text.isNotEmpty){
      try{
        String logoUrl = restaurantLogo;
        String bannerUrl = restaurantBanner;
        if(selectedLogoImage.isNotEmpty){
          logoUrl = await uploadRestaurantMedia(selectedLogoImage.value);
        }
        else if(selectedBannerImage.isNotEmpty){
          bannerUrl = await uploadRestaurantMedia(selectedBannerImage.value);
        }
        var response = await APIManager.updateVendor(
            restaurantDetails: RestaurantDetails(
              restaurantName: restaurantNameController.text,
              restaurantLogo: logoUrl,
              restaurantBanner: bannerUrl,
              location: addressController.text,
              avgPrice: int.parse(averagePriceController.text),
              description: descriptionController.text,
              features: Get.find<HomeController>().restaurantDetails.value.features,
              timing: Get.find<HomeController>().restaurantDetails.value.timing,
              media: Get.find<HomeController>().restaurantDetails.value.media,
              lat: Get.find<HomeController>().restaurantDetails.value.lat,
              lon: Get.find<HomeController>().restaurantDetails.value.lon,
              cuisine: initialCuisineModels,
            )
        );
        if(response.data["status"]){
          restaurantNameController.text = "";
          addressController.text = "";
          averagePriceController.text = "";
          descriptionController.text = "";
          selectedBannerImage.value = "";
          selectedLogoImage.value = "";
          Get.back();
          DialogHelper.showSuccess(StringConstant.detailsUpdatedSuccessfully);
          Get.find<HomeController>().getRestaurantDetails();
          return;
        }
        else if(!response.data["status"]){
          DialogHelper.showError(StringConstant.anErrorOccurred);
          return;
        }
      } catch(e){
        print("An error occurred while editing profile!: $e");
        DialogHelper.showError(StringConstant.anErrorOccurred);
        return;
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
    cuisineController.dispose();
  }
}
