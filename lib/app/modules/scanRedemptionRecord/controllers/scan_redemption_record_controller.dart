import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ScanRedemptionRecordController extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  void gotoScanHistory() {
    Get.toNamed(Routes.SCAN_HISTORY);
  }
}
