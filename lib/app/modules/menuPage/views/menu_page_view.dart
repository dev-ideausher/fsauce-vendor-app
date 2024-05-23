import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/restaurant_menu.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/menu_page_controller.dart';

class MenuPageView extends GetView<MenuPageController> {
  const MenuPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            StringConstant.menu,
            style: TextStyleUtil.manrope18w600(),
          ),
          leading: const SizedBox(),
          centerTitle: true,
        ),
        floatingActionButton: Container(
          height: 41.kh,
          width: 41.kw,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: context.primary01),
          child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 30.kw,
              ),
              onPressed: controller.shoeAddCategoryOrItem),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 16.kh, left: 16.kw, right: 16.kw),
          child: const SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                RestaurantMenu(
                  options: ["dad", "dadso", "da", "dad"],
                  title: "Vegetarian Pizza",
                ),
                RestaurantMenu(
                  options: ["dad", "dadso", "da", "dad"],
                  title: "Non-Vegetarian Pizza",
                ),
                RestaurantMenu(
                  options: ["dad", "dadso", "da", "dad"],
                  title: "Sides",
                ),
              ],
            ),
          ),
        ));
  }
}
