import 'package:get/get.dart';

import '../controllers/change_password_profile_controller.dart';

class ChangePasswordProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordProfileController>(
      () => ChangePasswordProfileController(),
    );
  }
}
