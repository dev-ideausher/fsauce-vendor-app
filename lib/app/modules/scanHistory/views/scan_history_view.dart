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

import '../controllers/scan_history_controller.dart';

class ScanHistoryView extends GetView<ScanHistoryController> {
  const ScanHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: StringConstant.scanHistory,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.kw),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: context.black07),
                    borderRadius: BorderRadius.circular(8.kw)),
                child: const CustomTextField(
                    prefixIcon: Icons.search_rounded,
                    fillColor: Colors.white,
                    hintText: StringConstant.searchByDate),
              ),
              20.kheightBox,
              Container(
                width: 100.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.kw)),
                padding:
                    EdgeInsets.symmetric(horizontal: 8.kw, vertical: 16.kh),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 50.w - 24.kh,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                StringConstant.dateAndTime,
                                style: TextStyleUtil.manrope14w500(),
                              ),
                              Divider(
                                color: context.black05,
                              ),
                              5.kheightBox,
                              ...[1, 2, 3, 4].map((e) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "07 Apr 2024, 11:30",
                                        style: TextStyleUtil.manrope14w400(),
                                      ),
                                      Divider(
                                        color: context.black05,
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 50.w - 30.kw,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                StringConstant.typeOfRedemption,
                                style: TextStyleUtil.manrope14w500(),
                              ),
                              Divider(
                                color: context.black05,
                              ),
                              5.kheightBox,
                              ...[1, 2, 3, 4].map((e) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Loyalty Rewards",
                                        style: TextStyleUtil.manrope14w400(),
                                      ),
                                      Divider(
                                        color: context.black05,
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
