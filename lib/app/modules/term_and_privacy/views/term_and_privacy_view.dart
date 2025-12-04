import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/custom_app_bar.dart';
import '../../../constants/string_constant.dart';
import '../../../services/responsive_size.dart';
import '../../../services/text_style_util.dart';
import '../controllers/term_and_privacy_controller.dart';

class TermAndPrivacyView extends GetView<TermAndPrivacyController> {
  const TermAndPrivacyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.isTerm
            ? StringConstant.termsAndConditions
            : StringConstant.privacyPolicy,
      ),
      body: Obx(() {
        if (controller.isTermsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  controller.termsContent.value,
                  style: TextStyleUtil.manrope14w400(),
                ),
              ],
            ).paddingSymmetric(horizontal: 16.kw, vertical: 16.kh),
          ),
        );
      }),
    );
  }
}
