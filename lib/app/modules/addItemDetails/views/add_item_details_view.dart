import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
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

import '../../../routes/app_pages.dart';
import '../../../services/dialog_helper.dart';
import '../controllers/add_item_details_controller.dart';

class AddItemDetailsView extends GetView<AddItemDetailsController> {
  const AddItemDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: StringConstant.addItemDetails),
      body: Padding(
        padding: EdgeInsets.all(16.kw),
        child: Form(
          key: Get.find<MenuPageController>().formKey,
          child: ListView(
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
              Obx(
                () => InkWell(
                  onTap: Get.find<MenuPageController>().pickImage,
                  child: Container(
                    height: 160.kh,
                    width: 100.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: context.black07),
                        borderRadius: BorderRadius.circular(8.kw),
                        color: context.loginSignupTextfieldColor),
                    child: Center(
                      child: Get.find<MenuPageController>()
                              .itemImage
                              .value
                              .isNotEmpty
                          ? Image.file(
                              File(
                                  Get.find<MenuPageController>().itemImage.value),
                              fit: BoxFit.cover,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.file_upload_outlined),
                                2.kwidthBox,
                                Text(
                                  StringConstant.uploadPhoto,
                                  style: TextStyleUtil.manrope14w400(
                                      color: context.black03),
                                )
                              ],
                            ),
                    ),
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
                      isExpanded: true,
                      value: Get.find<MenuPageController>()
                          .addItemSelectedCategory,
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
                  controller: Get.find<MenuPageController>().itemNameController,
                  fillColor: context.black07,
                  validator: (value) => controller.validateItemName(value ?? ""),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  hintText: StringConstant.enterHere
              ),
              220.kheightBox,
              CustomRedElevatedButton(
                  width: 100.w,
                  height: 56.kh,
                  buttonText: StringConstant.save,
                  onPressed: () async {
                    if(Get.find<MenuPageController>().formKey.currentState!.validate()){
                      bool status =
                      await Get.find<MenuPageController>().addMenuItem();
                      if (status) {
                        Get.back();
                      }
                    }
                  }),
              60.kheightBox,
            ],
          ),
        ),
      ),
    );
  }
}
