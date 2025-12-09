import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fsauce_vendor_app/app/components/filer_animated_options.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/cuisine_model.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/profileSetup/views/step_one.dart';
import 'package:fsauce_vendor_app/app/modules/profileSetup/views/step_three.dart';
import 'package:fsauce_vendor_app/app/modules/profileSetup/views/step_two.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../models/feature_model.dart';
import 'package:mime/mime.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import '../../../services/responsive_size.dart';

class ProfileSetupController extends GetxController {
  final stepCount = 0.obs;
  RxList<CuisineModel> selectedCuisines = <CuisineModel>[].obs;
  RxList<MultiSelectItem<CuisineModel>> multiSelectCuisines =
      <MultiSelectItem<CuisineModel>>[].obs;
  RxList<FeatureModel> features = <FeatureModel>[].obs;
  RxList<MultiSelectItem<FeatureModel>> multiSelectFeatures =
      <MultiSelectItem<FeatureModel>>[].obs;
  RxList<CuisineModel> cuisineModels = <CuisineModel>[].obs;

  final List<Widget> steps = [StepOne(), StepTwo(), StepThree()];

  final formKey = GlobalKey<FormState>();
  // final formKey1 = GlobalKey<FormState>();
  // final formKey2 = GlobalKey<FormState>();
  // final formKey3 = GlobalKey<FormState>();
  RxBool isRestLogoPicked = true.obs;
  RxBool isRestBannerPicked = true.obs;
  RxBool isCuisinePicked = true.obs;

  @override
  void onInit() {
    getFeatures();
    getCuisines();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    streetNameController.dispose();
    locationController.dispose();
    averagePriceController.dispose();
    cityNameController.dispose();
    postCodeController.dispose();
    descriptionController.dispose();
    restaurantNameController.dispose();
  }

  Future<void> getFeatures() async {
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

  Future<void> getCuisines() async {
    try {
      var response = await APIManager.getCuisines();
      if (response.data['status']) {
        List<dynamic> data = response.data['data'];
        cuisineModels.value = [];
        cuisineModels.value =
            data.map((e) => CuisineModel.fromJson(e)).toList();
        multiSelectCuisines.value = cuisineModels
            .map((e) => MultiSelectItem(e, e.name ?? "Unnamed Cuisine"))
            .toList();
      } else {
        Get.snackbar("Error", response.data['message']);
      }
    } catch (error) {
      Get.snackbar("Error", error.toString());
    }
  }

  void gotoEnableLocationScreen() async {
    DialogHelper.showLoading();

    for (var element in selectedFiles) {
      try {
        var response = await APIManager.uploadFile(filePath: element);
        if (response.statusCode == 200 && response.data != null) {
          selectedFilesUrl.add(response.data["data"]);
        }
      } catch (e) {
        debugPrint("Error uploading file: $e");
      }
    }

    bool isDataUpdated = await updateVendor();

    DialogHelper.hideDialog();

    if (isDataUpdated) {
      print(selectedFilesUrl);
      Get.offAllNamed(Routes.ENABLE_LOCATION);
    } else {
      Get.snackbar(StringConstant.error, StringConstant.somethingWentWrong);
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
      restaurantLogo: restaurantLogoUrl,
      restaurantBanner: restaurantBannerUrl,
      location: "${streetNameController.text} ${cityNameController.text}",
      //locationController.text.trim()
      avgPrice: int.parse(averagePriceController.text.trim()),
      description: descriptionController.text.trim(),
      features: selectedFeatures,
      lat: "",
      lon: "",
      timing: timings,
      media: selectedFilesUrl,
      cuisine: selectedCuisines,
    ));

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
  TextEditingController streetNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();

  void increment() => stepCount.value++;

  Future<void> pickImage(RxString imagePath, bool restBannerImage) async {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(
                StringConstant.camera,
                style: TextStyleUtil.manrope16w500(),
              ),
              onTap: () {
                Get.back();
                _pickImageFromSource(
                    imagePath, restBannerImage, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(
                StringConstant.gallery,
                style: TextStyleUtil.manrope16w500(),
              ),
              onTap: () {
                Get.back();
                _pickImageFromSource(
                    imagePath, restBannerImage, ImageSource.gallery);
              },
            ),
            SizedBox(height: 100.kh),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromSource(
      RxString imagePath, bool restBannerImage, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: source, imageQuality: 50);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      if (restBannerImage) {
        isRestBannerPicked.value = true;
      } else {
        isRestLogoPicked.value = true;
      }
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

  RxList<FeatureModel> selectedFeatures = <FeatureModel>[].obs;

  RxList<String> selectedFiles = <String>[].obs;

  List<String> selectedFilesUrl = <String>[];

  Future<void> pickMultipleFiles() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultipleMedia();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      selectedFiles.clear();
      DialogHelper.showLoading();
      for (var file in pickedFiles) {
        String compressedPath = await compressFile(file.path);
        selectedFiles.add(compressedPath);
      }
      DialogHelper.hideDialog();
    }
  }

  Future<String> compressFile(String path) async {
    if (!isImage(path)) {
      return path;
    }

    try {
      final String targetPath =
          '${Directory.systemTemp.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      var result = await FlutterImageCompress.compressAndGetFile(
        path,
        targetPath,
        quality: 60,
      );
      return result?.path ?? path;
    } catch (e) {
      return path;
    }
  }

  bool isImage(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType!.startsWith('image/');
  }

  String restaurantLogoUrl = "";
  String restaurantBannerUrl = "";

  void gotoNextStep() async {
    if (stepCount.value == 0 &&
        restaurantLogo.isNotEmpty &&
        restaurantBanner.isNotEmpty) {
      DialogHelper.showLoading();
      try {
        var response1 =
            await APIManager.uploadFile(filePath: restaurantLogo.value);
        var response2 =
            await APIManager.uploadFile(filePath: restaurantBanner.value);

        restaurantLogoUrl = response1.data["data"];
        restaurantBannerUrl = response2.data["data"];

        DialogHelper.hideDialog();
        increment();
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      increment();
    }
  }

  String? restaurantNameValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return StringConstant.restaurantNameCannotBeEmpty;
    }
    return null; // Return null if the value is valid
  }

  String? pricingValidator(String? val) {
    if (val == null || val.isEmpty) {
      return "Average price for 2 cannot be empty!";
    }
    // Check if input is a valid number
    final numValue = int.tryParse(val);
    if (numValue == null) {
      return "Invalid price! Please enter a valid number.";
    }
    if (numValue <= 0) {
      return "Average price for 2 cannot be zero or negative!";
    }
    return null;
  }

  void validateStepOneFields() {
    isRestLogoPicked.value = restaurantLogo.value.isNotEmpty;
    isRestBannerPicked.value = restaurantBanner.value.isNotEmpty;
    isCuisinePicked.value = selectedCuisines.value.isNotEmpty;

    // Check if all fields are valid
    if (formKey.currentState!.validate() &&
        isRestLogoPicked.value &&
        isRestBannerPicked.value &&
        isCuisinePicked.value) {
      stepCount.value < 2 ? gotoNextStep() : gotoEnableLocationScreen();
    } else {
      if (!isRestLogoPicked.value) {
        isRestLogoPicked.value = false;
      }
      if (!isRestBannerPicked.value) {
        isRestBannerPicked.value = false;
      }
      if (!isCuisinePicked.value) {
        isCuisinePicked.value = false;
      }
      Get.snackbar("Error", "Please fill all the required fields to proceed");
    }
  }

  void validateStepTwoFields() {
    bool isTimingSelected =
        timingControllers.values.any((element) => element.isActivated);
    if (selectedFeatures.isEmpty) {
      Get.snackbar("Error", StringConstant.emptyFeatures);
    } else if (!isTimingSelected) {
      Get.snackbar("Error", StringConstant.plsSelectFeaturesAndTimings);
    } else {
      stepCount.value < 2 ? gotoNextStep() : gotoEnableLocationScreen();
    }
  }
}
