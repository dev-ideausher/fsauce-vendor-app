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
import 'package:url_launcher/url_launcher.dart';

bool _isRemoteImageUrl(String url) {
  final path = Uri.tryParse(url)?.path.toLowerCase() ?? url.toLowerCase();
  return path.endsWith('.jpg') ||
      path.endsWith('.jpeg') ||
      path.endsWith('.png') ||
      path.endsWith('.gif') ||
      path.endsWith('.webp');
}

bool _isRemoteVideoUrl(String url) {
  final path = Uri.tryParse(url)?.path.toLowerCase() ?? url.toLowerCase();
  return path.endsWith('.mp4') ||
      path.endsWith('.mov') ||
      path.endsWith('.webm') ||
      path.endsWith('.m4v');
}

class AllPhotosAndVideosView extends GetView<AllPhotosAndVideosController> {
  const AllPhotosAndVideosView({super.key});

  static double _thumbSize() => 118.kw;

  @override
  Widget build(BuildContext context) {
    final thumb = _thumbSize();

    Widget remoteTile(String uploadUrl, int index) {
      if (_isRemoteImageUrl(uploadUrl)) {
        return InkWell(
          onLongPress: () => controller.confirmDeleteImage(index),
          borderRadius: BorderRadius.circular(8.kw),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.kw),
            child: SizedBox(
              width: thumb,
              height: thumb,
              child: CommonImageView(
                url: uploadUrl,
                width: thumb,
                height: thumb,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }
      if (_isRemoteVideoUrl(uploadUrl)) {
        return InkWell(
          onTap: () => launchUrl(Uri.parse(uploadUrl)),
          borderRadius: BorderRadius.circular(8.kw),
          child: Container(
            width: thumb,
            height: thumb,
            decoration: BoxDecoration(
              color: context.loginSignupTextfieldColor,
              border: Border.all(color: context.black07),
              borderRadius: BorderRadius.circular(8.kw),
            ),
            child: Icon(Icons.videocam, color: context.black03, size: 36.kw),
          ),
        );
      }
      return InkWell(
        onLongPress: () => controller.confirmDeleteImage(index),
        borderRadius: BorderRadius.circular(8.kw),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.kw),
          child: SizedBox(
            width: thumb,
            height: thumb,
            child: CommonImageView(
              url: uploadUrl,
              width: thumb,
              height: thumb,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(
        title: StringConstant.allPhotosAndVideos,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.kw, 16.kh, 16.kw, 8.kh),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        StringConstant.restaurantImageAndVideos,
                        style: TextStyleUtil.manrope14w500(),
                      ),
                      Text(
                        "*",
                        style: TextStyleUtil.manrope14w500(
                            color: context.primary01),
                      ),
                    ],
                  ),
                  8.kheightBox,
                  Obx(() {
                    if (controller.restaurantUploads.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: thumb + 2.kh,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.restaurantUploads.length,
                            separatorBuilder: (_, __) => 12.kwidthBox,
                            itemBuilder: (ctx, index) {
                              return remoteTile(
                                controller.restaurantUploads[index],
                                index,
                              );
                            },
                          ),
                        ),
                        16.kheightBox,
                      ],
                    );
                  }),
                  Obx(() {
                    if (controller.selectedFiles.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: thumb + 2.kh,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.selectedFiles.length,
                            separatorBuilder: (_, __) => 12.kwidthBox,
                            itemBuilder: (ctx, index) {
                              final path = controller.selectedFiles[index];
                              if (controller.isImage(path)) {
                                return Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(8.kw),
                                      child: SizedBox(
                                        width: thumb,
                                        height: thumb,
                                        child: Image.file(
                                          File(path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: -6,
                                      right: -6,
                                      child: Material(
                                        color: context.white,
                                        shape: const CircleBorder(),
                                        elevation: 1,
                                        child: InkWell(
                                          customBorder: const CircleBorder(),
                                          onTap: () => controller.selectedFiles
                                              .removeAt(index),
                                          child: Icon(
                                            Icons.close_rounded,
                                            size: 20.kw,
                                            color: context.black02,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: thumb,
                                    height: thumb,
                                    decoration: BoxDecoration(
                                      color: context.loginSignupTextfieldColor,
                                      border:
                                          Border.all(color: context.black07),
                                      borderRadius:
                                          BorderRadius.circular(8.kw),
                                    ),
                                    child: Icon(
                                      Icons.videocam,
                                      color: context.black03,
                                      size: 36.kw,
                                    ),
                                  ),
                                  Positioned(
                                    top: -6,
                                    right: -6,
                                    child: Material(
                                      color: context.white,
                                      shape: const CircleBorder(),
                                      elevation: 1,
                                      child: InkWell(
                                        customBorder: const CircleBorder(),
                                        onTap: () => controller.selectedFiles
                                            .removeAt(index),
                                        child: Icon(
                                          Icons.close_rounded,
                                          size: 20.kw,
                                          color: context.black02,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        16.kheightBox,
                      ],
                    );
                  }),
                  InkWell(
                    borderRadius: BorderRadius.circular(8.kw),
                    onTap: controller.pickMultipleFiles,
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(minHeight: 152.kh),
                      padding: EdgeInsets.symmetric(
                        vertical: 24.kh,
                        horizontal: 16.kw,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: context.black07),
                        borderRadius: BorderRadius.circular(8.kw),
                        color: context.loginSignupTextfieldColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.file_upload_outlined,
                            color: context.black03,
                            size: 22.kw,
                          ),
                          8.kwidthBox,
                          Flexible(
                            child: Text(
                              StringConstant.uploadPhotosAndVideos,
                              textAlign: TextAlign.center,
                              style: TextStyleUtil.manrope14w400(
                                color: context.black03,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.white,
              border: Border(
                top: BorderSide(color: context.borderColor1, width: 1),
              ),
            ),
            child: SafeArea(
              top: false,
              minimum: EdgeInsets.fromLTRB(16.kw, 12.kh, 16.kw, 16.kh),
              child: CustomRedElevatedButton(
                buttonText: StringConstant.save,
                height: 56.kh,
                width: double.infinity,
                onPressed: controller.uploadAllImagesAndVideos,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
