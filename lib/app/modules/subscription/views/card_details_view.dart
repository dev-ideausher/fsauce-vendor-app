import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/fsv_textfield.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class CardDetailsView extends GetView<SubscriptionController> {
  CardDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: StringConstant.cardDetails),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.kh),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            child: IntrinsicHeight(
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    16.kheightBox,
                    Text(
                      StringConstant.addNewCard,
                      style: TextStyleUtil.manrope18w600(),
                    ),
                    32.kheightBox,
                    Text(
                      StringConstant.cardNumber,
                      style: TextStyleUtil.manrope14w500(),
                    ),
                    16.kheightBox,
                    FsvTextfield(
                      hintText: StringConstant.enterCardNumber,
                      maxLength: 16,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      keyboardType: TextInputType.number,
                      controller: controller.cardNumberController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? val) {
                        if (val == null || val.isEmpty) {
                          return StringConstant.cardNoEmpty;
                        } else if (val.length < 13) {
                          return StringConstant.less13;
                        } else if (!val.isNumericOnly) {
                          return StringConstant.onlyNoAllowed;
                        }
                        return null;
                      },
                    ),
                    16.kheightBox,
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringConstant.expires,
                              style: TextStyleUtil.manrope14w500(),
                            ),
                            16.kheightBox,
                            SizedBox(
                              width: 40.w,
                              child: FsvTextfield(
                                hintText: StringConstant.expiryDateMMYY,
                                maxLength: 5,
                                controller: controller.expiresController,
                                isSuffixPaddingNeeded: false,
                                isSuffixNeeded: false,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s')),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9/]')),
                                  TextInputFormatter.withFunction(
                                      (oldValue, newValue) {
                                    String text = newValue.text;
                                    if (newValue.text.length == 2 &&
                                        oldValue.text.length != 3) {
                                      text += '/';
                                    }
                                    if (newValue.text.length == 5 &&
                                        oldValue.text.length != 6) {
                                      text += '/';
                                    }
                                    return TextEditingValue(text: text);
                                  })
                                ],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (String? val) {
                                  if (val == null || val.isEmpty) {
                                    return StringConstant.expiryDateEmpty;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringConstant.cvv,
                              style: TextStyleUtil.manrope14w500(),
                            ),
                            16.kheightBox,
                            SizedBox(
                              width: 40.w,
                              child: FsvTextfield(
                                hintText: StringConstant.enterCVV,
                                maxLength: 3,
                                isSuffixPaddingNeeded: false,
                                isSuffixNeeded: false,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s')),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9/]')),
                                ],
                                keyboardType: TextInputType.number,
                                obscureText: true,
                                controller: controller.cvvController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (String? val) {
                                  if (val == null || val.isEmpty) {
                                    return StringConstant.cvvEmpty;
                                  } else if (val.length != 3) {
                                    return StringConstant.cvv3Digits;
                                  } else if (!val.isNumericOnly) {
                                    return StringConstant.invalidCvv;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    16.kheightBox,
                    Text(
                      StringConstant.nameOnCard,
                      style: TextStyleUtil.manrope14w500(),
                    ),
                    16.kheightBox,
                    FsvTextfield(
                      hintText: StringConstant.enterCardHolderName,
                      controller: controller.nameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? val) {
                        if (val == null || val.isEmpty) {
                          return StringConstant.nameCannotBeEmpty;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomRedElevatedButton(
        buttonText: StringConstant.save,
        height: 56.kh,
        width: MediaQuery.of(context).size.width * 0.9,
        onPressed: () {
          if (controller.formKey.currentState!.validate()) {
            controller.addCard();
            // Get.bottomSheet(const AddedSuccessfullBottomSheet(subTitle: StringConstant.cardSavedSuccessfully));
          }
        },
      ),
    );
  }
}
