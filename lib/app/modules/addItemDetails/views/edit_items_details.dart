import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/category_model.dart';
import 'package:fsauce_vendor_app/app/models/menu_item_model.dart';
import 'package:fsauce_vendor_app/app/modules/menuPage/controllers/menu_page_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class EditMenuItem extends StatelessWidget {
  const EditMenuItem({super.key, required this.menuItem});
  final MenuItemModel menuItem;
  @override
  Widget build(BuildContext context) {
    MenuPageController menuController = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: StringConstant.editItemDetails),
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
            Obx(
              () => InkWell(
                onTap: Get.find<MenuPageController>().pickEditImage,
                child: Container(
                  height: 160.kh,
                  width: 100.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: context.black07),
                      borderRadius: BorderRadius.circular(8.kw),
                      color: context.loginSignupTextfieldColor),
                  child: Center(
                    child: menuController.itemEditImage.value.isNotEmpty
                        ? Image.file(File(menuController.itemEditImage.value))
                        : menuController.itemImageUrl.value.isNotEmpty
                            ? Image.network(
                                Get.find<MenuPageController>()
                                    .itemImageUrl
                                    .value,
                                fit: BoxFit.cover,
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_upload_outlined),
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
                    value:
                        Get.find<MenuPageController>().addItemSelectedCategory,
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
                controller: menuController.editMenuItemController,
                fillColor: context.black07,
                hintText: StringConstant.enterHere),
            Spacer(),
            CustomRedElevatedButton(
                width: 100.w,
                height: 56.kh,
                buttonText: StringConstant.save,
                onPressed: () async {
                  await Get.find<MenuPageController>().editItem(menu: menuItem);
                  Navigator.pop(context);
                }),
            20.kheightBox,
          ],
        ),
      ),
    );
  }
}
