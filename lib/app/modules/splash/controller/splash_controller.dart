import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

import '../../../services/storage.dart';

class SplashController extends GetxController{

  RxBool isLogin = false.obs;

  @override
  void onInit(){
    Future.delayed(const Duration(milliseconds: 1000), () {
      Get.offAllNamed(Get.find<GetStorageService>().isLoggedIn ? Routes.NAV_BAR : Routes.ONBOARDING);
    });
    super.onInit();
  }
}