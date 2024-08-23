import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/current_plan_card.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';

import 'package:get/get.dart';

import '../../../constants/string_constant.dart';
import '../../../models/plan_model.dart';
import '../../../services/text_style_util.dart';
import '../controllers/subscription_controller.dart';

class CurrentSubscriptionView extends GetView<SubscriptionController> {
  const CurrentSubscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlanModel model = controller.subscriptionPlans
        .firstWhere((PlanModel model) => model.Id == controller.planId.value);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        centerTitle: true,
        title: Text(
          StringConstant.subscriptions,
          style: TextStyleUtil.manrope18w600(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.kw, vertical: 16.kh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              12.kheightBox,
              Text(StringConstant.currentPlan,
                  style: TextStyleUtil.manrope16w600()),
              12.kheightBox,
              CurrentPlanCard(
                title: model.title ?? "",
                validTill: "18 March 2026",
                active: model.isActive!,
                billingFrequency: model.billedFrequency!,
                price: model.price!,
              )
            ],
          ),
        ),
      ),
    );
  }
}
