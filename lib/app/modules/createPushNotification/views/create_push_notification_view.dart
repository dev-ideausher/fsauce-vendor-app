import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/create_push_notification_controller.dart';

class CreatePushNotificationView
    extends GetView<CreatePushNotificationController> {
  const CreatePushNotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: StringConstant.createPushNotification,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.kw),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    StringConstant.notificationTitle,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Text(
                    "*",
                    style:
                        TextStyleUtil.manrope14w500(color: context.primary01),
                  )
                ],
              ),
              10.kheightBox,
              CustomTextField(
                  fillColor: context.loginSignupTextfieldColor,
                  border: Border.all(color: context.black07),
                  hintText: StringConstant.enterTitle),
              20.kheightBox,
              Row(
                children: [
                  Text(
                    StringConstant.scheduleDate,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Text(
                    "*",
                    style:
                        TextStyleUtil.manrope14w500(color: context.primary01),
                  )
                ],
              ),
              10.kheightBox,
              CustomTextField(
                  fillColor: context.loginSignupTextfieldColor,
                  border: Border.all(color: context.black07),
                  suffixIcon: Icons.calendar_month,
                  hintText: StringConstant.enterScheduleDate),
              20.kheightBox,
              Spacer(),
              CustomRedElevatedButton(
                  buttonText: StringConstant.save,
                  height: 56.kh,
                  width: 100.w,
                  onPressed: Get.back)
            ],
          ),
        ));
  }
}
