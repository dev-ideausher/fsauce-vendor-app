import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/loyalty_model.dart';
import '../../../services/dio/api_service.dart';

class ScanHistoryController extends GetxController {
  final RxList<LoyaltyModelData> scanHistory = <LoyaltyModelData>[].obs;
  final RxBool isLoad = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getScanHistory(Get.arguments);
  }

  Future<void> getScanHistory(String date) async {
    try {
      final response = await APIManager.getLoyaltyScanStats(date: date);
      isLoad.value = false;
      if (response.data['status']) {
        final LoyaltyModel loyaltyModel = LoyaltyModel.fromJson(response.data);
        scanHistory.value = loyaltyModel.data!;
      }
    } catch (e) {
      isLoad.value = false;
      debugPrint(e.toString());
    }
  }

  String formatScanDate(String date) {
    return DateFormat("dd MMM yyyy, hh:mm").format(DateTime.parse(date));
  }

  /// API sends camelCase (e.g. vipOffer); naive capitalize-first would show "Vipoffer".
  String formatTypeOfRedeemLabel(String? typeOfRedeem) {
    if (typeOfRedeem == null || typeOfRedeem.isEmpty) return '';
    switch (typeOfRedeem) {
      case 'vipOffer':
        return 'VIP Offer';
      default:
        return typeOfRedeem.capitalizeFirst ?? typeOfRedeem;
    }
  }
}
