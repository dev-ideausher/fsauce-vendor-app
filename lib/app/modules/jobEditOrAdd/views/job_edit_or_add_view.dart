import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield_half.dart';
import 'package:fsauce_vendor_app/app/components/fsv_textfield.dart';
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
            FsvTextfield(
              hintText: StringConstant.enterJobTitle,
              controller: controller.jobTitleController,
              maxLength: 30,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? val) {
                if (val == null || val.isEmpty) {
                  return StringConstant.emptyJobTitle;
                }
                return null;
              },
            ),
            20.kheightBox,
            Row(
              children: [
                Text(
                  StringConstant.salaryOffered,
                  style: TextStyleUtil.manrope14w500(),
                ),
                Text(
                  "(${StringConstant.perYear})",
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
                SizedBox(
                    width: 40.w,
                    child: FsvTextfield(
                      hintText: StringConstant.minSalaryOffered,
                      keyboardType: TextInputType.number,
                      controller: controller.minSalaryController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                      ],
                      isSuffixNeeded: false,
                    )),
                Container(
                  height: 2.kh,
                  width: 6.kw,
                  color: context.black03,
                ),
                SizedBox(
                    width: 40.w,
                    child: FsvTextfield(
                      hintText: StringConstant.maxSalaryOffered,
                      keyboardType: TextInputType.number,
                      controller: controller.maxSalaryController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'[0-9.]')), // Allow digits and decimal point
                      ],
                      isSuffixNeeded: false,
                    )),
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
            FsvTextfield(
              hintText: StringConstant.enterLastDateToApply,
              readOnly: true,
              controller: controller.lastDateToApplyController,
              suffix: const Icon(
                Icons.calendar_month,
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                await controller.pickDate(context);
              },
              validator: (String? val) {
                if (val == null || val.isEmpty) {
                  return StringConstant.dateCannotBeEmpty;
                }
                return null;
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
            FsvTextfield(
              hintText: StringConstant.enterDescription,
              controller: controller.descriptionController,
              maxLines: 5,
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
            FsvTextfield(
              hintText: StringConstant.enterHowToApply,
              controller: controller.howToApplyController,
              maxLines: 5,
            ),
            30.kheightBox,
            CustomRedElevatedButton(
              buttonText: StringConstant.save,
              height: 56.kh,
              width: 100.w,
              onPressed: controller.toEdit.value
                  ? controller.editJob
                  : controller.addJob,
            ),
          ],
        ),
      ),
    );
  }
}
