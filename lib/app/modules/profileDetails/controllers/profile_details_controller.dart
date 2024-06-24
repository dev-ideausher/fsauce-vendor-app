import 'package:flutter/cupertino.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import '';

class ProfileDetailsController extends GetxController {
  //TODO: Implement ProfileDetailsController

  Rx<RestaurantDetails> restaurantDetails = RestaurantDetails(
      restaurantName: '',
      restaurantLogo: '',
      restaurantBanner: '',
      location: '',
      avgPrice: 0,
      description: '',
      features: [],
      timing: [],
      media: []
  ).obs;

  void getRestaurantDetails() async{
    var response = await APIManager.getVendor();
    restaurantDetails.value = RestaurantDetails.fromJson(response.data["data"]);
    print("Below is the list of media urls of the restaurant.");
  }

  @override
  void onInit() {
    getRestaurantDetails();
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

  void gotoEditRestaurantDetailsScreen() {
    Get.toNamed(Routes.EDIT_RESTURANT_DETAILS);
  }

  void gotoFeaturesAndTimingScreen() {
    Get.toNamed(Routes.FEATURES_AND_TIMINGS);
  }

  void gotoAllPhotosAndVideos() {
    Get.toNamed(Routes.ALL_PHOTOS_AND_VIDEOS);
  }
}
