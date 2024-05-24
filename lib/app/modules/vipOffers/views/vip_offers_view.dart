import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/deals_of_the_day_card.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/vip_offers_controller.dart';

class VipOffersView extends GetView<VipOffersController> {
  const VipOffersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          title: Text(
            StringConstant.vipOffers,
            style: TextStyleUtil.manrope18w600(),
          ),
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
              onPressed: controller.gotoCreateVipOffer),
        ),
        body: SizedBox(
          height: 100.h,
          width: 100.w,
          child: DefaultTabController(
            length: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.kw),
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: context.primary01,
                    labelStyle: TextStyleUtil.manrope14w500(),
                    labelColor: context.primary01,
                    tabs: const <Widget>[
                      Tab(
                        text: StringConstant.activeOffers,
                      ),
                      Tab(
                        text: StringConstant.inactiveOffers,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100.h - 200.kh,
                    child: TabBarView(children: [
                      SingleChildScrollView(
                        child: Column(
                            children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4]
                                .map((e) => Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 6.kh),
                                    child: DealsOfTheDayCard(
                                        width: 100.w,
                                        isActive: true,
                                        onClick:
                                            controller.showDealsBottomSheet)))
                                .toList()),
                      ),
                      SingleChildScrollView(
                        child: Column(
                            children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4]
                                .map((e) => Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 6.kh),
                                    child: DealsOfTheDayCard(
                                        width: 100.w,
                                        isActive: false,
                                        onClick:
                                            controller.showDealsBottomSheet)))
                                .toList()),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
