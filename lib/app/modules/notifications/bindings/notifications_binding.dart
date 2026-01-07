import 'package:get/get.dart';
import '../controllers/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    // This is the **single source of truth**
    Get.put(NotificationsController(), permanent: true);

    // Optionally lazy put the CreatePushNotificationController
    // Get.lazyPut<CreatePushNotificationController>(
    //   () => CreatePushNotificationController(),
    // );
  }
}
