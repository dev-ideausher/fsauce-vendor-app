import 'package:get/get.dart';

import '../controllers/rating_and_feedback_management_controller.dart';

class RatingAndFeedbackManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RatingAndFeedbackManagementController>(
      () => RatingAndFeedbackManagementController(),
    );
  }
}
