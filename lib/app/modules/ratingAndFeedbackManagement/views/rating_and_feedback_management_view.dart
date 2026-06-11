import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/empty_rating_screen.dart';
import 'package:fsauce_vendor_app/app/components/rating_indicator.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/ratingAndFeedbackManagement/views/review_filter_bottom_sheet.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/rating_and_feedback_management_controller.dart';

class RatingAndFeedbackManagementView
    extends GetView<RatingAndFeedbackManagementController> {
  const RatingAndFeedbackManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: StringConstant.ratingAndFeedbackManagement,
        ),
        body: Obx(() {
          if (controller.ratings.isNotEmpty) {
            final starShares = controller.starDistributionShares();
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.kw),
              child: Column(
                children: [
                  Container(
                    height: 120.kh,
                    width: 100.w,
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.kw, vertical: 16.kh),
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
                              controller.averageRating.value
                                  .toStringAsFixed(1),
                              style: TextStyleUtil.manrope24w500(),
                            ),
                            RatingIndicator(
                              rating: controller.averageRatingStarRow(),
                            ),
                            Text(
                              '( ${NumberFormat('#,###').format(controller.totalRatingCount.value)} )',
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
                              for (int i = 0; i < 5; i++) ...[
                                LinearProgressIndicator(
                                  color: context.golden,
                                  borderRadius: BorderRadius.circular(4.kh),
                                  minHeight: 4.kh,
                                  value: starShares[i].clamp(0.0, 1.0),
                                ),
                                if (i != 4) 10.kheightBox,
                              ],
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
                              final review =
                                  controller.displayedRatings[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 20.kh),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          review.user?.name ?? "",
                                          style: TextStyleUtil.manrope14w600(),
                                        ),
                                        2.kheightBox,
                                        Text(
                                          review.review ?? "",
                                          style: TextStyleUtil.manrope14w400(),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(top: 4.kh),
                                      child: PopupMenuButton<int>(
                                        color: Colors.white,
                                        itemBuilder: (context) => [
                                          PopupMenuItem<int>(
                                              onTap: () {
                                                controller
                                                    .showRatingDeleteDialog(
                                                        review.Id!);
                                              },
                                              value: 1,
                                              child: Text(
                                                StringConstant.deleteReview,
                                                style:
                                                    TextStyleUtil.manrope14w400(
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
                            itemCount: controller.displayedRatings.length),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: EmptyRatingScreen(),
          );
        }));
  }
}
