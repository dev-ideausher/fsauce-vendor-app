import 'package:get/get.dart';

import '../controllers/create_or_edit_vip_offer_controller.dart';

class CreateOrEditVipOfferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateOrEditVipOfferController>(
      () => CreateOrEditVipOfferController(),
    );
  }
}
