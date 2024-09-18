import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/current_plan_card.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/empty_widget.dart';
import 'package:fsauce_vendor_app/app/components/plan_card.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/plan_model.dart';
import 'package:fsauce_vendor_app/app/models/subscription_model.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/custom_button.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.black07,
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
        floatingActionButton: Obx(() {
          if (controller.showList.value) {
            return CustomRedElevatedButton(
              buttonText: controller.selectedPlan.value.Id != null
                  ? StringConstant.purchasePlan
                  : "Select a plan",
              buttonColor: controller.selectedPlan.value.Id != null
                  ? null
                  : context.black05,
              height: 56.kh,
              width: MediaQuery.of(context).size.width * 0.9,
              onPressed: () {
                if (controller.selectedPlan.value.Id != null) {
                  controller.goToPurchasePlanView();
                }
              },
            );
          } else {
            return Container();
          }
        }),
        body: Column(
          children: [
            10.kheightBox,
            Obx(() {
              if (controller.showList.value) {
                return Text(
                  StringConstant.buySubscriptionText,
                  style: TextStyleUtil.manrope16w600(),
                );
              } else {
                return Container();
              }
            }),
            10.kheightBox,
            Obx(() {
              if (!controller.showList.value) {
                String validTill = Get.find<HomeController>()
                            .restaurantDetails
                            .value
                            .subscriptionModel ==
                        null
                    ? ""
                    : Get.find<HomeController>()
                            .restaurantDetails
                            .value
                            .subscriptionModel!
                            .endDate ??
                        "";
                return SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.kw, vertical: 16.kh),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        12.kheightBox,
                        Text(StringConstant.currentPlan,
                            style: TextStyleUtil.manrope16w600()),
                        12.kheightBox,
                        Obx(() {
                          return Container(
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
                                    Text(
                                        controller.currentPlan.value.title ??
                                            "",
                                        style: TextStyleUtil.manrope18w600()),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Container(
                                        height: 40.kh,
                                        width: 81.kw,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8.kh, horizontal: 16.kw),
                                        decoration: BoxDecoration(
                                          color: controller.currentPlan.value
                                                      .isActive ==
                                                  null
                                              ? context.green
                                              : controller.currentPlan.value
                                                      .isActive!
                                                  ? context.green
                                                  : context.primary01,
                                          borderRadius:
                                              BorderRadius.circular(8.kw),
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller.currentPlan.value
                                                        .isActive ==
                                                    null
                                                ? StringConstant.active
                                                : controller.currentPlan.value
                                                        .isActive!
                                                    ? StringConstant.active
                                                    : StringConstant.inactive,
                                            style: TextStyleUtil.manrope16w500(
                                                color: Colors.white),
                                          ),
                                        ))
                                  ],
                                ),
                                12.kheightBox,
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "\$${controller.currentPlan.value.price ?? 0.0}",
                                      style: TextStyleUtil.manrope20w600(
                                          color: context.primary01),
                                    ),
                                    Text(
                                        " /${controller.currentPlan.value.billedFrequency ?? ""}",
                                        style: TextStyleUtil.manrope20w600(
                                            color: context.black03)),
                                  ],
                                ),
                                8.kheightBox,
                                Text(
                                    "Valid till ${controller.formatDateString(validTill) ?? "18 March 2026"}",
                                    style: TextStyleUtil.manrope16w500(
                                        color: context.black03)),
                                20.kheightBox,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FsvButton(
                                      isBorder: true,
                                      height: 40.kh,
                                      width: 144.kw,
                                      padding: const EdgeInsets.all(0),
                                      labelTextStyle:
                                          TextStyleUtil.manrope14w500(
                                              color: context.primary01),
                                      label: controller.isCancelled.value
                                          ? StringConstant.cancelled
                                          : StringConstant.cancel,
                                      onPressed: () {
                                        controller.isCancelled.value
                                            ? () {}
                                            : controller
                                                .confirmCancelSubscription();
                                      },
                                    ),
                                    FsvButton(
                                      height: 40.kh,
                                      width: 144.kw,
                                      padding: const EdgeInsets.all(0),
                                      label: StringConstant.upgrade,
                                      labelTextStyle:
                                          TextStyleUtil.manrope14w500(
                                              color: context.white),
                                      onPressed: () {
                                        controller.isCancelled.value
                                            ? () {}
                                            : controller.showList.value = true;
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                );
              } else if (controller.showList.value) {
                return ListView.separated(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.kh, horizontal: 16.kw),
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return PlanCard(
                          plan: controller.subscriptionPlans[index]);
                    },
                    separatorBuilder: (ctx, index) {
                      return 4.kheightBox;
                    },
                    itemCount: controller.subscriptionPlans.length);
              } else if (controller.subscriptionPlans.isEmpty) {
                return Center(child: EmptyWidget());
              } else {
                return Container();
              }
            })
          ],
        ));
  }
}

// return CurrentPlanCard(
// title: controller.currentPlan.value.title ?? "",
// validTill: controller.formatDateString(validTill) ??
// "18 March 2026",
// active: controller.currentPlan.value.isActive ??
// true,
// billingFrequency: controller.currentPlan.value
//     .billedFrequency ?? "",
// price: controller.currentPlan.value.price ?? 0.0,
// );
