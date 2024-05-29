import 'package:get/get.dart';

import '../controllers/job_edit_or_add_controller.dart';

class JobEditOrAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobEditOrAddController>(
      () => JobEditOrAddController(),
    );
  }
}
