import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_button_with_border.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../../../components/confirmation_dialog.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/loyalty_controller.dart';

class LoyaltyView extends GetView<LoyaltyController> {
  const LoyaltyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: StringConstant.loyaltyCard),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.kw),
          child: Obx(() => Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          StringConstant.cardDetails,
                          style: TextStyleUtil.manrope16w600(),
                        ),
                        6.kwidthBox,
                        Expanded(
                            child: Divider(
                          color: context.black05,
                        ))
                      ],
                    ),
                    20.kheightBox,
                    Row(
                      children: [
                        Text(
                          StringConstant.offerTitle,
                          style: TextStyleUtil.manrope14w500(),
                        ),
                        Text(
                          "*",
                          style: TextStyleUtil.manrope14w500(
                              color: context.primary01),
                        )
                      ],
                    ),
                    10.kheightBox,
                    CustomTextField(
                        validator: (String? val) {
                          if (val == null || val.isEmpty) {
                            return StringConstant.offerTitleCannotBeEmpty;
                          }
                          return null;
                        },
                        maxLength: 30,
                        controller: controller.cardTitleController,
                        fillColor: context.loginSignupTextfieldColor,
                        border: Border.all(color: context.black07),
                        hintText: StringConstant.enterOfferTitle),
                    20.kheightBox,
                    Row(
                      children: [
                        Text(
                          StringConstant.numberOfStamps,
                          style: TextStyleUtil.manrope14w500(),
                        ),
                        Text(
                          "*",
                          style: TextStyleUtil.manrope14w500(
                              color: context.primary01),
                        )
                      ],
                    ),
                    10.kheightBox,
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: context.borderColor2),
                          borderRadius: BorderRadius.circular(8.kw)),
                      padding: EdgeInsets.symmetric(horizontal: 10.kw),
                      child: Row(
                        children: [
                          Expanded(
                              child: DropdownButtonFormField<String>(
                            validator: (String? val) {
                              if (val == null || val.isEmpty) {
                                return StringConstant.noOfStampsCannotBeEmpty;
                              }
                              return null;
                            },
                            style: TextStyleUtil.manrope16w400(),
                            onChanged: (val) {
                              if (val != null) {
                                controller.noOfStamps.value = int.parse(val);
                              }
                            },
                            items: <String>["1", "2", "3", "4", "5", "6"]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0),
                              hintText: StringConstant.selectNumberOfStamps,
                              hintStyle: TextStyleUtil.manrope14w400(
                                  color: context.black04),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                    20.kheightBox,
                    Row(
                      children: [
                        Text(
                          StringConstant.validTill,
                          style: TextStyleUtil.manrope14w500(),
                        ),
                        Text(
                          "*",
                          style: TextStyleUtil.manrope14w500(
                              color: context.primary01),
                        )
                      ],
                    ),
                    10.kheightBox,
                    CustomTextField(
                        readOnly: true,
                        validator: (String? val) {
                          if (val == null || val.isEmpty) {
                            return StringConstant.dateCannotBeEmpty;
                          }
                          return null;
                        },
                        controller: controller.validTillDateController,
                        fillColor: context.loginSignupTextfieldColor,
                        border: Border.all(color: context.black07),
                        suffixIcon: Icons.calendar_month,
                        suffixOnPressed: () {
                          controller.pickValidTillDate(context);
                        },
                        hintText: StringConstant.enterValidTill),
                    20.kheightBox,
                    Row(
                      children: [
                        Text(
                          StringConstant.cardBackground,
                          style: TextStyleUtil.manrope16w600(),
                        ),
                        6.kwidthBox,
                        Expanded(
                            child: Divider(
                          color: context.black05,
                        ))
                      ],
                    ),
                    20.kheightBox,
                    Row(
                      children: [
                        Text(
                          StringConstant.backgroundColor,
                          style: TextStyleUtil.manrope14w500(),
                        ),
                        Text(
                          "*",
                          style: TextStyleUtil.manrope14w500(
                              color: context.primary01),
                        )
                      ],
                    ),
                    10.kheightBox,
                    Container(
                      height: 53.kh,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: context.loginSignupTextfieldColor,
                        border: Border.all(color: context.borderColor2),
                        borderRadius: BorderRadius.circular(8.0.kw),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: controller.backgroundColor.value,
                                  border:
                                      Border.all(color: context.borderColor1))),
                          10.kwidthBox,
                          Text(
                            "#${controller.backgroundColor.value.toString().substring(10, 16).toUpperCase()}",
                            style: TextStyleUtil.manrope14w400(),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: controller.openBackgroundColorpalet,
                            child: CommonImageView(
                              svgPath: ImageConstant.colorPicker,
                            ),
                          )
                        ],
                      ),
                    ),
                    20.kheightBox,
                    Row(
                      children: [
                        Text(
                          StringConstant.textColor,
                          style: TextStyleUtil.manrope14w500(),
                        ),
                        Text(
                          "*",
                          style: TextStyleUtil.manrope14w500(
                              color: context.primary01),
                        )
                      ],
                    ),
                    10.kheightBox,
                    Container(
                      height: 53.kh,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: context.loginSignupTextfieldColor,
                        border: Border.all(color: context.borderColor2),
                        borderRadius: BorderRadius.circular(8.0.kw),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: controller.textColor.value,
                                  border:
                                      Border.all(color: context.borderColor1))),
                          10.kwidthBox,
                          Text(
                            "#${controller.textColor.value.toString().substring(10, 16).toUpperCase()}",
                            style: TextStyleUtil.manrope14w400(),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: controller.openTextColorpalet,
                            child: CommonImageView(
                              svgPath: ImageConstant.colorPicker,
                            ),
                          )
                        ],
                      ),
                    ),
                    30.kheightBox,
                    CustomRedElevatedButton(
                        buttonText: StringConstant.save,
                        width: 100.w,
                        height: 56.kh,
                        onPressed: () {
                          if (Get.find<HomeController>()
                                  .restaurantDetails
                                  .value
                                  .subscriptionModel !=
                              null) {
                            if (controller.formKey.currentState!.validate()) {
                              controller.createLoyaltyCard();
                            }
                          } else {
                            Get.dialog(ConfrimationDialog(
                                title: StringConstant.subscriptionRequired,
                                subTitle:
                                    StringConstant.subscriptionRequiredText,
                                yesButtonText:
                                    StringConstant.checkoutSubscriptions,
                                noButtonText: StringConstant.close,
                                onYesTap: () async {
                                  // Get.find<GetStorageService>().logout();
                                  Get.back();
                                  Get.offNamed(Routes.SUBSCRIPTION);
                                },
                                onNoTap: Get.back));
                          }
                        }),
                    10.kheightBox,
                    CustomRedElevatedButtonWithBorder(
                        buttonText: StringConstant.previewCard,
                        width: 100.w,
                        height: 56.kh,
                        onPressed: controller.gotoPreviewScreen),
                    10.kheightBox
                  ],
                ),
              )),
        ));
  }
}

class ColorPickerDialog extends StatelessWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPickerDialog({
    Key? key,
    required this.initialColor,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
              color: initialColor,
              onChanged: onColorChanged,
              initialPicker: Picker.paletteHue,
            ),
            20.kheightBox,
          ],
        ),
      ),
    );
  }
}
