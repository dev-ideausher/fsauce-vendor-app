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
                    style: TextStyleUtil.manrope14w500(color: context.primary01),
                  )
                ],
              ),
              8.kheightBox,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: context.loginSignupTextfieldColor,
                    borderRadius: BorderRadius.circular(8.kw),
                    border: Border.all(color: context.black07)),
                child: MultiSelectDialogField(
                  initialValue: controller.selectedFeatures,
                  items: controller.featureItems,
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
                    style: TextStyleUtil.manrope14w400(color: context.black04),
                  ),
                  onConfirm: (results) {
                    controller.selectedFeatures = results;
                    print(results);
                  },
                ),
                // DropdownButtonFormField<String>(
                //   style: TextStyleUtil.manrope16w400(),
                //   onChanged: (val) {},
                //   items: <String>[
                //     StringConstant.male,
                //     StringConstant.female,
                //     StringConstant.others
                //   ].map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //   icon: const Icon(Icons.keyboard_arrow_down_rounded),
                //   decoration: InputDecoration(
                //     contentPadding: const EdgeInsets.all(0),
                //     hintText: StringConstant.enterFeatures,
                //     hintStyle:
                //         TextStyleUtil.manrope14w400(color: context.black04),
                //     border: const OutlineInputBorder(
                //       borderSide: BorderSide.none,
                //     ),
                //   ),
                // ),
              ),
              10.kheightBox,
              Row(
                children: [
                  Text(
                    StringConstant.timings,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Text(
                    "*",
                    style: TextStyleUtil.manrope14w500(color: context.primary01),
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
              ].map((e) => FilterAnimatedOption(
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
