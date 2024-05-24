import 'package:get/get.dart';

import '../controllers/scan_redemption_record_controller.dart';

class ScanRedemptionRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanRedemptionRecordController>(
      () => ScanRedemptionRecordController(),
    );
  }
}
