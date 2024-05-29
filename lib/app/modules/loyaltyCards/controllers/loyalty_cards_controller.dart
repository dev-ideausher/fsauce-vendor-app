import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LoyaltyCardsController extends GetxController {
  //TODO: Implement LoyaltyCardsController

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

  void gotoEditLoyaltyPage() {
    Get.toNamed(Routes.LOYALTY);
  }

  void increment() => count.value++;
}
