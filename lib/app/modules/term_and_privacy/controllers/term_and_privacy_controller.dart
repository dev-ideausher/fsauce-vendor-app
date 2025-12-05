import 'package:get/get.dart';

import '../../../constants/string_constant.dart';
import '../../../services/dio/api_service.dart';

class TermAndPrivacyController extends GetxController {
  RxBool isTermsLoading = true.obs;
  RxString termsContent = "".obs;
  String title = "";

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {

      getTermsOrPolicy(Get.arguments['type']);
    }
  }

  void getTermsOrPolicy(String type) async {
    title=type;
    isTermsLoading.value = true;
    try {
      var response = type==StringConstant.termsCons2?
           await APIManager.getTermsAndConditions()
          : type==StringConstant.privacyPolicy?await APIManager.getPrivacyPolicy():await APIManager.getContentPolicy();
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
