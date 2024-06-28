import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/nav_bar_controller.dart';

class NavBarView extends GetView<NavBarController> {
  const NavBarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: BottomAppBar(
              height: 62.kh,
              color: Colors.white,
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  SizedBox(
                    height: 62.kh,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BottomNavItem(
                          icon: controller.selectedTab.value == BottomTab.home
                              ? ImageConstant.homeFill
                              : ImageConstant.home,
                          label: StringConstant.home,
                          isSelected:
                              controller.selectedTab.value == BottomTab.home,
                          onPressed: () {
                            controller.changeTab(BottomTab.home);
                          },
                        ),
                        BottomNavItem(
                          icon: controller.selectedTab.value == BottomTab.menu
                              ? ImageConstant.menuIconFilled
                              : ImageConstant.menuIcon,
                          label: StringConstant.menu,
                          isSelected:
                              controller.selectedTab.value == BottomTab.menu,
                          onPressed: () {
                            controller.changeTab(BottomTab.menu);
                          },
                        ),
                        BottomNavItem(
                          icon: controller.selectedTab.value == BottomTab.vip
                              ? ImageConstant.vipOffersFilled
                              : ImageConstant.vipOffers,
                          label: StringConstant.vipOffers,
                          isSelected:
                              controller.selectedTab.value == BottomTab.vip,
                          onPressed: () {
                            controller.changeTab(BottomTab.vip);
                          },
                        ),
                        BottomNavItem(
                          icon:
                              controller.selectedTab.value == BottomTab.loyalty
                                  ? ImageConstant.loyaltyFill
                                  : ImageConstant.loyalty,
                          label: StringConstant.loyalty,
                          isSelected:
                              controller.selectedTab.value == BottomTab.loyalty,
                          onPressed: () {
                            controller.changeTab(BottomTab.loyalty);
                          },
                        ),
                        BottomNavItem(
                          icon:
                              controller.selectedTab.value == BottomTab.profile
                                  ? ImageConstant.profileFill
                                  : ImageConstant.profile,
                          label: StringConstant.profile,
                          isSelected:
                              controller.selectedTab.value == BottomTab.profile,
                          onPressed: () {
                            controller.changeTab(BottomTab.profile);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          body: controller.pages[controller.selectedTab.value],
        )
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: onPressed,
      child: SizedBox(
        width: 60.kw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(label,
                  style: TextStyleUtil.manrope12w500(
                    color: isSelected ? context.primary01 : context.black03,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
