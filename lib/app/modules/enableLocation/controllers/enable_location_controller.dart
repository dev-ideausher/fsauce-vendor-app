import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/models/cuisine_model.dart';
import 'package:fsauce_vendor_app/app/models/feature_model.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/profileSetup/controllers/profile_setup_controller.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants/string_constant.dart';

class EnableLocationController extends GetxController {
  //TODO: Implement EnableLocationController

  Rx<RestaurantDetails> details = RestaurantDetails(
          restaurantName: "",
          restaurantLogo: "",
          restaurantBanner: "",
          location: "location",
          avgPrice: 0,
          description: "",
          features: [FeatureModel(id: "", name: "")],
          timing: [
            Timing(day: "", startTime: "", closeTime: "", isActive: false)
          ],
          media: [""],
          cuisine: [CuisineModel(id: "", name: "", image: "")],
          lat: "",
          lon: "")
      .obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getRestaurantDetails();
    super.onInit();
  }

  void gotoNavBar() {
    Get.offAllNamed(Routes.NAV_BAR);
  }

  String locationText = "";

  void getRestaurantDetails() async {
    var response = await APIManager.getVendor();
    details.value = RestaurantDetails.fromJson(response.data["data"]);
  }

  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      print("Location: ${Permission.location.value}");
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      locationText += "Lat: ${position.latitude} & Long: ${position.longitude}";
      try{
        var response = await APIManager.updateVendor(
            restaurantDetails: RestaurantDetails(
                restaurantName: details.value.restaurantName,
                restaurantLogo: details.value.restaurantLogo,
                restaurantBanner: details.value.restaurantBanner,
                location: details.value.location,
                avgPrice: details.value.avgPrice,
                description: details.value.description,
                features: details.value.features,
                timing: details.value.timing,
                media: details.value.media,
                cuisine: details.value.cuisine,
                lat: position.latitude.toString(),
                lon: position.longitude.toString()));
        if(response.statusCode == 200){
          print(locationText);
          gotoNavBar();
        } else{
          DialogHelper.showError(StringConstant.somethingWentWrong);
        }
      } catch(e){
        DialogHelper.showError(StringConstant.somethingWentWrong);
      }
    } else {
      Get.snackbar(StringConstant.permissionDenied,
          StringConstant.locationPermissionDenied);
    }
  }
}
