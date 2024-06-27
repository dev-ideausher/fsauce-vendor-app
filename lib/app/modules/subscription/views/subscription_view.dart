import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/plan_card.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class SubscriptionView extends GetView<SubscriptionController>{
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back,),
        ),
        centerTitle: true,
        title: Text(StringConstant.subscriptions, style: TextStyleUtil.manrope18w600(),),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(StringConstant.buySubscriptionText, style: TextStyleUtil.manrope16w600(),),
              4.kheightBox,
              Text(StringConstant.plansAvailableText, style: TextStyleUtil.manrope14w500(color: context.black04),),
              8.kheightBox,
              PlanCard(planTitle: controller.totalPlans[0], planPrice: 500.0,),
              8.kheightBox,
              PlanCard(planTitle: controller.totalPlans[1], planPrice: 500.0,),
              8.kheightBox,
              PlanCard(planTitle: controller.totalPlans[2], planPrice: 500.0,),
              20.kheightBox,
              CustomRedElevatedButton(
                buttonText: StringConstant.purchasePlan,
                height: 56.kh,
                width: MediaQuery.of(context).size.width * 0.9,
                onPressed: controller.goToPurchasePlanView,
              )
            ],
          ),
        ),
      ),
    );
  }
}