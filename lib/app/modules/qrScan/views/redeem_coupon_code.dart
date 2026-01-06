import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/fsv_textfield.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:get/get.dart';
import '../../../constants/string_constant.dart';
import '../../../services/text_style_util.dart';
import '../controllers/qr_scan_controller.dart';

class RedeemCouponCode extends GetView<QrScanController> {
  const RedeemCouponCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: StringConstant.redeemCouponCode,
      ),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: EdgeInsets.all(12.kw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.kheightBox,
                Text(StringConstant.enterCodeBelow,
                    style: TextStyleUtil.manrope14w500(color: context.black04)),
                40.kheightBox,

                /// 🔹 SELECT USER
                Text(
                  StringConstant.selectuser,
                  style: TextStyleUtil.manrope14w500(color: context.black01),
                ),
                6.kheightBox,

                GestureDetector(
                  onTap: () => _openPremiumUserSheet(context),
                  child: Obx(() {
                    final user = controller.selectedPremiumUser.value;
                    return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.kh, horizontal: 16.kw),
                      decoration: BoxDecoration(
                        color: context.loginSignupTextfieldColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: user == null
                              ? context.black07
                              : context.primary01,
                        ),
                      ),
                      child: Row(
                        children: [
                          if (user != null)
                            CircleAvatar(
                              radius: 14,
                              backgroundImage: user.profilePic != null
                                  ? NetworkImage(user.profilePic!)
                                  : null,
                            ),
                          if (user != null) 8.kwidthBox,
                          Expanded(
                            child: Text(
                              user?.name ?? StringConstant.selectuser,
                              style: TextStyleUtil.manrope14w500(
                                color: user == null
                                    ? context.black04
                                    : context.black01,
                              ),
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    );
                  }),
                ),

                /// ❌ USER VALIDATION
                Obx(() {
                  if (controller.showUserError.value) {
                    return Padding(
                      padding: EdgeInsets.only(top: 4.kh),
                      child: Text(
                        "Please select a user",
                        style: TextStyleUtil.manrope12w400(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),

                20.kheightBox,

                /// 🔹 COUPON CODE
                Text(
                  StringConstant.couponCode,
                  style: TextStyleUtil.manrope14w500(color: context.black01),
                ),
                6.kheightBox,

                FsvTextfield(
                  hintText: StringConstant.enterCouponCode,
                  controller: controller.couponCodeController,
                  maxLength: 20,
                  onChanged: (_) => controller.updateRedeemState(),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Coupon code required";
                    }
                    return null;
                  },
                ),

                const Spacer(),

                /// 🔘 REDEEM BUTTON
                Obx(() {
                  return CustomRedElevatedButton(
                    buttonText: StringConstant.redeem,
                    height: 56.kh,
                    width: double.infinity,
                    buttonColor:
                        controller.canRedeem.value ? null : context.primary06,
                    textStyle: controller.canRedeem.value
                        ? null
                        : TextStyleUtil.manrope16w500(color: context.black03),
                    onPressed: controller.canRedeem.value
                        ? () {
                            controller.showUserError.value = false;
                            controller.redeemCode(
                              userId: controller.selectedPremiumUser.value!.id!,
                            );
                          }
                        : () {
                            controller.showUserError.value =
                                controller.selectedPremiumUser.value == null;
                          },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔽 USER BOTTOM SHEET
  void _openPremiumUserSheet(BuildContext context) {
    Get.bottomSheet(
      SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.kh),
              child: FsvTextfield(
                hintText: StringConstant.searchUser,
                onChanged: (value) {
                  controller.onSearch(value ?? '');
                },
                fillColor: context.loginSignupTextfieldColor,
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.premiumUsers.isEmpty) {
                  return const Center(child: Text("No users found"));
                }

                return ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.premiumUsers.length +
                      (controller.isMoreLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.premiumUsers.length) {
                      return const Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final user = controller.premiumUsers[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePic ?? ''),
                      ),
                      title: Text(user.name ?? ''),
                      onTap: () {
                        controller.selectedPremiumUser.value = user;
                        controller.showUserError.value = false;
                        controller.updateRedeemState();
                        Get.back();
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xffFAFAFA),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }
}
