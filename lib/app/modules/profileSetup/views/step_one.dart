import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fsauce_vendor_app/app/components/custom_text_box.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/profileSetup/controllers/profile_setup_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

import '../../../components/custom_red_elevated_button.dart';
import '../../../models/cuisine_model.dart';

class StepOne extends GetView<ProfileSetupController> {
  StepOne({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Restaurant Name
          Row(
            children: [
              Text(
                StringConstant.restaurantName,
                style: TextStyleUtil.manrope14w500(),
              ),
              Text(
                "*",
                style: TextStyleUtil.manrope14w500(color: context.primary01),
              )
            ],
          ),
          6.kheightBox,
          CustomTextField(
            validator: (String? val){
              if(val == null || val.isEmpty){
                return "Restaurant name cannot be empty!";
              }
              return null;
            },
            fillColor: context.loginSignupTextfieldColor,
            border: Border.all(color: context.black07),
            controller: controller.restaurantNameController,
            hintText: StringConstant.enterRestaurantName,
          ),
          10.kheightBox,

          // Restaurant Logo
          Row(
            children: [
              Text(
                StringConstant.restaurantLogo,
                style: TextStyleUtil.manrope14w500(),
              ),
              Text(
                "*",
                style: TextStyleUtil.manrope14w500(color: context.primary01),
              )
            ],
          ),
          Text(
            StringConstant.pngJpgJpeg,
            style: TextStyleUtil.manrope14w500(color: context.black03),
          ),
          6.kheightBox,
          Obx(() =>
              InkWell(
                onTap: () => controller.pickImage(controller.restaurantLogo),
                child: Container(
                  width: 100.w,
                  height: 100.kh,
                  decoration: BoxDecoration(
                    color: context.loginSignupTextfieldColor,
                    borderRadius: BorderRadius.circular(8.kw),
                    border: RDottedLineBorder.all(
                      color: context.black07,
                      width: 2,
                    ),
                  ),
                  child: controller.restaurantLogo.value.isEmpty
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.file_upload_outlined),
                      10.kheightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StringConstant.uploadFile,
                            style: TextStyleUtil.manrope14w500(
                                color: context.primary01),
                          ),
                          4.kwidthBox,
                          Text(
                            StringConstant.or,
                            style: TextStyleUtil.manrope14w500(
                                color: context.black04),
                          ),
                          4.kwidthBox,
                          Text(
                            StringConstant.selectFile,
                            style: TextStyleUtil.manrope14w500(
                                color: context.primary01),
                          ),
                        ],
                      )
                    ],
                  )
                      : Image.file(
                    File(controller.restaurantLogo.value),
                    fit: BoxFit.contain,
                  ),
                ),
              )),
          10.kheightBox,
          // Restaurant Banner Image
          Row(
            children: [
              Text(
                StringConstant.restaurantBannerImage,
                style: TextStyleUtil.manrope14w500(),
              ),
              Text(
                "*",
                style: TextStyleUtil.manrope14w500(color: context.primary01),
              )
            ],
          ),
          6.kheightBox,
          Obx(() =>
              InkWell(
                onTap: () => controller.pickImage(controller.restaurantBanner),
                child: Container(
                  height: 160.kh,
                  width: 100.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: context.black07),
                    borderRadius: BorderRadius.circular(8.kw),
                    color: context.loginSignupTextfieldColor,
                  ),
                  child: controller.restaurantBanner.value.isEmpty
                      ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.file_upload_outlined),
                        2.kwidthBox,
                        Text(
                          StringConstant.uploadPhoto,
                          style: TextStyleUtil.manrope14w400(
                              color: context.black03),
                        )
                      ],
                    ),
                  )
                      : Image.file(
                    File(controller.restaurantBanner.value),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          10.kheightBox,
          // Average Price for 2
          Row(
            children: [
              Text(
                StringConstant.avgPriceFor2,
                style: TextStyleUtil.manrope14w500(),
              ),
              Text(
                "*",
                style: TextStyleUtil.manrope14w500(color: context.primary01),
              )
            ],
          ),
          6.kheightBox,
          CustomTextField(
            validator: (String? val) {
              if(val == null || val.isEmpty || int.parse(val) == 0){
                return "Average price for 2 cannot be empty!";
              }
              return null;
            },
            fillColor: context.loginSignupTextfieldColor,
            border: Border.all(color: context.black07),
            controller: controller.averagePriceController,
            hintText: StringConstant.enterPrice,
            keyboardType: TextInputType.number,
          ),
          10.kheightBox,

          // Description
          Row(
            children: [
              Text(
                StringConstant.description,
                style: TextStyleUtil.manrope14w500(),
              ),
              Text(
                "*",
                style: TextStyleUtil.manrope14w500(color: context.primary01),
              )
            ],
          ),
          6.kheightBox,
          CustomTextBox(
            validator: (String? val){
              if(val == null || val.isEmpty){
                return "Description cannot be empty!";
              }
              return null;
            },
            fillColor: context.loginSignupTextfieldColor,
            border: Border.all(color: context.black07),
            controller: controller.descriptionController,
            hintText: StringConstant.enterDescription,
          ),
          10.kheightBox,
          Row(
            children: [
              Text(
                StringConstant.cuisine,
                style: TextStyleUtil.manrope14w500(),
              ),
              Text(
                "*",
                style: TextStyleUtil.manrope14w500(color: context.primary01),
              )
            ],
          ),
          10.kheightBox,
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: context.borderColor2),
                borderRadius: BorderRadius.circular(8.kw)),
            padding: EdgeInsets.symmetric(horizontal: 10.kw),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  return Expanded(
                      child: DropdownButtonFormField<CuisineModel>(
                        dropdownColor: Colors.white,
                        style: TextStyleUtil.manrope16w400(),
                        onChanged: (val) {
                          if (val != null) {
                            controller.selectedCuisines.add(val);
                          }
                        },
                        items: controller.cuisineModels
                            .map<DropdownMenuItem<CuisineModel>>((
                            CuisineModel value) {
                          return DropdownMenuItem<CuisineModel>(
                            value: value,
                            child: Text(value.name!),
                          );
                        }).toList(),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          hintText: StringConstant.selectCuisine,
                          hintStyle: TextStyleUtil.manrope14w400(
                              color: context.black04),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ));
                }),
              ],
            ),
          ),
          20.kheightBox,
          Row(
            children: <Widget>[
              Text(
                StringConstant.location, style: TextStyleUtil.manrope18w600(),),
              4.kwidthBox,
              const Divider(),
            ],
          ),
          20.kheightBox,
          Row(
            children: [
              Text(StringConstant.streetNameNo,
                style: TextStyleUtil.manrope14w500(),),
              Text(
                "*",
                style: TextStyleUtil.manrope14w500(color: context.primary01),
              )
            ],
          ),
          6.kheightBox,
          CustomTextField(
            validator: (String? val) {
              if(val == null || val.isEmpty){
                return "street name cannot be empty!";
              }
              return null;
            },
            fillColor: context.loginSignupTextfieldColor,
            border: Border.all(color: context.black07),
            controller: controller.streetNameController,
            hintText: StringConstant.enterLocation,
          ),
          10.kheightBox,
          Row(
            children: [
              Text(
                StringConstant.cityTown, style: TextStyleUtil.manrope14w500(),),
              Text(
                "*",
                style: TextStyleUtil.manrope14w500(color: context.primary01),
              )
            ],
          ),
          6.kheightBox,
          CustomTextField(
            validator: (String? val) {
              if(val == null || val.isEmpty){
                return "city name cannot be empty!";
              }
              return null;
            },
            fillColor: context.loginSignupTextfieldColor,
            border: Border.all(color: context.black07),
            controller: controller.cityNameController,
            hintText: StringConstant.enterLocation,
          ),
          10.kheightBox,
          Row(
            children: [
              Text(
                StringConstant.postCode, style: TextStyleUtil.manrope14w500(),),
              Text(
                "*",
                style: TextStyleUtil.manrope14w500(color: context.primary01),
              )
            ],
          ),
          6.kheightBox,
          CustomTextField(
            keyboardType: TextInputType.number,
            validator: (String? val) {
              if(val == null || val.isEmpty){
                return "Post code cannot be empty!";
              }
              return null;
            },
            fillColor: context.loginSignupTextfieldColor,
            border: Border.all(color: context.black07),
            controller: controller.postCodeController,
            hintText: StringConstant.enterLocation,
          ),
          40.kheightBox,
          CustomRedElevatedButton(
              buttonText: controller.stepCount.value < 2
                  ? StringConstant.next
                  : StringConstant.continuee,
              height: 56.kh,
              width: 100.w,
              onPressed: () {
                if(formKey.currentState!.validate()){
                  controller.stepCount.value < 2
                      ? controller.gotoNextStep()
                      : controller.gotoEnableLocationScreen();
                }
              }),
          30.kheightBox,
        ],
      ),
    );
  }
}
