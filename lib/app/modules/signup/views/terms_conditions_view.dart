import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/modules/signup/controllers/signup_controller.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:get/get.dart';

import '../../../constants/string_constant.dart';

class TermsConditionsView extends GetView<SignupController> {
  TermsConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: StringConstant.termsAndConditions,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[Text("Terms and conditions here")],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}
