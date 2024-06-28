import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/job_model.dart';
import 'package:fsauce_vendor_app/app/modules/jobs/views/jobs_deltails_bottom_sheet.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart'; // Add Dio import if not already present

class JobsController extends GetxController {

  final count = 0.obs;
  final RxList<Job> jobs = <Job>[].obs;
  int currentPage = 1;
  final int limit = 10;
  var isLoading = false.obs;
  var isMoreDataAvailable = true.obs;

  RxBool toEdit = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void showJobsBottomSheet(Job job) {
    Get.bottomSheet(JobsDetailsBottomSheet(job: job));
  }

  void gotoAddJobPage() {
    Get.toNamed(Routes.JOB_EDIT_OR_ADD, arguments: [false]);
  }

  void increment() => count.value++;

  void updateJobs() async{
    try {
      var response = await APIManager.getJobs(
          page: currentPage.toString(), limit: limit.toString());
      List<Job> fetchedJobs = (response.data["data"] as List)
          .map((job) => Job.fromJson(job))
          .toList();

      if (fetchedJobs.length < limit) {
        isMoreDataAvailable.value = false;
      } else {
        currentPage++;
      }
      jobs.value = [];
      jobs.addAll(fetchedJobs);
    } catch (e) {
      print(e);
    }
  }

  void fetchJobs() async {
    if (isLoading.value || !isMoreDataAvailable.value) return;

    isLoading.value = true;

    try {
      var response = await APIManager.getJobs(
          page: currentPage.toString(), limit: limit.toString());
      List<Job> fetchedJobs = (response.data["data"] as List)
          .map((job) => Job.fromJson(job))
          .toList();

      if (fetchedJobs.length < limit) {
        isMoreDataAvailable.value = false;
      } else {
        currentPage++;
      }

      jobs.addAll(fetchedJobs);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void updateJobInList(Job updatedJob) {
    int index = jobs.indexWhere((job) => job.id == updatedJob.id);
    if (index != -1) {
      jobs[index] = updatedJob;
      jobs.refresh(); // To update the UI
    }
  }

  // Method to delete menu item
  void deleteJob({required String id}) {
    Get.dialog(
      ConfrimationDialog(
        onNoTap: Get.back,
        onYesTap: () async {
          try {
            var response = await APIManager.deleteJob(id: id);
            if (response["status"]) {
              jobs.removeWhere((element) => element.id == id);
            }
          } catch (e) {
            DialogHelper.showError("Something went wrong!");
          }
        },
        subTitle: StringConstant.deleteJobSub,
        title: StringConstant.deleteJob,
      ),
    );
  }
}
