import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/notification_card.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';
import '../../../../generated/assets.dart';
import '../../../components/common_image_view.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: StringConstant.notifications,
        ),
        body: Obx(() {
          if(controller.notifications.isNotEmpty){
            return Container(
              height: 100.h,
              width: 100.w,
              margin: EdgeInsets.only(left: 16.kw, right: 16.kw),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 20,
                  itemBuilder: (context, index) =>
                  const NotificationCard(
                    subTitle:
                    "New offer available! Get 30% off your next meal at Pizza Paradise.",
                    timeAgo: "1h AGo",
                    title: "Summer special offer",
                  )),
            );
          } else{
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CommonImageView(
                    svgPath: Assets.svgsEmptyNotification
                  ),
                  10.kheightBox,
                  Text(StringConstant.noNotificationFound, style: TextStyleUtil.manrope24w600()),
                  6.kheightBox,
                  Text(StringConstant.pleaseTryAgain, style: TextStyleUtil.manrope16w400(color: context.black04)),
                ],
              ),
            );
          }
        }));
  }
}
