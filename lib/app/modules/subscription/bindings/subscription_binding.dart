import 'package:fsauce_vendor_app/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:get/get.dart';

class SubscriptionBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SubscriptionController>(
        () => SubscriptionController()
    );
  }
}