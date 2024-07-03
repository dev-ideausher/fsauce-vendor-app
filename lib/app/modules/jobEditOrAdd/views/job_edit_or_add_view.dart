import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_text_box.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield_half.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

import '../controllers/job_edit_or_add_controller.dart';

class JobEditOrAddView extends GetView<JobEditOrAddController> {
  const JobEditOrAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.toEdit.value
            ? StringConstant.editJob
            : StringConstant.addNedJob,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.kw),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  StringConstant.jobTitle,
                  style: TextStyleUtil.manrope14w500(),
                ),
                Text(
                  "*",
                  style: TextStyleUtil.manrope14w500(color: context.primary01),
                ),
              ],
            ),
            10.kheightBox,
            CustomTextField(
              controller: controller.jobTitleController,
              fillColor: context.loginSignupTextfieldColor,
              border: Border.all(color: context.black07),
              hintText: StringConstant.enterJobTitle,
            ),
            20.kheightBox,
            Row(
              children: [
                Text(
                  StringConstant.salaryOffered,
                  style: TextStyleUtil.manrope14w500(),
                ),
                Text(
                  " (${StringConstant.perYear})",
                  style: TextStyleUtil.manrope14w400(color: context.black03),
                ),
                Text(
                  "*",
                  style: TextStyleUtil.manrope14w500(color: context.primary01),
                ),
              ],
            ),
            10.kheightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextFieldHalf(
                  keyboardType: TextInputType.number,
                  controller: controller.minSalaryController,
                  fillColor: context.loginSignupTextfieldColor,
                  border: Border.all(color: context.black07),
                  hintText: StringConstant.minSalaryOffered,
                ),
                Container(
                  height: 2.kh,
                  width: 6.kw,
                  color: context.black03,
                ),
                CustomTextFieldHalf(
                  keyboardType: TextInputType.number,
                  controller: controller.maxSalaryController,
                  fillColor: context.loginSignupTextfieldColor,
                  border: Border.all(color: context.black07),
                  hintText: StringConstant.maxSalaryOffered,
                ),
              ],
            ),
            20.kheightBox,
            Row(
              children: [
                Text(
                  StringConstant.lastDateToApply,
                  style: TextStyleUtil.manrope14w500(),
                ),
                Text(
                  "*",
                  style: TextStyleUtil.manrope14w500(color: context.primary01),
                ),
              ],
            ),
            10.kheightBox,
            CustomTextField(
              controller: controller.lastDateToApplyController,
              fillColor: context.loginSignupTextfieldColor,
              border: Border.all(color: context.black07),
              suffixIcon: Icons.calendar_month,
              hintText: StringConstant.enterLastDateToApply,
              suffixOnPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                await controller.pickDate(context);
              },
            ),
            20.kheightBox,
            Row(
              children: [
                Text(
                  StringConstant.description,
                  style: TextStyleUtil.manrope14w500(),
                ),
                Text(
                  "*",
                  style: TextStyleUtil.manrope14w500(color: context.primary01),
                ),
              ],
            ),
            10.kheightBox,
            CustomTextBox(
              controller: controller.descriptionController,
              fillColor: context.loginSignupTextfieldColor,
              border: Border.all(color: context.black07),
              hintText: StringConstant.enterDescription,
            ),
            20.kheightBox,
            Row(
              children: [
                Text(
                  StringConstant.howTOApply,
                  style: TextStyleUtil.manrope14w500(),
                ),
                Text(
                  "*",
                  style: TextStyleUtil.manrope14w500(color: context.primary01),
                ),
              ],
            ),
            10.kheightBox,
            CustomTextBox(
              controller: controller.howToApplyController,
              fillColor: context.loginSignupTextfieldColor,
              border: Border.all(color: context.black07),
              hintText: StringConstant.enterHowToApply,
            ),
            30.kheightBox,
            CustomRedElevatedButton(
              buttonText: StringConstant.save,
              height: 56.kh,
              width: 100.w,
              onPressed:
                controller.toEdit.value ? controller.editJob : controller.addJob,
            ),
          ],
        ),
      ),
    );
  }
}
