import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:fsauce_vendor_app/app/modules/loyalty/views/loyalty_view.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LoyaltyController extends GetxController {
  //TODO: Implement LoyaltyController

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

  final backgroundColor = Color.fromARGB(255, 10, 27, 255).obs;

  void openBackgroundColorpalet() {
    Get.dialog(ColorPickerDialog(
      initialColor: Colors.white,
      onColorChanged: (val) {
        backgroundColor.value = val;
      },
    ));
  }

  final textColor = Color(0xffFFFFFF).obs;

  void openTextColorpalet() {
    Get.dialog(ColorPickerDialog(
      initialColor: Colors.white,
      onColorChanged: (val) {
        textColor.value = val;
      },
    ));
  }

  final stampBackgroundColor = Color(0xffFFFFFF).obs;

  void openStampBackgroundColorpalet() {
    Get.dialog(ColorPickerDialog(
      initialColor: Colors.white,
      onColorChanged: (val) {
        stampBackgroundColor.value = val;
      },
    ));
  }

  final stampTextColor = Color(0xffFFFFFF).obs;

  void openStampTextColorpalet() {
    Get.dialog(ColorPickerDialog(
      initialColor: Colors.white,
      onColorChanged: (val) {
        stampTextColor.value = val;
      },
    ));
  }

  void gotoPreviewScreen() {
    Get.toNamed(Routes.LOYALTY_CARD_PREVIEW);
  }

  void increment() => count.value++;
}
