import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:get/get.dart';

import '../constants/string_constant.dart';
import '../services/text_style_util.dart';

class CurrentPlanCard extends StatelessWidget {
  String title;
  String validTill;
  bool active;
  String billingFrequency;
  num price;

  CurrentPlanCard(
      {required this.title, required this.validTill, required this.price, required this.active, required this.billingFrequency, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();
    return Container(
      height: 201.kh,
      padding: EdgeInsets.all(16.kh),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.kw),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(title, style: TextStyleUtil.manrope18w600()),
              Expanded(child: Container(),),
              Container(
                  height: 40.kh,
                  width: 81.kw,
                  padding: EdgeInsets.symmetric(
                      vertical: 8.kh, horizontal: 16.kw),
                  decoration: BoxDecoration(
                    color: active ? context.green : context.primary01,
                    borderRadius: BorderRadius.circular(8.kw),
                  ),
                  child: Center(child: Text(
                    active ? StringConstant.active : StringConstant.inactive,
                    style: TextStyleUtil.manrope16w500(color: Colors.white),),)
              )
            ],
          ),
          12.kheightBox,
          Row(
            children: <Widget>[
              Text("\$${price}",
                style: TextStyleUtil.manrope20w600(color: context.primary01),),
              Text(" /${billingFrequency}",
                  style: TextStyleUtil.manrope20w600(color: context.black03)),
            ],
          ),
          8.kheightBox,
          Text("Valid till ${validTill}",
              style: TextStyleUtil.manrope16w500(color: context.black03)),
          20.kheightBox,
          Obx(() {
            if(controller.isCancelled.value){
              return Row(
                children: [
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        height: 40.kh, width: 144.kw,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: context.primary01),
                            borderRadius: BorderRadius.circular(80.kw)
                        ),
                        child: Center(child: Text(StringConstant.cancelled,
                          style: TextStyleUtil.manrope14w500(color: context
                              .primary01),))
                    ),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                  onTap: () {
                    controller.showList.value = true;
                  },
                  child: Container(
                      height: 40.kh, width: 144.kw,
                      decoration: BoxDecoration(
                          color: context.primary01,
                          border: Border.all(color: context.primary01),
                          borderRadius: BorderRadius.circular(80.kw)
                      ),
                      child: Center(child: Text(StringConstant.upgrade,
                        style: TextStyleUtil.manrope14w500(color: Colors
                            .white),))
                  ),
                ),
                  Expanded(child: Container()),
                ]
              );
            } else{
              return Row(
                children: <Widget>[
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () {
                      controller.confirmCancelSubscription();
                    },
                    child: Container(
                        height: 40.kh, width: 144.kw,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: context.primary01),
                            borderRadius: BorderRadius.circular(80.kw)
                        ),
                        child: Center(child: Text(StringConstant.cancel,
                          style: TextStyleUtil.manrope14w500(color: context
                              .primary01),))
                    ),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () {
                      controller.showList.value = true;
                    },
                    child: Container(
                        height: 40.kh, width: 144.kw,
                        decoration: BoxDecoration(
                            color: context.primary01,
                            border: Border.all(color: context.primary01),
                            borderRadius: BorderRadius.circular(80.kw)
                        ),
                        child: Center(child: Text(StringConstant.upgrade,
                          style: TextStyleUtil.manrope14w500(color: Colors
                              .white),))
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              );
            }
          }),
        ],
      ),
    );
  }
}
