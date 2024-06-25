import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/home/views/location_bottom_sheet.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

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
  }

  @override
  void onInit() {
    getRestaurantDetails();
    super.onInit();
  }

  @override
  void onReady() {
    getRestaurantDetails();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void showLocationBottomSheet() {
    Get.bottomSheet(const LocationBottomSheet());
  }

  void gotoNotifications() {
    Get.toNamed(Routes.NOTIFICATIONS);
  }

  void gotoScanQr() {
    Get.toNamed(Routes.QR_SCAN);
  }

  void gotoJobsScreen() {
    Get.toNamed(Routes.JOBS);
  }

  void gotoRestaurantDetatils() {
    Get.toNamed(Routes.RATING_AND_FEEDBACK_MANAGEMENT);
  }
}
