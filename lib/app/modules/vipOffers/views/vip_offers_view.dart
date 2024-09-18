import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/deals_of_the_day_card.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/views/active_offers_view.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/views/inactive_offers_view.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/vip_offers_controller.dart';

class VipOffersView extends GetView<VipOffersController> {
  const VipOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: const SizedBox(),
            title: Text(
              StringConstant.vipOffers,
              style: TextStyleUtil.manrope18w600(),
            ),
            centerTitle: true,
            bottom: TabBar(
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
          ),
          // floatingActionButton: Container(
          //   height: 41.kh,
          //   width: 41.kw,
          //   decoration:
          //       BoxDecoration(shape: BoxShape.circle, color: context.primary01),
          //   child: IconButton(
          //       padding: EdgeInsets.zero,
          //       icon: Icon(
          //         Icons.add,
          //         color: Colors.white,
          //         size: 30.kw,
          //       ),
          //       onPressed: controller.gotoCreateVipOffer),
          // ),
          body: SizedBox(
            height: 100.h,
            width: 100.w,
            child: Padding(
                padding: EdgeInsets.only(left: 16.kw, right: 16.kw, top: 6.kh),
                child: const TabBarView(children: [
                  ActiveOffersView(),
                  InactiveOffersView(),
                ])),
          )),
    );
  }
}
