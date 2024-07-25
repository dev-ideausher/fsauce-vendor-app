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
                CustomTextField(
                  validator: (String? val){
                    if(val  == null || val.isEmpty){
                      return StringConstant.notificationTitleEmpty;
                    } else if(val.length > 50){
                      return StringConstant.max25CharsAllowed;
                    }
                      return null;
                  },
                  controller: controller.titleController,
                    fillColor: context.loginSignupTextfieldColor,
                    border: Border.all(color: context.black07),
                    hintText: StringConstant.enterTitle),
                20.kheightBox,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    StringConstant.scheduleDate,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                ),
                10.kheightBox,
                CustomTextField(
                  readOnly: true,
                    controller: controller.scheduledDateController,
                    fillColor: context.loginSignupTextfieldColor,
                    border: Border.all(color: context.black07),
                    suffixIcon: Icons.calendar_month,
                    suffixOnPressed: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 2 * 365)),

                      ).then((pickedDate){
                        if(pickedDate != null){
                          controller.selectedDate.value = pickedDate;
                          controller.scheduledDateController.text = pickedDate.toString().substring(0, 11);
                        }
                      });
                    },
                    hintText: StringConstant.enterScheduleDate),
                20.kheightBox,
                const Spacer(),
                CustomRedElevatedButton(
                    buttonText: StringConstant.save,
                    height: 56.kh,
                    width: 100.w,
                    onPressed: () {
                      if(controller.formKey.currentState!.validate()){
                        controller.addNotification();
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
