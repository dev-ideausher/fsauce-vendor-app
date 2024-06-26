import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';
import 'package:fsauce_vendor_app/app/modules/profileSetup/controllers/profile_setup_controller.dart';

class StepThree extends StatelessWidget {
  const StepThree({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileSetupController controller = Get.find();
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
        Obx(() => GestureDetector(
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
                            : '${controller.selectedFiles.length} files selected',
                        style:
                            TextStyleUtil.manrope14w400(color: context.black03),
                      )
                    ],
                  ),
                ),
              ),
            )),
        SizedBox(
          height: 24.h,
        )
      ],
    );
  }
}
