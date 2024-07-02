import 'package:fsauce_vendor_app/app/modules/ratingAndFeedbackManagement/views/review_filter_bottom_sheet.dart';
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
