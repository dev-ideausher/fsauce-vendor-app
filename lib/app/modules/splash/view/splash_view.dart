import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/splash/controller/splash_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';
import '../../../components/common_image_view.dart';

class SplashView extends GetView<SplashController> {
  SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        backgroundColor: controller.isLogin.value ? Colors.white : Colors.white;
        return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonImageView(
                  imagePath: Assets.FsauceLogo,
                  fit: BoxFit.contain,
                  height: 500.kh,
                  width: 500.kh,
                )
              ],
            )
        );
      }),
    );
  }
}