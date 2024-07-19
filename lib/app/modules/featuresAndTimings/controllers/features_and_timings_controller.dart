import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/components/filer_animated_options.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/modules/profileDetails/controllers/profile_details_controller.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:intl/src/intl/date_format.dart';

import '../../../models/feature_model.dart';

class FeaturesAndTimingsController extends GetxController {
  //TODO: Implement FeaturesAndTimingsController

  RxList<FeatureModel> features = <FeatureModel>[].obs;
  RxList<MultiSelectItem<FeatureModel>> multiSelectFeatures = <MultiSelectItem<FeatureModel>>[].obs;

  RxList<FeatureModel> selectedFeatures = <FeatureModel>[].obs;

  @override
  void onInit() {
    getFeatures();
    getFeaturesAndTimings();
    super.onInit();
  }

  @override
  void onReady() {
    selectedFeatures.value =
        Get.find<HomeController>().restaurantDetails.value.features;
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  
  Future<void> getFeatures() async{
    RestaurantDetails details =
        Get.find<HomeController>().restaurantDetails.value;
    if (details.features.isNotEmpty) {
      selectedFeatures.value = [];
      selectedFeatures.value = details.features;
    }
    print(selectedFeatures.length);
    try{
      var response = await APIManager.getFeatures();
      if(response.data['status']){
        List<dynamic> data = response.data['data'];
        features.value = [];
        features.value = data.map((e) => FeatureModel.fromJson(e)).toList();
        multiSelectFeatures.value = features.map((e) => MultiSelectItem<FeatureModel>(e, e.name!)).toList();
      } else{
        DialogHelper.showError(response.data['message']);
      }
    } catch(error){
      DialogHelper.showError(error.toString());
    }
  }

  Map<String, FilterOptionController> timingControllers = {
    "Monday": FilterOptionController(),
    "Tuesday": FilterOptionController(),
    "Wednesday": FilterOptionController(),
    "Thursday": FilterOptionController(),
    "Friday": FilterOptionController(),
    "Saturday": FilterOptionController(),
    "Sunday": FilterOptionController(),
  };

  void getFeaturesAndTimings() {
    RestaurantDetails details =
        Get.find<HomeController>().restaurantDetails.value;
    if (details.timing.isNotEmpty) {
      for (Timing timing in details.timing) {
        timingControllers.forEach((String e, FilterOptionController optionController){
          if (e == "Monday" && timing.day == "Monday") {
            optionController.isActivated = timing.isActive;
            optionController.openingTime = TimeOfDay(
                hour: int.parse(timing.startTime.substring(0, 2)),
                minute: int.parse(timing.startTime.substring(3, 4)));
            optionController.closingTime = TimeOfDay(
                hour: int.parse(timing.closeTime.substring(0, 2)),
                minute: int.parse(timing.closeTime.substring(3, 4)));
          } else if (e == "Tuesday" && timing.day == "Tuesday") {
            optionController.isActivated = timing.isActive;
            optionController.openingTime = TimeOfDay(
                hour: int.parse(timing.startTime.substring(0, 2)),
                minute: int.parse(timing.startTime.substring(3, 4)));
            optionController.closingTime = TimeOfDay(
                hour: int.parse(timing.closeTime.substring(0, 2)),
                minute: int.parse(timing.closeTime.substring(3, 4)));
          } else if (e == "Wednesday" && timing.day == "Wednesday") {
            optionController.isActivated = timing.isActive;
            optionController.openingTime = TimeOfDay(
                hour: int.parse(timing.startTime.substring(0, 2)),
                minute: int.parse(timing.startTime.substring(3, 4)));
            optionController.closingTime = TimeOfDay(
                hour: int.parse(timing.closeTime.substring(0, 2)),
                minute: int.parse(timing.closeTime.substring(3, 4)));
          } else if (e == "Thursday" && timing.day == "Thursday") {
            optionController.isActivated = timing.isActive;
            optionController.openingTime = TimeOfDay(
                hour: int.parse(timing.startTime.substring(0, 2)),
                minute: int.parse(timing.startTime.substring(3, 4)));
            optionController.closingTime = TimeOfDay(
                hour: int.parse(timing.closeTime.substring(0, 2)),
                minute: int.parse(timing.closeTime.substring(3, 4)));
          } else if (e == "Friday" && timing.day == "Friday") {
            optionController.isActivated = timing.isActive;
            optionController.openingTime = TimeOfDay(
                hour: int.parse(timing.startTime.substring(0, 2)),
                minute: int.parse(timing.startTime.substring(3, 4)));
            optionController.closingTime = TimeOfDay(
                hour: int.parse(timing.closeTime.substring(0, 2)),
                minute: int.parse(timing.closeTime.substring(3, 4)));
          } else if (e == "Saturday" && timing.day == "Saturday") {
            optionController.isActivated = timing.isActive;
            optionController.openingTime = TimeOfDay(
                hour: int.parse(timing.startTime.substring(0, 2)),
                minute: int.parse(timing.startTime.substring(3, 4)));
            optionController.closingTime = TimeOfDay(
                hour: int.parse(timing.closeTime.substring(0, 2)),
                minute: int.parse(timing.closeTime.substring(3, 4)));
          } else if (e == "Sunday" && timing.day == "Sunday") {
            optionController.isActivated = timing.isActive;
            optionController.openingTime = TimeOfDay(
                hour: int.parse(timing.startTime.substring(0, 2)),
                minute: int.parse(timing.startTime.substring(3, 4)));
            optionController.closingTime = TimeOfDay(
                hour: int.parse(timing.closeTime.substring(0, 2)),
                minute: int.parse(timing.closeTime.substring(3, 4)));
          }
        });
      }
    }
  }

  Future<void> updateFeaturesAndTimings() async {
    List<Timing> timings = timingControllers.entries
        .map<Timing>((entry) => Timing(
              day: entry.key,
              isActive: entry.value.isActivated,
              closeTime: DateFormat('hh:mm a').format(
                DateTime(
                  0,
                  0,
                  0,
                  entry.value.closingTime.hour,
                  entry.value.closingTime.minute,
                ),
              ),
              startTime: DateFormat('hh:mm a').format(
                DateTime(
                  0,
                  0,
                  0,
                  entry.value.openingTime.hour,
                  entry.value.openingTime.minute,
                ),
              ),
            ))
        .toList();
    Get.find<HomeController>().getRestaurantDetails();
    RestaurantDetails details =
        Get.find<HomeController>().restaurantDetails.value;
    var response = await APIManager.updateVendor(
        restaurantDetails: RestaurantDetails(
      restaurantName: details.restaurantName,
      restaurantLogo: details.restaurantLogo,
      restaurantBanner: details.restaurantBanner,
      location: details.location,
      avgPrice: details.avgPrice,
      description: details.description,
      features: selectedFeatures,
      timing: timings,
      media: details.media,
          cuisine: details.cuisine,
    ));
    if (response.data['status']) {
      Get.find<HomeController>().getRestaurantDetails();
      Get.back();
      DialogHelper.showSuccess(
          StringConstant.featuresAndTimingsAddedSuccessfully);
      Get.bottomSheet(const AddedSuccessfullBottomSheet(
          subTitle: StringConstant.featuresAndTimingsAddedSuccessfully));
    } else {
      DialogHelper.showError(StringConstant.anErrorOccurred);
    }
  }
}
