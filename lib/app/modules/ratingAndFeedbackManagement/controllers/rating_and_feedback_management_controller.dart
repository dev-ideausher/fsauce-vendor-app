import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:get/get.dart';

class RatingAndFeedbackManagementController extends GetxController {
  //TODO: Implement RatingAndFeedbackManagementController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void showRatingDeleteDialog() {
    Get.dialog(ConfrimationDialog(
        title: StringConstant.deleteReview,
        subTitle: StringConstant.deleteReviewSub,
        onYesTap: () {},
        onNoTap: Get.back));
  }

  void increment() => count.value++;
}
