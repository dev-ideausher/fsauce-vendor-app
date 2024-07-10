import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/modules/signup/bindings/signup_binding.dart';
import 'package:fsauce_vendor_app/app/modules/signup/controllers/signup_controller.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:get/get.dart';

import '../../../constants/string_constant.dart';
import '../../../services/text_style_util.dart';

class TermsConditionsView extends GetView<SignupController>{
  TermsConditionsView({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstant.termsAndConditions,
          style: TextStyleUtil.manrope24w700(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.kw, right: 16.kw, top: 88.kh),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text("Terms and conditions here")
          ],
        ),
      ),
    );
  }
}