import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../services/auth.dart';
import '../../../services/storage.dart';

class OnboardingController extends GetxController {
  //TODO: Implement OnboardingController
  final Auth auth = Get.find<Auth>();
  User? user = FirebaseAuth.instance.currentUser;

  final PageController pageController = PageController(initialPage: 0);
  final RxInt pageCount = 0.obs;

  void incrementPage() {
    int currentPageIndex = pageController.page?.round() ?? 0;
    int nextPageIndex = currentPageIndex + 1;
    if (nextPageIndex < 4) {
      pageController.animateToPage(
        nextPageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {

    }
  }

  void changePageCount({required int n}) {
    pageCount.value = n;
  }

  void gotoSignupScreen() {
    Get.offAllNamed(Routes.SIGNUP);
  }

  void gotoLoginScreen() {
    Get.offAllNamed(Routes.LOGIN);
  }
}
