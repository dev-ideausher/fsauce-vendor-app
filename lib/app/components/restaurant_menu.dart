import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/category_model.dart';
import 'package:fsauce_vendor_app/app/models/menu_item_model.dart';
import 'package:fsauce_vendor_app/app/modules/menuPage/controllers/menu_page_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class RestaurantMenu extends StatefulWidget {
  const RestaurantMenu({super.key, required this.category});
  final CategoryModel category;

  @override
  State<RestaurantMenu> createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  bool isOpen = false;
  void handleClick(int item) {
    switch (item) {
      case 0:
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.category.menu.sort((model1, model2) => model1.name
        .toLowerCase()
        .toString()
        .compareTo(model2.name.toLowerCase().toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.kh),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.kw),
          border: Border(bottom: BorderSide(color: context.borderColor1))),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.only(left: 10.kw),
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          collapsedIconColor: context.black01,
          onExpansionChanged: (value) {
            setState(() {
              isOpen = value;
            });
          },
          trailing: SizedBox(
            width: 72.5,
            child: Row(
              children: [
                Icon(!isOpen
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded),
                Spacer(),
                PopupMenuButton<int>(
                  color: Colors.white,
                  onSelected: (item) => handleClick(item),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                        onTap: () {
                          Get.find<MenuPageController>()
                              .onEditCategoryClick(category: widget.category);
                        },
                        value: 1,
                        child: Text(
                          StringConstant.editCategory,
                          style: TextStyleUtil.manrope14w400(),
                        )),
                    PopupMenuItem<int>(
                        onTap: () {
                          Get.find<MenuPageController>()
                              .deleteCategory(id: widget.category.id);
                        },
                        value: 1,
                        child: Text(
                          StringConstant.deleteCategory,
                          style: TextStyleUtil.manrope14w400(
                            color: context.primary01,
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
          iconColor: context.black01,
          childrenPadding: EdgeInsets.only(
              left: 10.kw, right: 10.kw, bottom: 10.kw), // Adjust padding here
          title: Text(
            widget.category.name,
            style: TextStyleUtil.manrope16w600(color: context.black01),
          ),
          children: widget.category.menu
              .map(
                (e) => Container(
                  padding:
                      EdgeInsets.only(left: 10.kw, bottom: 10.kw, top: 10.kw),
                  margin: EdgeInsets.only(bottom: 10.kh),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.kw),
                      border: Border(
                          bottom: BorderSide(color: context.borderColor1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          e.name,
                          style: TextStyleUtil.manrope14w500(),
                        ).paddingOnly(right: 12.kw),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.kw),
                        child: CommonImageView(
                          height: 50.kh,
                          width: 50.kh,
                          fit: BoxFit.cover,
                          url: e.image,
                        ),
                      ),
                      5.kwidthBox,
                      PopupMenuButton<int>(
                        color: Colors.white,
                        onSelected: (item) => handleClick(item),
                        itemBuilder: (context) => [
                          PopupMenuItem<int>(
                              onTap: () {
                                Get.find<MenuPageController>()
                                    .gotoEditItemDetailsScreen(
                                        menuItem: e, category: widget.category);
                              },
                              value: 1,
                              child: Text(
                                StringConstant.editItem,
                                style: TextStyleUtil.manrope14w400(),
                              )),
                          PopupMenuItem<int>(
                              onTap: () {
                                Get.find<MenuPageController>()
                                    .deleteItem(menuItem: e);
                              },
                              value: 1,
                              child: Text(
                                StringConstant.deleteItem,
                                style: TextStyleUtil.manrope14w400(
                                  color: context.primary01,
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
