import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileDetailsController extends GetxController {
  //TODO: Implement ProfileDetailsController

  @override
  void onInit() {
    Get.find<HomeController>().getRestaurantDetails();
    super.onInit();
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
}
