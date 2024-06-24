import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/components/filer_animated_options.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/profileDetails/controllers/profile_details_controller.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:intl/src/intl/date_format.dart';

class FeaturesAndTimingsController extends GetxController {
  //TODO: Implement FeaturesAndTimingsController

  List<MultiSelectItem<String>> featureItems = [
    MultiSelectItem(StringConstant.dineIn, StringConstant.dineIn),
    MultiSelectItem(StringConstant.takeAway, StringConstant.takeAway),
    MultiSelectItem(StringConstant.parking, StringConstant.parking),
    MultiSelectItem(StringConstant.wifi, StringConstant.wifi),
  ];

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
    Get.find<ProfileDetailsController>().getRestaurantDetails();
    RestaurantDetails details =
        Get.find<ProfileDetailsController>().restaurantDetails.value;
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
    if (details.features.isNotEmpty) {
      details.features.forEach((String feature) {
        selectedFeatures.add(feature);
      });
    }
  }

  List<String> selectedFeatures = [];

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
    Get.find<ProfileDetailsController>().getRestaurantDetails();
    RestaurantDetails details =
        Get.find<ProfileDetailsController>().restaurantDetails.value;
    var response = await APIManager.updateVendor(
        restaurantDetails: RestaurantDetails(
      restaurantName: details.restaurantName,
      restaurantLogo: details.restaurantLogo,
      restaurantBanner: details.restaurantBanner,
      location: details.location,
      avgPrice: details.avgPrice,
      description: details.description,
      features: featureItems.map((e) => e.value).toList(),
      timing: timings,
      media: details.media,
    ));
    if (response.data['status']) {
      Get.find<ProfileDetailsController>().getRestaurantDetails();
      Get.back();
      DialogHelper.showSuccess(
          StringConstant.featuresAndTimingsAddedSuccessfully);
      Get.bottomSheet(const AddedSuccessfullBottomSheet(
          subTitle: StringConstant.featuresAndTimingsAddedSuccessfully));
    } else {
      DialogHelper.showError(StringConstant.anErrorOccurred);
    }
  }

  @override
  void onInit() {
    getFeaturesAndTimings();
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
}
