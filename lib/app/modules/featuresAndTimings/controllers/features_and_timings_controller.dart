import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/components/filer_animated_options.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:intl/intl.dart';

import '../../../models/feature_model.dart';

/// Parses vendor timing strings such as `06:00 PM`, `6:09 AM`, or compact `9AM` / `9 am`.
TimeOfDay _parseTimingToTimeOfDay(String raw) {
  final spaced = raw.trim().replaceAll(RegExp(r'\s+'), ' ');

  // Hour-only compact forms ("9AM", "9 am") blow up old code: substring(0,2) becomes "9a".
  // Only branch when there's no ':' (avoids ambiguity with malformed values).
  if (!spaced.contains(':')) {
    final compact =
        spaced.replaceAll(RegExp(r'\s+'), '').toUpperCase(); // e.g. 9AM, 11PM
    final hm = RegExp(r'^(\d{1,2})(AM|PM)$').firstMatch(compact);
    if (hm != null) {
      try {
        final dt = DateFormat(
          'ha',
          'en_US',
        ).parseStrict('${hm.group(1)}${hm.group(2)}');
        return TimeOfDay(hour: dt.hour, minute: dt.minute);
      } catch (_) {}
    }
  }

  const patterns = [
    'hh:mm a',
    'h:mm a',
    'HH:mm:ss',
    'H:mm:ss',
    'HH:mm',
    'H:mm',
  ];
  for (final pattern in patterns) {
    try {
      final dt = DateFormat(pattern, 'en_US').parseStrict(spaced);
      return TimeOfDay(hour: dt.hour, minute: dt.minute);
    } catch (_) {
      try {
        final dt = DateFormat(pattern, 'en_US').parse(spaced);
        return TimeOfDay(hour: dt.hour, minute: dt.minute);
      } catch (_) {}
    }
  }
  debugPrint('Could not parse time label "$raw", defaulting to 12:00');
  return const TimeOfDay(hour: 12, minute: 0);
}

class FeaturesAndTimingsController extends GetxController {
  //TODO: Implement FeaturesAndTimingsController

  RxList<FeatureModel> features = <FeatureModel>[].obs;
  RxList<MultiSelectItem<FeatureModel>> multiSelectFeatures =
      <MultiSelectItem<FeatureModel>>[].obs;
  RxList<FeatureModel> selectedFeatures = <FeatureModel>[].obs;

  RxBool isFeatureSelected = false.obs;

  @override
  void onInit() {
    getFeatures();
    getFeaturesAndTimings();
    super.onInit();
  }

  Future<void> getFeatures() async {
    RestaurantDetails details =
        Get.find<HomeController>().restaurantDetails.value;
    if (details.features.isNotEmpty) {
      selectedFeatures.value = [];
      selectedFeatures.value = details.features;
    }
    debugPrint(selectedFeatures.length.toString());
    try {
      var response = await APIManager.getFeatures();
      if (response.data['status']) {
        List<dynamic> data = response.data['data'];

        features.value = data.map((e) => FeatureModel.fromJson(e)).toList();

        multiSelectFeatures.value = features
            .map(
              (e) => MultiSelectItem<FeatureModel>(
                e,
                e.name ?? "Unnamed Feature",
              ),
            )
            .toList();
      } else {
        Get.snackbar("Error", response.data['message']);
      }
    } catch (error) {
      Get.snackbar("Error", error.toString());
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
        timingControllers
            .forEach((String e, FilterOptionController optionController) {
          if (e == "Monday" && timing.day == "Monday") {
            optionController.isActivated = timing.isActive;
            optionController.openingTime =
                _parseTimingToTimeOfDay(timing.startTime);
            optionController.closingTime =
                _parseTimingToTimeOfDay(timing.closeTime);
          } else if (e == "Tuesday" && timing.day == "Tuesday") {
            optionController.isActivated = timing.isActive;
            optionController.openingTime =
                _parseTimingToTimeOfDay(timing.startTime);
            optionController.closingTime =
                _parseTimingToTimeOfDay(timing.closeTime);
          } else if (e == "Wednesday" && timing.day == "Wednesday") {
            optionController.isActivated = timing.isActive;
            optionController.openingTime =
                _parseTimingToTimeOfDay(timing.startTime);
            optionController.closingTime =
                _parseTimingToTimeOfDay(timing.closeTime);
          } else if (e == "Thursday" && timing.day == "Thursday") {
            optionController.isActivated = timing.isActive;
            optionController.openingTime =
                _parseTimingToTimeOfDay(timing.startTime);
            optionController.closingTime =
                _parseTimingToTimeOfDay(timing.closeTime);
          } else if (e == "Friday" && timing.day == "Friday") {
            optionController.isActivated = timing.isActive;
            optionController.openingTime =
                _parseTimingToTimeOfDay(timing.startTime);
            optionController.closingTime =
                _parseTimingToTimeOfDay(timing.closeTime);
          } else if (e == "Saturday" && timing.day == "Saturday") {
            optionController.isActivated = timing.isActive;
            optionController.openingTime =
                _parseTimingToTimeOfDay(timing.startTime);
            optionController.closingTime =
                _parseTimingToTimeOfDay(timing.closeTime);
          } else if (e == "Sunday" && timing.day == "Sunday") {
            optionController.isActivated = timing.isActive;
            optionController.openingTime =
                _parseTimingToTimeOfDay(timing.startTime);
            optionController.closingTime =
                _parseTimingToTimeOfDay(timing.closeTime);
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
      lat: details.lat,
      lon: details.lon,
    ));
    if (response.data['status']) {
      Get.find<HomeController>().getRestaurantDetails();
      Get.back();
      DialogHelper.showSuccess(
          StringConstant.featuresAndTimingsAddedSuccessfully);
      Get.bottomSheet(const AddedSuccessfullBottomSheet(
          subTitle: StringConstant.featuresAndTimingsAddedSuccessfully));
    } else {
      Get.snackbar("Error", StringConstant.anErrorOccurred);
    }
  }
}
