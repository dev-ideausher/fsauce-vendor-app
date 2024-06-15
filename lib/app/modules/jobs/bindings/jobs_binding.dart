import 'package:fsauce_vendor_app/app/modules/jobEditOrAdd/controllers/job_edit_or_add_controller.dart';
import 'package:get/get.dart';

import '../controllers/jobs_controller.dart';

class JobsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobsController>(
      () => JobsController(),
    );
    Get.lazyPut<JobEditOrAddController>(
      () => JobEditOrAddController(),
    );
  }
}
