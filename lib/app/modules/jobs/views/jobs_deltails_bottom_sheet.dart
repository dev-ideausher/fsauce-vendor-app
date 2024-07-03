import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/job_model.dart';
import 'package:fsauce_vendor_app/app/modules/jobs/controllers/jobs_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class JobsDetailsBottomSheet extends GetView<JobsController> {
  final Job job;
  const JobsDetailsBottomSheet({required this.job, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 100.w,
        padding: EdgeInsets.all(16.kw),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.kw),
                topRight: Radius.circular(24.kw))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5.kh,
                  width: 64.kw,
                  decoration: BoxDecoration(
                      color: context.black01,
                      borderRadius: BorderRadius.circular(3)),
                ),
              ],
            ),
            20.kheightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringConstant.jobDetails,
                  style: TextStyleUtil.manrope18w600(),
                ),
              ],
            ),
            16.kheightBox,
            Text(
              job.title ?? "Sou Chef",
              style: TextStyleUtil.manrope16w600(),
            ),
            10.kheightBox,
            Row(
              children: [
                CommonImageView(
                  svgPath: ImageConstant.jobTicket,
                ),
                8.kwidthBox,
                Text(
                  "\$ ${job.minSalary} - \$ ${job.maxSalary}" ?? "£26T–50Tper year",
                  style: TextStyleUtil.manrope16w400(color: context.black03),
                ),
              ],
            ),
            8.kheightBox,
            Row(
              children: [
                CommonImageView(
                  svgPath: ImageConstant.timerIcon,
                ),
                8.kwidthBox,
                Text(
                  StringConstant.applyBy + job.lastDate.toString().substring(0,10),
                  style: TextStyleUtil.manrope16w400(color: context.black03),
                ),
              ],
            ),
            Divider(
              color: context.black07,
              height: 30,
              thickness: 1.5,
            ),
            Text(
              StringConstant.description,
              style: TextStyleUtil.manrope16w600(),
            ),
            6.kheightBox,
            Text(
              job.description ?? "Join our team as a Sous Chef and showcase your culinary skills in a dynamic environment. Assist in menu creation, daily kitchen operations, and staff supervision. The ideal candidate should have a minimum of 3 years of culinary experience and be passionate about delivering high-quality cuisine.",
              style: TextStyleUtil.manrope14w400(color: context.black03),
            ),
            16.kheightBox,
            Text(
              StringConstant.howTOApply,
              style: TextStyleUtil.manrope16w600(),
            ),
            6.kheightBox,
            Text(
              job.howToApply ?? "Interested candidates should submit their resume and cover letter to careers@bistrocentral.com with the subject line Sous Chef Application.",
              style: TextStyleUtil.manrope14w400(color: context.black03),
            )
          ],
        ),
      ),
    );
  }
}
