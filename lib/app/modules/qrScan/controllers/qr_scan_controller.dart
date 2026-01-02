import 'package:flutter/cupertino.dart';
import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../../constants/string_constant.dart';

class QrScanController extends GetxController {
  //TODO: Implement QrScanController

  Barcode? result;
  QRViewController? qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  TextEditingController couponCodeController = TextEditingController();
  RxBool canRedeem = false.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    super.onClose();
    couponCodeController.dispose();
  }

  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
    });
  }

  Future<void> scanQR() async {
    if (result != null) {
      try {
        String qrData = result!.code!;
      } catch (e) {
        print("Error while scanning QR: $e");
        Get.snackbar("Error", StringConstant.somethingWentWrong);
      }
    }
  }

  // Future<void> redeemCode() async {
  //   if (couponCodeController.text.isNotEmpty) {
  //     try {
  //       String id = Get.find<HomeController>().vendor;
  //       var response = await APIManager.redeemCouponCode(
  //           code: couponCodeController.text, userId: id);
  //       if (response.data['status']) {
  //         Get.bottomSheet(const AddedSuccessfullBottomSheet(
  //             subTitle: StringConstant.redeemedSuccessfully));
  //       } else if (!response.data['status']) {
  //         Get.snackbar("Error", response.data['message']);
  //       }
  //     } catch (e) {
  //       print("Error while scanning QR: $e");
  //     }
  //   }
  // }
  Future<void> redeemCode() async {
    if (couponCodeController.text.isNotEmpty) {
      try {
        String id = Get.find<HomeController>().vendor;

        var response = await APIManager.redeemCouponCode(
          code: couponCodeController.text,
          userId: id,
        );

        if (response.data['status']) {
          // Show success bottom sheet
          Get.bottomSheet(
            const AddedSuccessfullBottomSheet(
              subTitle: StringConstant.redeemedSuccessfully,
            ),
          );

          // Wait for a short duration so user can see success
          Future.delayed(const Duration(seconds: 1), () {
            // 1️⃣ Clear input
            couponCodeController.clear();

            // 2️⃣ Close bottom sheet
            if (Get.isBottomSheetOpen ?? false) {
              Get.back();
            }

            // 3️⃣ Navigate to Home & remove all previous screens
            Get.offAllNamed(Routes.NAV_BAR);
          });
        } else {
          Get.snackbar("Error", response.data['message']);
        }
      } catch (e) {
        print("Error while redeeming code: $e");
        Get.snackbar("Error", StringConstant.somethingWentWrong);
      }
    }
  }
}
