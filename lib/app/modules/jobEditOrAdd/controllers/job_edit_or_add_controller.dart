import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/job_model.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/modules/jobs/controllers/jobs_controller.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';

import '../../../components/confirmation_dialog.dart';
import '../../../services/auth.dart';

class JobEditOrAddController extends GetxController {

  @override
  void onInit(){
    super.onInit();
    getToEdit();
    Get.find<HomeController>().getRestaurantDetails();
  }

  @override
  void onClose() {
    jobTitleController.dispose();
    minSalaryController.dispose();
    maxSalaryController.dispose();
    lastDateToApplyController.dispose();
    descriptionController.dispose();
    howToApplyController.dispose();
    super.onClose();
  }

  final jobTitleController = TextEditingController();
  final minSalaryController = TextEditingController();
  final maxSalaryController = TextEditingController();
  final lastDateToApplyController = TextEditingController();
  final descriptionController = TextEditingController();
  final howToApplyController = TextEditingController();
  String id = "";

  RxBool toEdit = false.obs;

  void getToEdit(){
    toEdit = Get.find<JobsController>().toEdit;
  }

  void addJob() async {
    if(Get.find<HomeController>().restaurantDetails.value.subscriptionModel != null){
      if (_validateForm()) {
        try {
          Map<String, dynamic> data = {
            "title" : jobTitleController.text.trim() ?? "Default job title",
            "description": descriptionController.text ?? "Default description",
            "lastDate": lastDateToApplyController.text ?? "Default last date",
            "minSalary": minSalaryController.text.trim().contains(".") ? double.parse(minSalaryController.text.trim()) :
            int.parse(minSalaryController.text.trim()) ?? 0,
            "maxSalary": maxSalaryController.text.trim().contains(".") ? double.parse(minSalaryController.text.trim()) :
            int.parse(maxSalaryController.text.trim()) ?? 0,
            "howToApply": howToApplyController.text ?? "Default how to apply"
          };
          var response = await APIManager.addNewJob(data: data);
          if(response.data['status']){
            JobsController jobsController = Get.find<JobsController>();
            jobsController.updateJobs();
            Get.back();
            Get.bottomSheet(const AddedSuccessfullBottomSheet(
              subTitle: StringConstant.newJobCreatedSuccessfully,
            ));
          }
          // Fetch updated jobs list after adding a new job
        } catch (e) {
          print("Error occurred while creating new job: ${e.toString()}");
          Get.snackbar("Error",e.toString());
          return;
        }
      }
    } else{
      Get.dialog(
          ConfrimationDialog(
              title: StringConstant.subscriptionRequired,
              subTitle: StringConstant.subscriptionRequiredText,
              yesButtonText: StringConstant.checkoutSubscriptions,
              noButtonText: StringConstant.close,
              onYesTap: () async{
                // Get.find<GetStorageService>().logout();
                Get.back();
                Get.offNamed(Routes.SUBSCRIPTION);
              },
              onNoTap: Get.back)
      );
      return;
    }
  }

  bool _validateForm() {
    if (jobTitleController.text.isEmpty) {
      Get.snackbar("Error", StringConstant.enterJobTitle);
      return false;
    }
    if (minSalaryController.text.isEmpty) {
      Get.snackbar("Error", StringConstant.minSalaryOffered);
      return false;
    }
    if (maxSalaryController.text.isEmpty) {
      Get.snackbar("Error", StringConstant.maxSalaryOffered);
      return false;
    }
    if (lastDateToApplyController.text.isEmpty) {
      Get.snackbar("Error", StringConstant.enterLastDateToApply);
      return false;
    }
    if (descriptionController.text.isEmpty) {
      Get.snackbar("Error", StringConstant.enterDescription);
      return false;
    }
    if (howToApplyController.text.isEmpty) {
      Get.snackbar("Error", StringConstant.enterHowToApply);
      return false;
    }
    if(int.parse(maxSalaryController.text.toString()) < int.parse(minSalaryController.text.toString())){
      Get.snackbar("Error", "Max salary offered cannot be less than Min salary offered.");
      return false;
    }
    return true;
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      lastDateToApplyController.text =
          DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  void gotoEditJobPage(Job job) {
    jobTitleController.text = job.title;
    minSalaryController.text = job.minSalary.toString();
    maxSalaryController.text = job.maxSalary.toString();
    lastDateToApplyController.text =
        DateFormat('yyyy-MM-dd').format(job.lastDate);
    descriptionController.text = job.description;
    howToApplyController.text = job.howToApply;
    id = job.id;
  }

  void emptyAddJobVariables(){
    jobTitleController.text = "";
    minSalaryController.text = "";
    maxSalaryController.text = "";
    lastDateToApplyController.text =
        "";
    descriptionController.text = "";
    howToApplyController.text = "";
    id = "";
  }

  void editJob() async {
    if (_validateForm()) {
      try {
        Map<String, dynamic> data = {
          "id": id,
          "title": jobTitleController.text.trim(),
          "description": descriptionController.text,
          "lastDate": lastDateToApplyController.text,
          "minSalary": int.parse(minSalaryController.text.trim()),
          "maxSalary": int.parse(maxSalaryController.text.trim()),
          "howToApply": howToApplyController.text
        };
        var response = await APIManager.editJob(data: data);
        JobsController jobsController = Get.find<JobsController>();
        Job updatedJob = Job(
          id: id,
          title: jobTitleController.text.trim(),
          description: descriptionController.text,
          lastDate: DateTime.parse(lastDateToApplyController.text),
          minSalary: int.parse(minSalaryController.text.trim()),
          maxSalary: int.parse(maxSalaryController.text.trim()),
          howToApply: howToApplyController.text,
          vendor: jobsController.jobs.firstWhere((job) => job.id == id).vendor,
          createdAt:
              jobsController.jobs.firstWhere((job) => job.id == id).createdAt,
          updatedAt: DateTime.now(),
          v: jobsController.jobs.firstWhere((job) => job.id == id).v,
        );

        jobsController.updateJobInList(updatedJob);
        Get.back();
      } catch (e) {
        Get.snackbar("Error", "Something went wrong!");
        return;
      }
    }
  }
}
