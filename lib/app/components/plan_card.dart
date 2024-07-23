import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class PlanCard extends StatelessWidget {
  String planTitle;
  double planPrice;

  PlanCard({required this.planTitle, required this.planPrice, super.key});

  final SubscriptionController controller = Get.find<SubscriptionController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.kh,
      width: MediaQuery
          .of(context)
          .size
          .width * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow()]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: <Widget>[
              Radio(
                  activeColor: context.primary01,
                  value: false,
                  groupValue: true,
                  onChanged: (dynamic object) {
                    controller.selectedPlan.value =
                        planTitle;
                  }),
              Text(
                planTitle,
                style: TextStyleUtil.manrope18w600(),
              ),
            ],
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.circle, size: 4, color: context.black03,),
                    8.kwidthBox,
                    Text(
                      StringConstant.planDetails[index],
                      style: TextStyleUtil.manrope14w400(
                          color: context.black03),
                    ),
                  ],
                );
              },
              separatorBuilder: (ctx, index) {
                return 4.kheightBox;
              },
              itemCount: StringConstant.planDetails.length),
          28.kheightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "\$ ${planPrice.toString()} ",
                style: TextStyleUtil.manrope20w600(color: context.primary01),
              ),
              Text(
                "/ ${StringConstant.year.toLowerCase()}",
                style: TextStyleUtil.manrope20w600(color: context.black04),
              )
            ],
          ),
        ],
      ),
    );
  }
}
