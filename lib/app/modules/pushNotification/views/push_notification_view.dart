import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/empty_widget.dart';
import 'package:fsauce_vendor_app/app/components/push_notification_card.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';

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
        appBar: const CustomAppBar(
          title: StringConstant.pushNotification,
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
          child: Obx(
            () => controller.isLoad.value
                ? const SizedBox()
                : controller.notificationList.isEmpty
                    ? Center(
                        child: EmptyWidget(
                        title: StringConstant.noNotificationsCreated,
                      ))
                    : Column(
                        children: [
                          20.kheightBox,
                          ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) {
                                return PushNotificationCard(
                                  isActivate: controller.notificationList[index]
                                              .sheduledDate ==
                                          null
                                      ? true
                                      : DateTime.parse(controller
                                              .notificationList[index]
                                              .sheduledDate!)
                                          .isAfter(DateTime.now()),
                                  notification:
                                      controller.notificationList[index],
                                );
                              },
                              separatorBuilder: (ctx, index) {
                                return 10.kheightBox;
                              },
                              itemCount: controller.notificationList.length)
                        ],
                      ).paddingSymmetric(horizontal: 16.kh),
          ),
        ));
  }
}
