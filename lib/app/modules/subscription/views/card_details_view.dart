import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';

import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/controllers/subscription_controller.dart';

import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutterme_credit_card/flutterme_credit_card/utils/constants.dart';
import 'package:flutterme_credit_card/flutterme_credit_card/widgets/field/hold_field.dart';
import 'package:flutterme_credit_card/flutterme_credit_card/widgets/card/credit_card.dart';

class CardDetailsView extends GetView<SubscriptionController> {
  const CardDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: StringConstant.cardDetails),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.kh),
        child: SingleChildScrollView(
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
              Obx(() => FMCreditCard(
                  numberMaskType: FMMaskType.full,
                  cvvMaskType: FMMaskType.full,
                  validThruMaskType: FMMaskType.none,
                  number: controller.cardNumber.value,
                  validThru: controller.expiryDate.value,
                  holder: controller.cardHolderName.value,
                  cvv: controller.cvvCode.value)),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    FMHolderField(
                      controller: controller.eCardHolderName,
                      cursorColor: const Color(0xFF49B7AE),
                      onChanged: (value) {
                        controller.cardHolderName.value = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Card Holder Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    12.kheightBox,
                    CardField(
                      onCardChanged: (card) {
                        controller.cardNumber.value = card?.number ?? "";
                        controller.expiryDate.value =
                            "${card?.expiryMonth ?? ""}/${card?.expiryYear ?? ""}";
                        controller.cvvCode.value = card?.cvc ?? "";
                        controller.cardDetails.value = card;
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        prefixIcon: Platform.isAndroid
                            ? const Icon(Icons.credit_card)
                            : null,
                      ),
                    ),
                    40.kheightBox,
                  ],
                ).paddingAll(16),
              ),
              CustomRedElevatedButton(
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
              30.kheightBox,
            ],
          ),
        ),
      ),
    );
  }
}
