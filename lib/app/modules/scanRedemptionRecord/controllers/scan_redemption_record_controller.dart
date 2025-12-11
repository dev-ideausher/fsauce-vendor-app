import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/models/scan_redemption_model.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScanRedemptionRecordController extends GetxController {
  TextEditingController dateController = TextEditingController();
  RxList<ScanRedemptionModelData> scanHistory = <ScanRedemptionModelData>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getScanHistory();
  }

  void gotoScanHistory({String? date }) {
    Get.toNamed(Routes.SCAN_HISTORY,arguments: date);
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateController.text = formattedDate;
      getScanHistory(date: formattedDate);
    }
  }

  Future<void> getScanHistory({String? date}) async {
    isLoading.value = true;
    try {
      var response = await APIManager.getLoyaltyStampDatewise(date: date);
      if (response.data['status']) {
        ScanRedemptionModel s=ScanRedemptionModel.fromJson(response.data);
        scanHistory.value = s.data!;
      } else {
        scanHistory.clear();
      }
    } catch (e) {
      print(e);
      scanHistory.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
