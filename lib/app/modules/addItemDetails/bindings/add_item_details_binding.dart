import 'package:get/get.dart';

import '../controllers/add_item_details_controller.dart';

class AddItemDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddItemDetailsController>(
      () => AddItemDetailsController(),
    );
  }
}
