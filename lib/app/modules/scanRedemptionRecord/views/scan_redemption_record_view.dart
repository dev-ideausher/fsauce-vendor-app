import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/scan_redemption_record_controller.dart';

class ScanRedemptionRecordView extends GetView<ScanRedemptionRecordController> {
  const ScanRedemptionRecordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: StringConstant.scanRedemptionRecord,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.kw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                  prefixIcon: Icons.search_rounded,
                  suffixIcon: Icons.calendar_month,
                  fillColor: Colors.white,
                  suffixOnPressed: () {},
                  hintText: StringConstant.searchBydate),
              20.kheightBox,
              Text(
                StringConstant.viewScanningHistory,
                style: TextStyleUtil.manrope14w500(),
              ),
              10.kheightBox,
              ...[1, 2, 3, 5].map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: controller.gotoScanHistory,
                      child: Container(
                        height: 56.kh,
                        width: 100.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.kw),
                            border: Border(
                                bottom:
                                    BorderSide(color: context.borderColor1))),
                        padding: EdgeInsets.symmetric(horizontal: 16.kw),
                        child: Row(
                          children: [
                            CommonImageView(
                              svgPath: ImageConstant.scanRedump,
                            ),
                            10.kwidthBox,
                            Text("10-03-2024"),
                            Spacer(),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: context.primary01,
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
