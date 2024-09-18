import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/restaurant_menu.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../../../components/empty_widget.dart';
import '../controllers/menu_page_controller.dart';

class MenuPageView extends GetView<MenuPageController> {
  const MenuPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: StringConstant.menu,
          leading: SizedBox(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
            backgroundColor: context.primary01,
            foregroundColor: context.white,
            shape: const CircleBorder(),
            child: Icon(
              Icons.add,
              size: 30.kw,
            ),
            onPressed: () {
              controller.shoeAddCategoryOrItem();
            }),
        body: Padding(
          padding: EdgeInsets.only(top: 16.kh, left: 16.kw, right: 16.kw),
          child: Obx(() {
            if (controller.categories.isNotEmpty) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ...controller.categories.value.map(
                      (e) => RestaurantMenu(
                        category: e,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                  child: EmptyWidget(
                      title: StringConstant.noMenuFound,
                      subTitle: StringConstant.craftMenu));
            }
          }),
        ));
  }
}
