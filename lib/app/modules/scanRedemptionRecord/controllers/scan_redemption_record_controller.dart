import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ScanRedemptionRecordController extends GetxController {
  //TODO: Implement ScanRedemptionRecordController

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

  void gotoScanHistory() {
    Get.toNamed(Routes.SCAN_HISTORY);
  }

  void increment() => count.value++;
}
