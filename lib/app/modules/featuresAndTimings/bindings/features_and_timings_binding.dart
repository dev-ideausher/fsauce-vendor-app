import 'package:get/get.dart';

import '../controllers/features_and_timings_controller.dart';

class FeaturesAndTimingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeaturesAndTimingsController>(
      () => FeaturesAndTimingsController(),
    );
  }
}
