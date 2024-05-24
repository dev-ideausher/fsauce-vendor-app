import 'package:get/get.dart';

import '../controllers/vip_offers_controller.dart';

class VipOffersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VipOffersController>(
      () => VipOffersController(),
    );
  }
}
