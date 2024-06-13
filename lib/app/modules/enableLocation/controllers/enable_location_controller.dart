import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class EnableLocationController extends GetxController {
  //TODO: Implement EnableLocationController

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

  void gotoNavBar() {
    Get.toNamed(Routes.NAV_BAR);
  }

  void increment() => count.value++;

  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      gotoNavBar();
    } else {
      Get.snackbar(
          "Permission Denied", "You have denied location permissions.");
    }
  }
}
