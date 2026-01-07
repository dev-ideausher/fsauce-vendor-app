import 'package:get/get.dart';
import '../controllers/create_push_notification_controller.dart';

class CreatePushNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePushNotificationController>(
      () => CreatePushNotificationController(),
    );
    // REMOVE this:
    // Get.put(NotificationsController()); // ❌ Don't put it here
  }
}
