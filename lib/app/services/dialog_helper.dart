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
    _showSnackbar(title: StringConstant.error, msg: message, isError: true);
  }

  static void showSuccess(String message) {
    _showSnackbar(title: StringConstant.success, msg: message, isError: false);
  }

  static void _showSnackbar({required String title, required String msg, required bool isError}) {
    final scaffoldMessenger =
        Get.context != null ? ScaffoldMessenger.maybeOf(Get.context!) : null;

    if (scaffoldMessenger != null) {
      scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: isError ? const Color(0xffCC1728) : null,
            content: _SnackBarContent(
              title: title,
              message: msg,
              color: Colors.white,
            ),
            duration: const Duration(milliseconds: 2000),
          ),
        );
      return;
    }

    if (Get.isSnackbarOpen == true) return;

    Get.rawSnackbar(
      titleText: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      messageText: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: isError ? const Color(0xffCC1728) : Colors.black.withOpacity(0.8),
      duration: const Duration(milliseconds: 2000),
      snackPosition: SnackPosition.TOP,
    );
  }

  //hide loading
  static Future<void> hideDialog() async {
    if (Get.isDialogOpen!) Get.until((route) => !Get.isDialogOpen!);
  }
}

class _SnackBarContent extends StatelessWidget {
  const _SnackBarContent({required this.title, required this.message, required this.color});

  final String title;
  final String message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, color: color),
        ),
        Text(message, style: TextStyle(color: color)),
      ],
    );
  }}
