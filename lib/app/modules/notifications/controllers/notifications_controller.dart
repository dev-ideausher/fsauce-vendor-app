import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

import '../../../models/notification_model.dart';

class NotificationsController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isMoreLoading = false.obs;
  int page = 1;
  final int limit = 10;
  bool hasMore = true;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getNotifications();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMore &&
          !isMoreLoading.value) {
        getMoreNotifications();
      }
    });
  }

  Future<void> getNotifications() async {
    isLoading.value = true;
    try {
      var response =
          await APIManager.getNotifications(page: page, limit: limit);
      if (response.data['status']) {
        List<dynamic> data = response.data['data']['result'];
        notifications.value =
            data.map((e) => NotificationModel.fromJson(e)).toList();
        if (data.length < limit) {
          hasMore = false;
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getMoreNotifications() async {
    isMoreLoading.value = true;
    page++;
    try {
      var response =
          await APIManager.getVendorNotifications(page: page, limit: limit);
      if (response.data['status']) {
        List<dynamic> data = response.data['data'];
        if (data.isEmpty) {
          hasMore = false;
        } else {
          notifications
              .addAll(data.map((e) => NotificationModel.fromJson(e)).toList());
          if (data.length < limit) {
            hasMore = false;
          }
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isMoreLoading.value = false;
    }
  }
}
