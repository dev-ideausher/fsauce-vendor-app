import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/components/fsv_textfield.dart';
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
        appBar: const CustomAppBar(
          title: StringConstant.createPushNotification,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.kw),
          child: Form(
            key: controller.formKey,
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
                FsvTextfield(
                  hintText: StringConstant.enterTitle,
                  controller: controller.titleController,
                  validator: (String? val) {
                    if (val == null || val.isEmpty) {
                      return StringConstant.notificationTitleEmpty;
                    } else if (val.length > 25) {
                      return StringConstant.max25CharsAllowed;
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
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
                FsvTextfield(
                  hintText: StringConstant.enterScheduleDate,
                  readOnly: true,
                  controller: controller.scheduledDateController,
                  suffix: const Icon(Icons.calendar_month),
                  onPressedSuffix: () {
                    controller.pickDate(context);
                  },
                ),
                20.kheightBox,
                const Spacer(),
                CustomRedElevatedButton(
                    buttonText: StringConstant.save,
                    height: 56.kh,
                    width: 100.w,
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.addNotification();
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
