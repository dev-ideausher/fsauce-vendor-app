import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_button_with_border.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/menuPage/controllers/menu_page_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(16.kw),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.kw),
              topRight: Radius.circular(24.kw))),
      child: Column(
        children: [
          Container(
            height: 5.kh,
            width: 64.kw,
            decoration: BoxDecoration(
                color: context.black01, borderRadius: BorderRadius.circular(3)),
          ),
          20.kheightBox,
          Text(
            StringConstant.addNewCategory,
            style: TextStyleUtil.manrope18w600(color: context.black01),
          ),
          20.kheightBox,
          Row(
            children: [
              4.kwidthBox,
              Text(
                StringConstant.categoryName,
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
              controller: Get.find<MenuPageController>().addCategoryController,
              fillColor: context.black07,
              hintText: StringConstant.enterHere),
          10.kheightBox,
          20.kheightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRedElevatedButtonWithBorder(
                width: 43.w,
                height: 56.kh,
                buttonText: StringConstant.cancel,
                onPressed: () {
                  Get.back();
                },
              ),
              CustomRedElevatedButton(
                  width: 43.w,
                  height: 56.kh,
                  buttonText: StringConstant.next,
                  onPressed: Get.find<MenuPageController>().addCategory),
            ],
          ),
          20.kheightBox,
        ],
      ),
    );
  }
}
