import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_picker/map_picker.dart';

import '../../../models/cuisine_model.dart';

class EditResturantDetailsController extends GetxController {
  final RxDouble resturLat = 0.0.obs;
  final RxDouble resturLong = 0.0.obs;
  GoogleMapController? mapController;
  final mapCompleter = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();
  CameraPosition cameraPosition =
  const CameraPosition(target: LatLng(25.9397, 81.70757), zoom: 14.4746);
  //TODO: Implement EditResturantDetailsController

  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString addressText = ''.obs; // Observable address for reactive UI
  TextEditingController averagePriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cuisineController = TextEditingController();

  RxString selectedBannerImage = ''.obs;
  RxString selectedLogoImage = ''.obs;
  RxString selectedCuisineType = "".obs;
  RxList<CuisineModel> initialCuisineModels = <CuisineModel>[].obs;
  RxList<CuisineModel> cuisines = <CuisineModel>[].obs;
  Rx<CuisineModel> selectedCuisine =
      CuisineModel(id: "id", name: "name", image: "").obs;
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

  Future<void> getCuisines() async {
    try {
      var response = await APIManager.getCuisines();
      if (response.data['status']) {
        List<dynamic> data = response.data['data'];
        cuisines.value = [];
        cuisines.value = data.map((e) => CuisineModel.fromJson(e)).toList();
      } else {
        Get.snackbar("Error", response.data['message']);
      }
    } catch (error) {
      Get.snackbar("Error", error.toString());
    }
  }

  Future<void> getInitialRestaurantDetails() async {
    try {
      // Fetch latest data from API
      var response = await APIManager.getVendor();
      
      if (response.statusCode == 200 && response.data['status']) {
        RestaurantDetails details = RestaurantDetails.fromJson(response.data['data']);
        
        // Update text controllers with latest data
        restaurantNameController.text = details.restaurantName;
        addressController.text = details.location;
        addressText.value = details.location; // Update observable
        averagePriceController.text = details.avgPrice.toString();
        descriptionController.text = details.description;
        initialCuisineModels.value = details.cuisine.isNotEmpty ? [details.cuisine.first] : [];
        restaurantLogo = details.restaurantLogo;
        restaurantBanner = details.restaurantBanner;
        
        // Initialize map position with saved lat/lon
        if (details.lat.isNotEmpty && details.lon.isNotEmpty) {
          try {
            final lat = double.parse(details.lat);
            final lon = double.parse(details.lon);
            resturLat.value = lat;
            resturLong.value = lon;
            
            // Update camera position to show the saved location
            cameraPosition = CameraPosition(
              target: LatLng(lat, lon),
              zoom: 14.4746,
            );
            
            // Move map to the saved location after a short delay
            Future.delayed(const Duration(milliseconds: 500), () {
              mapController?.animateCamera(
                CameraUpdate.newLatLng(LatLng(lat, lon)),
              );
            });
          } catch (e) {
            debugPrint("Error parsing lat/lon: $e");
          }
        }
      } else {
        Get.snackbar("Error", "Failed to load restaurant details");
      }
    } catch (e) {
      debugPrint("Error fetching restaurant details: $e");
      Get.snackbar("Error", "Failed to load restaurant details");
    }
  }

  Future<String> uploadRestaurantMedia(String filePath) async {
    String fileUrl = "";
    try {
      var response = await APIManager.uploadFile(filePath: filePath);
      if (response.data['status']) {
        fileUrl = response.data['data'];
      }
    } catch (e) {
      Get.snackbar("Error", StringConstant.somethingWentWrong);
    }
    return fileUrl;
  }

  Future<void> updateDetails() async {
    if (restaurantNameController.text.trim().isEmpty) {
      Get.snackbar("Error", StringConstant.resNameEmpty);
      return;
    }
    if (addressController.text.trim().isEmpty) {
      Get.snackbar("Error", StringConstant.addressNameEmpty);
      return;
    }
    if (averagePriceController.text.trim().isEmpty) {
      Get.snackbar("Error", StringConstant.avgPriceEmpty);
      return;
    }
    if (selectedLogoImage.isEmpty &&
        Get.find<HomeController>()
            .restaurantDetails
            .value
            .restaurantLogo
            .isEmpty) {
      Get.snackbar("Error", StringConstant.selectedLogoImageEmpty);
      return;
    }
    if (selectedBannerImage.isEmpty &&
        Get.find<HomeController>()
            .restaurantDetails
            .value
            .restaurantBanner
            .isEmpty) {
      Get.snackbar("Error", StringConstant.selectedBannerImageEmpty);
      return;
    } else if (restaurantNameController.text.trim().isNotEmpty &&
        addressController.text.isNotEmpty &&
        averagePriceController.text.isNotEmpty) {
      try {
        String logoUrl = restaurantLogo;
        String bannerUrl = restaurantBanner;
        if (selectedLogoImage.isNotEmpty) {
          logoUrl = await uploadRestaurantMedia(selectedLogoImage.value);
        } else if (selectedBannerImage.isNotEmpty) {
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
          lat: resturLat.value.toString(),
          lon: resturLong.value.toString(),
          stripeCardId:
              Get.find<HomeController>().restaurantDetails.value.stripeCardId ??
                  "",
          stripeCustomerId: Get.find<HomeController>()
                  .restaurantDetails
                  .value
                  .stripeCustomerId ??
              "",
          cuisine: initialCuisineModels,
        ));
        if (response.data["status"]) {
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
        } else if (!response.data["status"]) {
          Get.snackbar("Error", StringConstant.anErrorOccurred);
          return;
        }
      } catch (e) {
        Get.snackbar("Error", StringConstant.anErrorOccurred);
        return;
      }
    }
  }


  Future<void> updateDragLocation({String address = ""}) async {
    debugPrint("📍 updateDragLocation called with address: '$address'");
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          cameraPosition.target.latitude, cameraPosition.target.longitude);
      resturLat.value = cameraPosition.target.latitude;
      resturLong.value = cameraPosition.target.longitude;
      debugPrint("📍 Lat/Lon updated: ${resturLat.value}, ${resturLong.value}");

      // Build a fuller address from available placemark components when no explicit address is supplied
      if (address.isEmpty) {
        try {
          final p = placemarks.first;
          final List<String> parts = [
            (p.name ?? "").trim(),
            (p.street ?? "").trim(),
            (p.subLocality ?? "").trim(),
            (p.locality ?? "").trim(),
            (p.administrativeArea ?? "").trim(),
            (p.postalCode ?? "").trim(),
            (p.country ?? "").trim(),
          ].where((element) => element.isNotEmpty).toList();
          address = parts.join(', ');
          debugPrint("📍 Built address from placemark: '$address'");
        } catch (e) {
          // Fallback to previous minimal format if placemark parts are not available
          debugPrint("Error building address from placemark: $e");
          if (placemarks.isNotEmpty) {
            address = '${placemarks.first.subLocality ?? ''}, ${placemarks.first.locality ?? ''}, ${placemarks.first.administrativeArea ?? ''}';
            debugPrint("📍 Fallback address: '$address'");
          }
        }
      }

      // Always update the address controller and observable
      final cleanedAddress = updateString(address);
      if (cleanedAddress.isNotEmpty) {
        debugPrint("📍 Setting addressController.text to: '$cleanedAddress'");
        debugPrint("📍 Setting addressText.value to: '$cleanedAddress'");
        addressController.text = cleanedAddress;
        addressText.value = cleanedAddress; // Update observable to trigger UI
        debugPrint("✅ Address updated successfully!");
        debugPrint("📍 Current addressController.text: '${addressController.text}'");
        debugPrint("📍 Current addressText.value: '${addressText.value}'");
      } else {
        debugPrint("⚠️ Cleaned address is empty!");
      }
    } catch (e) {
      debugPrint("❌ Error in updateDragLocation: $e");
    }
  }
  String updateString(String input) {
    if (input.startsWith(',')) {
      return input.replaceFirst(',', '');
    }
    return input;
  }
  void moveToNewLatLng(double lat, double lng, {String address = ""}) {
    final newLatLng = LatLng(lat, lng);
    cameraPosition =
        CameraPosition(target: newLatLng, zoom: cameraPosition.zoom);

    mapController?.animateCamera(CameraUpdate.newLatLng(newLatLng));

    // Update drag location and address
    updateDragLocation(address: address);
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
