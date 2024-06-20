import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_text_box.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/components/select_container.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/create_or_edit_vip_offer_controller.dart';

class CreateOrEditVipOfferView extends GetView<CreateOrEditVipOfferController> {
  const CreateOrEditVipOfferView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: Get.arguments[0]
              ? StringConstant.editVipOffer
              : StringConstant.vipOffers,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.kw),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    StringConstant.vipOfferTitle,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Text(
                    "*",
                    style:
                    TextStyleUtil.manrope14w500(color: context.primary01),
                  )
                ],
              ),
              10.kheightBox,
              CustomTextField(
                  controller: controller.titleController,
                  fillColor: context.loginSignupTextfieldColor,
                  border: Border.all(color: context.black07),
                  hintText: StringConstant.enterTitle),
              20.kheightBox,
              Row(
                children: [
                  Text(
                    StringConstant.typeOfOffer,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Text(
                    "*",
                    style:
                    TextStyleUtil.manrope14w500(color: context.primary01),
                  )
                ],
              ),
              10.kheightBox,
              Obx(() {
                return Row(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.selectedTypeOfOffer.value = 0;
                      },
                      child: SelectContainer(
                          title: StringConstant.dealsOfTheDay,
                          isSelected: controller.typeOfOffers.elementAt(
                              controller.selectedTypeOfOffer.value) ==
                              StringConstant.dealsOfTheDay),
                    ),
                    16.kwidthBox,
                    InkWell(
                      onTap: () {
                        controller.selectedTypeOfOffer.value = 1;
                      },
                      child: SelectContainer(
                          title: StringConstant.normalOffer,
                          isSelected: controller.typeOfOffers.elementAt(
                              controller.selectedTypeOfOffer.value) ==
                              StringConstant.normalOffer),
                    )
                  ],
                );
              }),
              20.kheightBox,
              Row(
                children: [
                  Text(
                    StringConstant.validFor,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Text(
                    "*",
                    style:
                    TextStyleUtil.manrope14w500(color: context.primary01),
                  )
                ],
              ),
              10.kheightBox,
              Obx(() {
                return Row(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.selectedValidForOption.value = 0;
                      },
                      child: SelectContainer(
                          title: StringConstant.dineIn, isSelected: controller.validForOptions.elementAt(
                          controller.selectedValidForOption.value) ==
                          StringConstant.dineIn),
                    ),
                    16.kwidthBox,
                    InkWell(
                      onTap: () {
                        controller.selectedValidForOption.value = 1;
                      },
                      child: SelectContainer(
                          title: StringConstant.takeAway, isSelected: controller.validForOptions.elementAt(
                          controller.selectedValidForOption.value) ==
                          StringConstant.takeAway),
                    )
                  ],
                );
              }),
              20.kheightBox,
              Row(
                children: [
                  Text(
                    StringConstant.validTill,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Text(
                    "*",
                    style:
                    TextStyleUtil.manrope14w500(color: context.primary01),
                  )
                ],
              ),
              10.kheightBox,
              CustomTextField(
                controller: controller.validTillDateController,
                  fillColor: context.loginSignupTextfieldColor,
                  border: Border.all(color: context.black07),
                  suffixIcon: Icons.calendar_month,
                  suffixOnPressed: () {
                    showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 2 * 365)),

                    ).then((pickedDate){
                      if(pickedDate != null){
                        controller.validTillDateController.text = pickedDate.toString().substring(0, 11);
                      }
                    });
                  },
                  hintText: StringConstant.enterValidTill),
              20.kheightBox,
              Row(
                children: [
                  Text(
                    StringConstant.vipOfferDescription,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Text(
                    "*",
                    style:
                    TextStyleUtil.manrope14w500(color: context.primary01),
                  )
                ],
              ),
              10.kheightBox,
              CustomTextBox(
                controller: controller.descriptionController,
                  fillColor: context.loginSignupTextfieldColor,
                  border: Border.all(color: context.black07),
                  hintText: StringConstant.enterDescription),
              20.kheightBox,
              Row(
                children: [
                  Text(
                    StringConstant.termsAndConditions,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Text(
                    "*",
                    style:
                    TextStyleUtil.manrope14w500(color: context.primary01),
                  )
                ],
              ),
              10.kheightBox,
              CustomTextBox(
                controller: controller.termsAndConditionsController,
                  fillColor: context.loginSignupTextfieldColor,
                  border: Border.all(color: context.black07),
                  hintText: StringConstant.enterTermsAndConditions),
              20.kheightBox,
              Row(
                children: [
                  Text(
                    StringConstant.scheduleDateAndTime,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Text(
                    " (optional)",
                    style: TextStyleUtil.manrope14w500(color: context.black03),
                  )
                ],
              ),
              10.kheightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50.kh,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: context.loginSignupTextfieldColor,
                      border: Border.all(color: context.black07),
                      borderRadius: BorderRadius.circular(8.0.kw),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            maxLines: null,
                            controller: controller.scheduleDateController,
                            decoration: InputDecoration(
                              hintText: StringConstant.enterDate,
                              hintStyle: TextStyleUtil.manrope14w400(
                                  color: context.black04),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 2 * 365))
                            ).then((pickedDate){
                              if(pickedDate != null){
                                controller.scheduleDateController.text = pickedDate.toString().substring(0, 11);
                              }
                            });
                          },
                          icon: Icon(Icons.calendar_month,
                            color: context.black01,)
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50.kh,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: context.loginSignupTextfieldColor,
                      border: Border.all(color: context.black07),
                      borderRadius: BorderRadius.circular(8.0.kw),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            maxLines: null,
                            controller: controller.scheduleTimeController,
                            decoration: InputDecoration(
                              hintText: StringConstant.enterTime,
                              hintStyle: TextStyleUtil.manrope14w400(
                                  color: context.black04),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now()
                            ).then((pickedTime){
                              if(pickedTime != null){
                                controller.scheduleTimeController.text = pickedTime.format(context);
                              }
                            });
                          },
                          icon: Icon(Icons.watch_later_outlined,
                            color: context.black01)
                        )
                      ],
                    ),
                  )
                ],
              ),
              30.kheightBox,
              CustomRedElevatedButton(
                  buttonText: Get.arguments[0]
                      ? StringConstant.save
                      : StringConstant.create,
                  height: 56.kh,
                  width: 100.w,
                  onPressed: () {
                    controller.addCoupon().then((bool value) {
                      value ? controller.showUpdatedBottomSheet
                          : controller.showCreatedBottomSheet;
                    });
                  },
                      ),
              30.kheightBox,
            ],
          ),
        ));
  }
}
