import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';
import 'package:fsauce_vendor_app/app/modules/profileSetup/controllers/profile_setup_controller.dart';

import '../../../components/common_image_view.dart';
import '../../../components/custom_red_elevated_button.dart';
import '../../../services/dialog_helper.dart';

class StepThree extends GetView<ProfileSetupController> {
  const StepThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              StringConstant.restaurantImageAndVideos,
              style: TextStyleUtil.manrope14w500(),
            ),
            Text(
              "*",
              style: TextStyleUtil.manrope14w500(color: context.primary01),
            )
          ],
        ),
        6.kheightBox,
        Obx(() {
          if (controller.selectedFiles.isEmpty) {
            return Container();
          } else if (controller.selectedFiles.isNotEmpty) {
            return SizedBox(
              height: 250.kh,
              width: 600.kw,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    if (controller.isImage(controller.selectedFiles[index])) {
                      return Stack(
                        children: [
                          Image.file(
                          File(controller.selectedFiles[index]),
                          fit: BoxFit.contain,),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                  onPressed: (){
                                    controller.selectedFiles.removeAt(index);
                                  }, icon: const Icon(Icons.cancel_outlined, size: 20,))),
                        ]
                      );
                    } else {
                      return Stack(
                        children: [
                          Container(
                            height: 400.kh,
                            width: 120.kw,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(4.kh),
                            ),
                            child: const Center(child: Icon(Icons.videocam))),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                  onPressed: (){
                                    controller.selectedFiles.removeAt(index);
                                  }, icon: const Icon(Icons.cancel_outlined, size: 20,))),
                        ]
                      );
                    }
                  },
                  separatorBuilder: (ctx, index) {
                    return 20.kwidthBox;
                  },
                  itemCount: controller.selectedFiles.length),
            );
          } else {
            return Container();
          }
        }),
        Obx(() =>
            GestureDetector(
              onTap: () async {
                await controller.pickMultipleFiles();
              },
              child: Container(
                height: 160.kh,
                width: 100.w,
                decoration: BoxDecoration(
                    border: Border.all(color: context.black07),
                    borderRadius: BorderRadius.circular(8.kw),
                    color: context.loginSignupTextfieldColor),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.file_upload_outlined),
                      2.kwidthBox,
                      Text(
                        controller.selectedFiles.isEmpty
                            ? StringConstant.uploadPhotosAndVideos
                            : '${controller.selectedFiles
                            .length} files selected',
                        style:
                        TextStyleUtil.manrope14w400(color: context.black03),
                      )
                    ],
                  ),
                ),
              ),
            )),
        Obx(() {
          if(controller.selectedFiles.isEmpty){
            return SizedBox(
              height: 24.h,
            );
          } else{
            return 0.kheightBox;
          }
        }),
        Obx(() {
          if (controller.selectedFiles.isEmpty) {
            return 40.kheightBox;
          } else if (controller.selectedFiles.isNotEmpty) {
            return 10.kheightBox;
          } else {
            return 40.kheightBox;
          }
        }),
        CustomRedElevatedButton(
            buttonText: controller.stepCount.value < 2
                ? StringConstant.next
                : StringConstant.continuee,
            height: 56.kh,
            width: 100.w,
            onPressed: () {
              if (controller.selectedFiles.isNotEmpty) {
                controller.stepCount.value < 2
                    ? controller.gotoNextStep
                    : controller.gotoEnableLocationScreen();
              } else {
                Get.snackbar("Error", StringConstant.noFilesSelected);
              }
            }),
        30.kheightBox,
      ],
    );
  }
}
