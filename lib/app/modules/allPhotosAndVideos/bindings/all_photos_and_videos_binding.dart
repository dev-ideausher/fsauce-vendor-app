import 'package:get/get.dart';

import '../controllers/all_photos_and_videos_controller.dart';

class AllPhotosAndVideosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllPhotosAndVideosController>(
      () => AllPhotosAndVideosController(),
    );
  }
}
