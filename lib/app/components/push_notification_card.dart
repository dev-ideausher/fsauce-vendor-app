import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/push_notification_model.dart';
import 'package:fsauce_vendor_app/app/modules/pushNotification/controllers/push_notification_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/fsv_util.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class PushNotificationCard extends StatelessWidget {
  PushNotification notification;
  PushNotificationCard(
      {super.key, required this.isActivate, required this.notification});
  final bool isActivate;

  @override
  Widget build(BuildContext context) {
    String date = notification.sheduledDate ?? "";
    return Container(
      height: date.isNotEmpty ? 166.kh : 120.kh,
      width: 100.w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          date.isNotEmpty
              ? Container(
                  height: 37.kh,
                  decoration: BoxDecoration(
                    color: context.primary07,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                  ),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.check),
                        4.kwidthBox,
                        Text(
                          StringConstant.scheduledFor,
                          style: TextStyleUtil.manrope14w400(),
                        ),
                        Text(
                          date.isNotEmpty ? date.substring(0, 10) : date,
                          style: TextStyleUtil.manrope14w400(),
                        ),
                      ],
                    ),
                  ))
              : Container(),
          Container(
            margin: EdgeInsets.only(bottom: 10.kh),
            padding: const EdgeInsets.only(left: 12, right: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title!,
                        style: TextStyleUtil.manrope14w500(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.kh),
                      child: PopupMenuButton<int>(
                        color: Colors.white,
                        onSelected: (item) => handleClick(item),
                        itemBuilder: (context) => [
                          PopupMenuItem<int>(
                              onTap: notification.sheduledDate != null
                                  ? isActivate
                                      ? Get.find<PushNotificationController>()
                                          .showInactiveDialog
                                      : Get.find<PushNotificationController>()
                                          .showActiveDialog
                                  : () {},
                              value: 1,
                              child: Text(
                                notification.sheduledDate != null
                                    ? isActivate
                                        ? StringConstant.inactivateNotification
                                        : StringConstant.activateNotification
                                    : "",
                                style: TextStyleUtil.manrope14w400(),
                              )),
                          PopupMenuItem<int>(
                              onTap: Get.find<PushNotificationController>()
                                  .showDeleteDialog,
                              value: 1,
                              child: Text(
                                StringConstant.deleteNotification,
                                style: TextStyleUtil.manrope14w400(
                                  color: context.primary01,
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  // "Feb 27, 2022, 23:57",
                  date.isNotEmpty
                      ? FSVutil.formatDate(DateTime.parse(date))
                      : date,
                  style: TextStyleUtil.manrope14w400(
                    color: context.black03,
                  ),
                ),
                notification.sheduledDate != null ? 8.kheightBox : Container(),
                Container(
                  height: 26,
                  width: 80.kw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color:
                              isActivate ? context.green : context.primary02)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 7,
                        width: 7,
                        decoration: BoxDecoration(
                            color:
                                isActivate ? context.green : context.primary01,
                            shape: BoxShape.circle),
                      ),
                      5.kwidthBox,
                      Text(
                        isActivate
                            ? StringConstant.active
                            : StringConstant.inactive,
                        style: TextStyleUtil.manrope12w500(
                            color:
                                isActivate ? context.green : context.primary01),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  handleClick(int item) {}
}
