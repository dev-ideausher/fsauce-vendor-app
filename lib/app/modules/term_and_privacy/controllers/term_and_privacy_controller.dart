import 'package:get/get.dart';

import '../../../services/dio/api_service.dart';

class TermAndPrivacyController extends GetxController {
  bool isTerm = true;
  RxString termsContent = "".obs;
  RxBool isTermsLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isTerm = Get.arguments['isTerm'];
      getTermsOrPolicy(isTerm);
    }
  }

  void getTermsOrPolicy(bool isTerm) async {
    isTermsLoading.value = true;
    try {
      var response = isTerm
          ? await APIManager.getTermsAndConditions()
          : await APIManager.getPrivacyPolicy();
      if (response.data['status']) {
        termsContent.value = response.data['data']['description'];
      }
    } catch (e) {
      print(e);
      // showMySnackbar(msg: e.toString(), title: StringConstant.error);
    } finally {
      isTermsLoading.value = false;
    }
  }
}
