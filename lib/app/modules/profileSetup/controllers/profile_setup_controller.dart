import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/filer_animated_options.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/profileSetup/views/step_one.dart';
import 'package:fsauce_vendor_app/app/modules/profileSetup/views/step_three.dart';
import 'package:fsauce_vendor_app/app/modules/profileSetup/views/step_two.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:fsauce_vendor_app/app/services/dio/client.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class ProfileSetupController extends GetxController {
  final stepCount = 0.obs;
  final List<Widget> steps = [
    const StepOne(),
    const StepTwo(),
    const StepThree()
  ];

  @override
  void onInit() {
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

  void gotoEnableLocationScreen() async {
    DialogHelper.showLoading();

    // Create a list of upload futures
    List<Future<void>> uploadFutures = selectedFiles.map((element) async {
      var response = await APIManager.uploadFile(filePath: element);
      selectedFilesUrl.add(response.data["data"]);
    }).toList();

    // Wait for all uploads to complete
    await Future.wait(uploadFutures);

    bool isDataUpdated = await updateVendor();

    DialogHelper.hideDialog();

    if (isDataUpdated) {
      print(selectedFilesUrl);
      Get.toNamed(Routes.ENABLE_LOCATION);
    } else {
      Get.snackbar("Error", "Something went wrong!");
    }
  }

  Future<bool> updateVendor() async {
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

    var response = await APIManager.updateVendor(
        restaurantDetails: RestaurantDetails(
            restaurantName: restaurantNameController.text.trim(),
            restaurantLogo: restaurantLogo.value,
            restaurantBanner: restaurantBanner.value,
            location: locationController.text.trim(),
            avgPrice: int.parse(averagePriceController.text.trim()),
            description: descriptionController.text.trim(),
            features: featureItems.map((e) => e.value).toList(),
            timing: timings,
            media: selectedFilesUrl));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  TextEditingController restaurantNameController = TextEditingController();
  RxString restaurantLogo = "".obs;
  RxString restaurantBanner = "".obs;
  TextEditingController locationController = TextEditingController();
  TextEditingController averagePriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void increment() => stepCount.value++;

  Future<void> pickImage(RxString imagePath) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

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

  List<String> selectedFeatures = [];

  RxList<String> selectedFiles = <String>[].obs;

  List<String> selectedFilesUrl = <String>[];

  Future<void> pickMultipleFiles() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      selectedFiles.clear();
      selectedFiles.addAll(pickedFiles.map((file) => file.path));
    }
  }

  String restaurantLogoUrl = "";
  String restaurantBannerUrl = "";

  void gotoNextStep() async {
    if (stepCount.value == 0) {
      DialogHelper.showLoading();
      try{
        var response1 =
        await APIManager.uploadFile(filePath: restaurantLogo.value);
        var response2 =
        await APIManager.uploadFile(filePath: restaurantBanner.value);

        restaurantLogoUrl = response1.data["data"];
        restaurantBannerUrl = response2.data["data"];

        print(restaurantBannerUrl);
        DialogHelper.hideDialog();
        increment();
      } catch(e) {
        debugPrint(e.toString());
      }
    } else {
      increment();
    }
  }
}
