import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/custom_app_bar.dart';
import '../../../components/custom_textfield.dart';
import '../../../constants/string_constant.dart';
import '../../../services/colors.dart';
import '../../../services/responsive_size.dart';
import '../controllers/location_search_controller.dart';

class LocationSearchView extends GetView<LocationSearchController> {
  const LocationSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: StringConstant.address,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.kw),
          child: Column(
            children: [
              SizedBox(height: 24.kh),
              SizedBox(
                height: 52.kh,
                width: 100.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.kw),
                  child: CustomTextField(
                    onChanged: (value) {
                      controller.getApiGoogle(value.toString());
                    },
                    maxLines: 1,

                    hintText: StringConstant.search,
                    fillColor: context.loginSignupTextfieldColor,
                  ),
                ),
              ),
              SizedBox(height: 24.kh),
              Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 10.kh),
                        itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            controller.getCityName(controller.addressName[index]);
                          },
                          title: Text(controller.addressName[index].description.toString()),
                        ),
                        itemCount: controller.addressName.length,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
