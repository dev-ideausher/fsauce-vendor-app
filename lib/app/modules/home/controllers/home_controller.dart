import 'package:fsauce_vendor_app/app/modules/home/views/location_bottom_sheet.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
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

  void increment() => count.value++;
}
