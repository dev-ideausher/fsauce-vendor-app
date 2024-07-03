import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/empty_widget.dart';
import 'package:fsauce_vendor_app/app/components/rating_indicator.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/ratingAndFeedbackManagement/views/review_filter_bottom_sheet.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/rating_and_feedback_management_controller.dart';

class RatingAndFeedbackManagementView
    extends GetView<RatingAndFeedbackManagementController> {
  const RatingAndFeedbackManagementView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: StringConstant.ratingAndFeedbackManagement,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.kw),
          child: Obx(() {
            if(controller.ratings.isNotEmpty){
              return Column(
                children: [
                  Container(
                    height: 120.kh,
                    width: 100.w,
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.kw, vertical: 16.kh),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.kw),
                        border: Border(
                            bottom: BorderSide(color: context.borderColor1))),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "4.0",
                              style: TextStyleUtil.manrope24w500(),
                            ),
                            const RatingIndicator(rating: 4),
                            Text(
                              "( 4,100 )",
                              style: TextStyleUtil.manrope14w400(),
                            )
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 40.w,
                          child: Column(
                            children: [
                              20.kheightBox,
                              LinearProgressIndicator(
                                color: context.golden,
                                borderRadius: BorderRadius.circular(4.kh),
                                minHeight: 4.kh,
                                value: 0.9,
                              ),
                              10.kheightBox,
                              LinearProgressIndicator(
                                color: context.golden,
                                borderRadius: BorderRadius.circular(4.kh),
                                minHeight: 4.kh,
                                value: 0.7,
                              ),
                              10.kheightBox,
                              LinearProgressIndicator(
                                color: context.golden,
                                borderRadius: BorderRadius.circular(4.kh),
                                minHeight: 4.kh,
                                value: 0.4,
                              ),
                              10.kheightBox,
                              LinearProgressIndicator(
                                color: context.golden,
                                borderRadius: BorderRadius.circular(4.kh),
                                minHeight: 4.kh,
                                value: 0.3,
                              ),
                              10.kheightBox,
                              LinearProgressIndicator(
                                color: context.golden,
                                borderRadius: BorderRadius.circular(4.kh),
                                minHeight: 4.kh,
                                value: 0.1,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  20.kheightBox,
                  Container(
                    width: 100.w,
                    padding: EdgeInsets.all(8.kw),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StringConstant.reviews,
                              style: TextStyleUtil.manrope16w600(),
                            ),
                            InkWell(
                              onTap: () {
                                Get.bottomSheet(ReviewFilterBottomSheet());
                              },
                              child: Container(
                                height: 37.kh,
                                width: 100.kw,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: context.black07)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      StringConstant.filters,
                                      style: TextStyleUtil.manrope14w400(
                                          color: context.black02),
                                    ),
                                    8.kwidthBox,
                                    const Icon(Icons.filter_list_sharp)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        10.kheightBox,
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 20.kh),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          controller.ratings[index].user!.name ??
                                              "",
                                          style: TextStyleUtil.manrope14w600(),
                                        ),
                                        2.kheightBox,
                                        Text(
                                          controller.ratings[index].review! ?? "",
                                          style: TextStyleUtil.manrope14w400(),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(top: 4.kh),
                                      child: PopupMenuButton<int>(
                                        color: Colors.white,
                                        itemBuilder: (context) =>
                                        [
                                          PopupMenuItem<int>(
                                              onTap: () {
                                                controller.showRatingDeleteDialog(
                                                    controller.ratings[index]
                                                        .Id!);
                                              },
                                              value: 1,
                                              child: Text(
                                                StringConstant.deleteReview,
                                                style: TextStyleUtil
                                                    .manrope14w400(
                                                  color: context.primary01,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return 12.kheightBox;
                            },
                            itemCount: controller.ratings.length
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else if(controller.ratings.isEmpty){
              return Center(
                child: EmptyWidget(
                  title: StringConstant.noRatingsFound,
                ),
              );
            } else{
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ));
  }
}
