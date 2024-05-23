import 'package:get/get.dart';

import '../controllers/enable_location_controller.dart';

class EnableLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnableLocationController>(
      () => EnableLocationController(),
    );
  }
}
