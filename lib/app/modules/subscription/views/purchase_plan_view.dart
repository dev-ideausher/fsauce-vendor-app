import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/selected_plan_card.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class PurchasePlanView extends GetView<SubscriptionController> {
  PurchasePlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          StringConstant.purchasePlan,
          style: TextStyleUtil.manrope18w600(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.kw),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                const SelectedPlanCard(),
                16.kheightBox,
                Container(
                  height: 88.kh,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.kw, vertical: 8.kh),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.kh),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text(
                        StringConstant.paymentMethod,
                        style: TextStyleUtil.manrope16w600(),
                      ),
                      subtitle: Obx(() {
                        return Text(
                          controller.selectedCard.value.id == null ? StringConstant.razorPay : "**** **** *${controller.selectedCard.value
                              .last4 ?? "1212"}",
                          style:
                          TextStyleUtil.manrope14w500(color: context.black03),
                        );
                      }),
                      trailing: TextButton(
                          onPressed: controller.goToPaymentMethodView,
                          child: Text(
                            StringConstant.change,
                            style: TextStyleUtil.manrope14w500(
                                color: context.primary01,
                                textDecoration: TextDecoration.underline),
                          )),
                    ),
                  ),
                ),
                16.kheightBox,
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringConstant.promotions,
                      style: TextStyleUtil.manrope16w600(),
                    )),
                16.kheightBox,
                Container(
                    height: 56.kh,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9,
                    padding:
                    EdgeInsets.symmetric(horizontal: 12.kw, vertical: 8.kh),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.kh),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: context.primary01,
                            size: 24.kh,
                          ),
                          16.kwidthBox,
                          Expanded(
                            child: TextFormField(
                              controller: controller.promoCodeController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: StringConstant.addPromoCode,
                                  hintStyle: TextStyleUtil.manrope14w500()),
                            ),
                          )
                        ],
                      ),
                    )),
                36.kheightBox,
                Container(
                  height: 166.kh,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  padding: EdgeInsets.all(16.kh),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.kh),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        StringConstant.billingDetails,
                        style: TextStyleUtil.manrope16w600(),
                      ),
                      12.kheightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            StringConstant.totalAmount,
                            style: TextStyleUtil.manrope14w500(
                                color: context.black03),
                          ),
                          Obx(() {
                            return Text(
                              controller.selectedPlan.value.price.toString() ??
                                  "\$500",
                              style: TextStyleUtil.manrope14w500(),
                            );
                          }),
                        ],
                      ),
                      8.kheightBox,
                      controller.promoCodeController.text.isNotEmpty ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            StringConstant.totalAmount,
                            style: TextStyleUtil.manrope14w500(
                                color: context.black03),
                          ),
                          Text(
                            "\$50",
                            style: TextStyleUtil.manrope14w500(),
                          ),
                        ],
                      ) : Container(),
                      8.kheightBox,
                      Divider(
                        color: context.black07,
                      ),
                      8.kheightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            StringConstant.totalPayable,
                            style: TextStyleUtil.manrope16w500(),
                          ),
                          Text(
                            controller.selectedPlan.value.price.toString() ??
                                "\$450",
                            style: TextStyleUtil.manrope16w600(
                                color: context.primary01),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomRedElevatedButton(
          buttonText: StringConstant.proceed,
          height: 56.kh,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.9,
          onPressed: () {
            controller.addVendorSubscription();
          }),
    );
  }
}
