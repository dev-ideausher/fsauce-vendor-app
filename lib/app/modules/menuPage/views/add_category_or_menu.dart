import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/menuPage/controllers/menu_page_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class AddCategoryOrMenu extends StatelessWidget {
  const AddCategoryOrMenu({super.key});

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
            StringConstant.addCategoryOrItem,
            style: TextStyleUtil.manrope18w600(color: context.black01),
          ),
          20.kheightBox,
          InkWell(
            onTap: Get.find<MenuPageController>().showAddItem,
            child: Container(
              height: 53.kh,
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 10.kw),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border(bottom: BorderSide(color: context.borderColor1))),
              child: Row(
                children: [
                  Text(
                    StringConstant.addItem,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_right_outlined)
                ],
              ),
            ),
          ),
          16.kheightBox,
          InkWell(
            onTap: Get.find<MenuPageController>().onAddCategoryClick,
            child: Container(
              height: 53.kh,
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 10.kw),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border(bottom: BorderSide(color: context.borderColor1))),
              child: Row(
                children: [
                  Text(
                    StringConstant.addCategory,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_right_outlined)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
