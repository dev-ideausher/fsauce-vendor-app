import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

import '../models/plan_model.dart';

class PlanCard extends StatelessWidget {
  PlanModel plan;

  PlanCard({required this.plan, super.key});

  @override
  Widget build(BuildContext context) {
    List<String?> features = plan.features ?? [];
    final controller = Get.find<SubscriptionController>();
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 8.kh, horizontal: 16.kw),
      height: 204.kh,
      width: 400.kw,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(
              color: context.black05,
              blurRadius: 4
          )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          12.kheightBox,
          Row(
            children: <Widget>[
              Obx(() {
                return Radio<PlanModel>(
                  activeColor: context.primary01,
                    value: plan,
                    groupValue: controller.selectedPlan.value,
                    onChanged: (PlanModel? model){
                      if(model != null){
                        controller.selectedPlan.value = model;
                      }
                    }
                );
              }),
              32.kwidthBox,
              Text(
                plan.title ?? "",
                style: TextStyleUtil.manrope18w600(),
              ),
              Expanded(child: Container()),
              controller.selectedPlan.value.Id == plan.Id ?
              Container(
                padding: EdgeInsets.all(8.kw),
                decoration: BoxDecoration(
                  color: context.primary03,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.kw), bottomLeft: Radius.circular(8.kw))
                ),
                child: Center(
                  child: Text(StringConstant.currentPlan, style: TextStyleUtil.manrope12w400(color: Colors.white))
                )
              ) : Container(),
            ],
          ),
          10.kheightBox,
          features.isNotEmpty ? SizedBox(
            width: 200.kw,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.circle, size: 4, color: context.black03,),
                      8.kwidthBox,
                      Text(
                        features[index] ?? "",
                        style: TextStyleUtil.manrope14w400(
                            color: context.black03),
                      )
                    ],
                  );
                },
                separatorBuilder: (ctx, index) {
                  return 4.kheightBox;
                },
                itemCount: features.length),
          ) : Container(),
          28.kheightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "\$ ${plan.price.toString()} ",
                style: TextStyleUtil.manrope20w600(color: context.primary01),
              ),
              Text(
                "/ ${plan.billedFrequency ?? ""}",
                style: TextStyleUtil.manrope20w600(color: context.black04),
              )
            ],
          ),
        ],
      ),
    );
  }
}
