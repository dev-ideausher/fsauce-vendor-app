import 'package:get/get.dart';

import '../controllers/loyalty_card_preview_controller.dart';

class LoyaltyCardPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoyaltyCardPreviewController>(
      () => LoyaltyCardPreviewController(),
    );
  }
}
