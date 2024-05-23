import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_button_with_border.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/add_item_details_controller.dart';

class AddItemDetailsView extends GetView<AddItemDetailsController> {
  const AddItemDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: Get.arguments[0]
              ? StringConstant.editItemDetails
              : StringConstant.addItemDetails),
      body: Padding(
        padding: EdgeInsets.all(16.kw),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  StringConstant.itemPhoto,
                  style: TextStyleUtil.manrope14w500(),
                ),
                Text(
                  "*",
                  style: TextStyleUtil.manrope14w500(color: context.primary01),
                )
              ],
            ),
            6.kheightBox,
            Container(
              height: 160.kh,
              width: 100.w,
              decoration: BoxDecoration(
                  border: Border.all(color: context.black07),
                  borderRadius: BorderRadius.circular(8.kw),
                  color: context.loginSignupTextfieldColor),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_upload_outlined),
                    2.kwidthBox,
                    Text(
                      StringConstant.uploadPhoto,
                      style:
                          TextStyleUtil.manrope14w400(color: context.black03),
                    )
                  ],
                ),
              ),
            ),
            20.kheightBox,
            Row(
              children: [
                4.kwidthBox,
                Text(
                  StringConstant.category,
                  style: TextStyleUtil.manrope14w500(),
                ),
              ],
            ),
            10.kheightBox,
            Row(
              children: [
                Expanded(
                    child: DropdownButtonFormField<String>(
                  style: TextStyleUtil.manrope16w400(),
                  value: "Side",
                  onChanged: (val) {},
                  items: <String>["Side", "non-veg"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    hintText: StringConstant.selectGender,
                    hintStyle:
                        TextStyleUtil.manrope14w400(color: context.black04),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                )),
              ],
            ),
            20.kheightBox,
            Row(
              children: [
                4.kwidthBox,
                Text(
                  StringConstant.itemName,
                  style: TextStyleUtil.manrope14w500(),
                ),
                Text(
                  "*",
                  style: TextStyleUtil.manrope14w500(color: context.primary01),
                )
              ],
            ),
            10.kheightBox,
            CustomTextField(
                fillColor: context.black07, hintText: StringConstant.enterHere),
            Spacer(),
            CustomRedElevatedButton(
              width: 100.w,
              height: 56.kh,
              buttonText: StringConstant.save,
              onPressed: Get.back,
            ),
            20.kheightBox,
          ],
        ),
      ),
    );
  }
}
