import 'package:flutter/cupertino.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import '';

class ProfileDetailsController extends GetxController {
  //TODO: Implement ProfileDetailsController

  @override
  void onInit() {
    Get.find<HomeController>().getRestaurantDetails();
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
