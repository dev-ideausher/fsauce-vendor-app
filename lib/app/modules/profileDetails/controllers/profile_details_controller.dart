import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileDetailsController extends GetxController {
  //TODO: Implement ProfileDetailsController

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

  void gotoEditRestaurantDetailsScreen() {
    Get.toNamed(Routes.EDIT_RESTURANT_DETAILS);
  }

  void gotoFeaturesAndTimingScreen() {
    Get.toNamed(Routes.FEATURES_AND_TIMINGS);
  }

  void gotoAllPhotosAndVideos() {
    Get.toNamed(Routes.ALL_PHOTOS_AND_VIDEOS);
  }

  void increment() => count.value++;
}
