import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/splash/controller/splash_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController>{
  SplashView({super.key});

  @override
  Widget build(BuildContext context){
    return Obx(
          () => Scaffold(
            backgroundColor: controller.isLogin.value ? Colors.white : Colors.white,
        body: Center(
          child: Column(
            children: <Widget>[
              Text(StringConstant.theFood, style: TextStyleUtil.manrope32w700(),),
              Text(StringConstant.sauceity, style: TextStyleUtil.manrope32w700(color: context.primary01),),
            ],
          ),
        ),
      ),
    );
  }
}