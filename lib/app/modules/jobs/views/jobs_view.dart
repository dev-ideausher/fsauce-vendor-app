import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/jobs_controller.dart';

class JobsView extends GetView<JobsController> {
  const JobsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: StringConstant.jobs,
      ),
      floatingActionButton: Container(
        height: 41.kh,
        width: 41.kw,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: context.primary01),
        child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 30.kw,
            ),
            onPressed: controller.gotoAddJobPage),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.kh, left: 16.kw, right: 16.kw),
        child: Column(
            children: [1, 2, 3, 4]
                .map((e) => Container(
                      height: 128.kh,
                      width: 100.w,
                      padding: EdgeInsets.symmetric(
                        vertical: 16.kh,
                        horizontal: 14.kw,
                      ),
                      margin: EdgeInsets.only(bottom: 16.kh),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.kw),
                          border: Border(
                              bottom: BorderSide(
                            color: context.black07,
                          ))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sous Chef",
                                style: TextStyleUtil.manrope16w600(),
                              ),
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: controller.gotoEditJobPage,
                                  icon: CommonImageView(
                                    svgPath: ImageConstant.editPen,
                                    height: 20,
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              CommonImageView(
                                svgPath: ImageConstant.jobTicket,
                              ),
                              8.kwidthBox,
                              Text(
                                "£26T–50Tper year",
                                style: TextStyleUtil.manrope16w400(),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: controller.showJobsBottomSheet,
                                child: Row(
                                  children: [
                                    Text(
                                      StringConstant.viewDetails,
                                      style: TextStyleUtil.manrope14w400(),
                                    ),
                                    const Icon(
                                        Icons.keyboard_arrow_down_outlined)
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ))
                .toList()),
      ),
    );
  }
}
