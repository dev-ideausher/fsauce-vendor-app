import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/all_photos_and_videos_controller.dart';

class AllPhotosAndVideosView extends GetView<AllPhotosAndVideosController> {
  const AllPhotosAndVideosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: StringConstant.allPhotosAndVideos,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.kw),
        child: ListView(
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
            12.kheightBox,
            Obx((){
              if(controller.restaurantUploads.isNotEmpty){
                return SizedBox(
                  height: 250.kh,
                  width: double.infinity,
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index){
                        return InkWell(
                          onLongPress: () {
                            controller.confirmDeleteImage(index);
                          },
                          child: CommonImageView(
                            url: controller.restaurantUploads[index],
                          ),
                        );
                      },
                      separatorBuilder: (ctx, index){
                        return 8.kheightBox;
                      }, itemCount: controller.restaurantUploads.length),
                );
              }
              else{
                return Container();
              }
            }),
            12.kheightBox,
            Obx((){
              if(controller.selectedFiles.isNotEmpty){
                return SizedBox(
                  height: 250.kh,
                  width: double.infinity,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index){
                        return Image.file(
                            File(controller.selectedFiles[index]),
                          fit: BoxFit.contain,
                        );
                      },
                      separatorBuilder: (ctx, index){
                        return 8.kheightBox;
                      }, itemCount: controller.selectedFiles.length),
                );
              }
              else{
                return Container();
              }
            }),
            12.kheightBox,
            InkWell(
              onTap: () {
                controller.pickMultipleFiles();
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
                        StringConstant.uploadPhotosAndVideos,
                        style:
                            TextStyleUtil.manrope14w400(color: context.black03),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            CustomRedElevatedButton(
                buttonText: StringConstant.save,
                height: 56.kh,
                width: 100.w,
                onPressed: () {
                  controller.uploadAllImagesAndVideos();
                }),
            10.kheightBox,
          ],
        ),
      ),
    );
  }
}
