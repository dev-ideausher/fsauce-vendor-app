import 'package:get/get.dart';

class AddItemDetailsController extends GetxController {
  //TODO: Implement AddItemDetailsController

  validateItemName(String input) {
    if (input.contains('.')) {
      return 'Item name should not contain a period (.)';
    }

    if (RegExp(r'^\d+$').hasMatch(input)) {
      return 'Item name should not be a number by itself';
    }
    return null;
  }

  /*@override
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
  }*/
}
