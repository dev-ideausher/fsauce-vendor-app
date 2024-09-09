import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:get/get.dart';
import 'colors.dart';
import 'responsive_size.dart';

class DialogHelper {
  static void showLoading([String? message]) {
    Get.dialog(
      WillPopScope(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                    height: 80.kh,
                    width: 80.kh,
                    decoration: BoxDecoration(
                      color: Get.context!.primary01,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0.kh),
                      ),
                    ),
                    padding: EdgeInsets.all(12.kh),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )),
              ),
              // message != null ? SizedBox(height: 8.kh) : const SizedBox(),
              // message != null ? Text(message) : const SizedBox(),
            ],
          ),
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: const Color(0xff141A31).withOpacity(.4),
      useSafeArea: true,
    );
  }

  static void showError(String message) {
    Get.snackbar(
      StringConstant.error,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xffCC1728),
      colorText: Colors.white,
    );
  }

  static void showSuccess(String message) {
    Get.snackbar(
      StringConstant.success,
      message,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
    );
  }

  //hide loading
  static Future<void> hideDialog() async {
    if (Get.isDialogOpen!) Get.until((route) => !Get.isDialogOpen!);
  }
}
