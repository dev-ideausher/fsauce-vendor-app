import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/filer_animated_options.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../models/feature_model.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/features_and_timings_controller.dart';

class FeaturesAndTimingsView extends GetView<FeaturesAndTimingsController> {
  const FeaturesAndTimingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: StringConstant.featuresTimings,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.kw),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    StringConstant.features,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Text(
                    "*",
                    style:
                    TextStyleUtil.manrope14w500(color: context.primary01),
                  )
                ],
              ),
              8.kheightBox,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.kh),
                decoration: BoxDecoration(
                    color: context.loginSignupTextfieldColor,
                    borderRadius: BorderRadius.circular(8.kw),
                    border: Border.all(color: context.black07)),
                child: MultiSelectDialogField<FeatureModel>(
                  validator: (List<FeatureModel>? features) {
                    if (features == null || features.isEmpty) {
                      return StringConstant.emptyFeatures;
                    }
                    return null;
                  },
                  initialValue: controller.selectedFeatures,
                  items: controller.multiSelectFeatures,
                  title: Text(
                    StringConstant.enterFeatures,
                    style: TextStyleUtil.manrope16w400(),
                  ),
                  selectedColor: context.primary01,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.kw),
                    border: Border.all(color: Colors.transparent),
                  ),
                  buttonIcon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.black,
                  ),
                  buttonText: Text(
                    StringConstant.enterFeatures,
                    style:
                    TextStyleUtil.manrope14w400(color: context.black04),
                  ),
                  onConfirm: (results) {
                    controller.selectedFeatures.value = [];
                    controller.selectedFeatures.value = results;
                    controller.isFeatureSelected.value = true;
                  },
                ),
              ),
              10.kheightBox,
              Obx((){
                return !controller.isFeatureSelected.value ?
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    StringConstant.selectedFeatures,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                ) : const Text("");
              }),
              10.kheightBox,
              Obx(() {
                if(controller.isFeatureSelected.value){
                  return Container();
                }
                return SizedBox(
                  height: 50.kh, width: double.infinity,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return Chip(
                        label: Text(controller.selectedFeatures[index].name!),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return 6.kwidthBox;
                    },
                    itemCount: controller.selectedFeatures.length,
                  ),
                );
              }),
              10.kheightBox,
              Row(
                children: [
                  Text(
                    StringConstant.timings,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Text(
                    "*",
                    style:
                    TextStyleUtil.manrope14w500(color: context.primary01),
                  )
                ],
              ),
              8.kheightBox,
              ...[
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday",
                "Sunday"
              ].map((e) =>
                  FilterAnimatedOption(
                    title: e,
                    controller: controller.timingControllers[e]!,
                  )),
              8.kheightBox,
              CustomRedElevatedButton(
                  buttonText: StringConstant.save,
                  height: 56.kh,
                  width: 100.w,
                  onPressed: () {
                    //ToDo: Implement save filters option.
                    controller.updateFeaturesAndTimings();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
