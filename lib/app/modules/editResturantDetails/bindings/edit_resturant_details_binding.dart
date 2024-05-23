import 'package:get/get.dart';

import '../controllers/edit_resturant_details_controller.dart';

class EditResturantDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditResturantDetailsController>(
      () => EditResturantDetailsController(),
    );
  }
}
