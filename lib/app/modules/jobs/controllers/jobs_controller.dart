import 'package:fsauce_vendor_app/app/modules/jobs/views/jobs_deltails_bottom_sheet.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class JobsController extends GetxController {
  //TODO: Implement JobsController

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

  void showJobsBottomSheet() {
    Get.bottomSheet(JobsDetailsBottomSheet());
  }

  void gotoAddJobPage() {
    Get.toNamed(Routes.JOB_EDIT_OR_ADD, arguments: [false]);
  }

  void gotoEditJobPage() {
    Get.toNamed(Routes.JOB_EDIT_OR_ADD, arguments: [true]);
  }

  void increment() => count.value++;
}
