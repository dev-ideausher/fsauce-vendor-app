import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_button_with_border.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/category_model.dart';
import 'package:fsauce_vendor_app/app/modules/menuPage/controllers/menu_page_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddNewItem extends StatelessWidget {
  const AddNewItem({super.key});

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
            StringConstant.addItem,
            style: TextStyleUtil.manrope18w600(color: context.black01),
          ),
          20.kheightBox,
          Row(
            children: [
              Text(
                StringConstant.addNewItemHeading,
                style: TextStyleUtil.manrope16w500(),
              ),
            ],
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
          Container(
            height: 56.kh,
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 10.kw),
            decoration: BoxDecoration(
                color: context.loginSignupTextfieldColor,
                border: Border.all(color: context.borderColor1),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(
                    child: DropdownButtonFormField<CategoryModel>(
                  style: TextStyleUtil.manrope16w400(),
                  value: Get.find<MenuPageController>().addItemSelectedCategory,
                  onChanged: (val) {
                    Get.find<MenuPageController>()
                        .changeSelectedCategory(category: val!);
                  },
                  items: Get.find<MenuPageController>()
                      .categories
                      .map<DropdownMenuItem<CategoryModel>>(
                          (CategoryModel value) {
                    return DropdownMenuItem<CategoryModel>(
                      value: value,
                      child: Text(value.name),
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
          ),
          10.kheightBox,
          20.kheightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRedElevatedButtonWithBorder(
                width: 43.w,
                height: 56.kh,
                buttonText: StringConstant.cancel,
                onPressed: Get.back,
              ),
              CustomRedElevatedButton(
                  width: 43.w,
                  height: 56.kh,
                  buttonText: StringConstant.next,
                  onPressed:
                      Get.find<MenuPageController>().gotoAddItemDetailsScreen),
            ],
          ),
          20.kheightBox,
        ],
      ),
    );
  }
}
