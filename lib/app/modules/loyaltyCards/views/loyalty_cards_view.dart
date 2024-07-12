import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/loyalty_card.dart';
import 'package:fsauce_vendor_app/app/components/loyalty_privew_card.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/loyalty/controllers/loyalty_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/loyalty_cards_controller.dart';

class LoyaltyCardsView extends GetView<LoyaltyCardsController> {
  const LoyaltyCardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            StringConstant.loyaltyCard,
            style: TextStyleUtil.manrope18w600(),
          ),
          bottom: TabBar(
            indicatorColor: context.primary01,
            labelStyle: TextStyleUtil.manrope14w500(),
            labelColor: context.primary01,
            tabs: const <Widget>[
              Tab(
                text: StringConstant.activeCard,
              ),
              Tab(
                text: StringConstant.inactiveCard,
              ),
            ],
          ),
          leading: const SizedBox(),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.kw),
          child: TabBarView(
              children: controller.tabs,
          )
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
              onPressed: controller.gotoEditLoyaltyPage),
        ),
      ),
    );
  }
}
