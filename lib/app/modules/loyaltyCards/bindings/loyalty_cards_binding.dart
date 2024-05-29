import 'package:get/get.dart';

import '../controllers/loyalty_cards_controller.dart';

class LoyaltyCardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoyaltyCardsController>(
      () => LoyaltyCardsController(),
    );
  }
}
