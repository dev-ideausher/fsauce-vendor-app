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
  const ScanRedemptionRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: StringConstant.scanRedemptionRecord,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.kw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
                controller: controller.dateController,
                readOnly: true,
                onTap: () {
                  controller.pickDate(context);
                },
                prefixIcon: Icons.search_rounded,
                suffixIcon: Icons.calendar_month,
                fillColor: Colors.white,
                suffixOnPressed: () {
                  controller.pickDate(context);
                },
                hintText: StringConstant.searchBydate),
            20.kheightBox,
            Text(
              StringConstant.viewScanningHistory,
              style: TextStyleUtil.manrope14w500(),
            ),
            10.kheightBox,
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.scanHistory.isEmpty) {
                  return Center(
                    child: Text(
                      "No records found",
                      style: TextStyleUtil.manrope14w500(),
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: controller.scanHistory.length,
                  separatorBuilder: (context, index) => 10.kheightBox,
                  itemBuilder: (context, index) {
                    var item = controller.scanHistory[index];

                    return InkWell(
                      onTap: () => controller.gotoScanHistory(date: item.date??""),
                      child: Container(
                        // height: 80.kh, // Increased height for stats
                        width: 100.w,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.kw), border: Border(bottom: BorderSide(color: context.borderColor1))),
                        padding: EdgeInsets.symmetric(horizontal: 16.kw, vertical: 12.kh),
                        child: Row(
                          children: [
                            CommonImageView(
                              svgPath: ImageConstant.scanRedump,
                            ),
                            10.kwidthBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.date ?? "",
                                    style: TextStyleUtil.manrope14w600(),
                                  ),
                                  4.kheightBox,
                                  Text(
                                    "Scans: ${item.totalScans ?? 0} | Reward: ${item.rewardRedeems ?? 0} | Stamp: ${item.stampRedeems ?? 0}",
                                    style: TextStyleUtil.manrope12w400(color: context.black03),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: context.primary01,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
