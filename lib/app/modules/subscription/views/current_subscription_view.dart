import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/current_plan_card.dart';
import 'package:fsauce_vendor_app/app/models/subscription_model.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';

import 'package:get/get.dart';

import '../../../constants/string_constant.dart';
import '../../../models/plan_model.dart';
import '../../../services/text_style_util.dart';
import '../controllers/subscription_controller.dart';

class CurrentSubscriptionView extends GetView<SubscriptionController> {
  const CurrentSubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {


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
                title: controller.subscriptionPlans.value.planName ?? "",
                validTill: controller.formatDateString(controller.subscriptionPlans.value.endDate ??""),
                active: controller.subscriptionPlans.value.isActive??false,
                billingFrequency: controller.subscriptionPlans.value.subscriptionType??""!,
                price: controller.subscriptionPlans.value.price??0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
