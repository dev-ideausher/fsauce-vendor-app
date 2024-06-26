import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/components/push_notification_card.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/push_notification_controller.dart';

class PushNotificationView extends GetView<PushNotificationController> {
  const PushNotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void handleClick(int item) {
      switch (item) {
        case 0:
          break;
      }
    }

    return Scaffold(
        appBar: CustomAppBar(
          title: StringConstant.pushNotifications,
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
              onPressed: controller.createPushNotification),
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
                    hintText: StringConstant.searchNotifications),
              ),
              20.kheightBox,
              const PushNotificationCard(
                isActivate: true,
              ),
              const PushNotificationCard(
                isActivate: false,
              ),
              const PushNotificationCard(
                isActivate: false,
              ),
            ],
          ),
        ));
  }
}
