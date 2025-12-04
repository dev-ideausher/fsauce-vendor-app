import 'package:get/get.dart';

import '../controllers/term_and_privacy_controller.dart';

class TermAndPrivacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermAndPrivacyController>(
      () => TermAndPrivacyController(),
    );
  }
}
