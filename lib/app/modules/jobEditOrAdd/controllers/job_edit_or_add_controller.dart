import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:get/get.dart';

class JobEditOrAddController extends GetxController {
  //TODO: Implement JobEditOrAddController

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

  void nedJobAdded() {
    Get.back();
    Get.bottomSheet(AddedSuccessfullBottomSheet(
        subTitle: StringConstant.newJobCreatedSuccessfully));
  }

  void increment() => count.value++;
}
