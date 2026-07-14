import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:get/get.dart';
import '../../../components/confirmation_dialog.dart';
import '../../../constants/string_constant.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../../../services/dialog_helper.dart';
import '../../../services/dio/api_service.dart';

class CreatePushNotificationController extends GetxController {
  RxBool isActive = false.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController scheduledDateController = TextEditingController();
  TextEditingController scheduledTimeController = TextEditingController();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    Get.find<HomeController>().getRestaurantDetails();

    // Listen for changes to enable Save button
    titleController.addListener(validateForm);
    scheduledDateController.addListener(validateForm);
    scheduledTimeController.addListener(validateForm);
  }

  @override
  void onClose() {
    titleController.dispose();
    scheduledDateController.dispose();
    scheduledTimeController.dispose();
    super.onClose();
  }

  void validateForm() {
    isActive.value = titleController.text.isNotEmpty &&
        titleController.text.length <= 25 &&
        scheduledDateController.text.isNotEmpty &&
        scheduledTimeController.text.isNotEmpty;
  }

  String _formatTimeOfDay(BuildContext context, TimeOfDay t) {
    final m = MediaQuery.of(context);
    return MaterialLocalizations.of(context).formatTimeOfDay(
      t,
      alwaysUse24HourFormat: m.alwaysUse24HourFormat,
    );
  }

  DateTime _combinedScheduled() {
    final d = selectedDate.value;
    return DateTime(
      d.year,
      d.month,
      d.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: context.primary01,
            colorScheme: ColorScheme.light(primary: context.primary01),
            dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
      scheduledDateController.text =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      if (scheduledTimeController.text.isEmpty) {
        _selectedTime = const TimeOfDay(hour: 9, minute: 0);
        if (!context.mounted) return;
        scheduledTimeController.text = _formatTimeOfDay(context, _selectedTime);
      }
      validateForm();
    }
  }

  Future<void> pickTime(BuildContext context) async {
    if (scheduledDateController.text.isEmpty) {
      DialogHelper.showError(StringConstant.scheduleDateRequired);
      return;
    }
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: context.primary01,
            colorScheme: ColorScheme.light(primary: context.primary01),
            dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _selectedTime = picked;
      if (!context.mounted) return;
      scheduledTimeController.text = _formatTimeOfDay(context, picked);
      validateForm();
    }
  }

  // Future<void> addNotification() async {
  //   final restaurantDetails =
  //       Get.find<HomeController>().restaurantDetails.value;

  //   if (restaurantDetails.subscriptionModel == null) {
  //     Get.dialog(ConfrimationDialog(
  //       title: StringConstant.subscriptionRequired,
  //       subTitle: StringConstant.subscriptionRequiredText,
  //       yesButtonText: StringConstant.checkoutSubscriptions,
  //       noButtonText: StringConstant.close,
  //       onYesTap: () => Get.offNamed(Routes.SUBSCRIPTION),
  //       onNoTap: Get.back,
  //     ));
  //     return;
  //   }

  //   if (!formKey.currentState!.validate()) return;

  //   try {
  //     var response = await APIManager.addPushNotification(data: {
  //       "title": titleController.text.trim(),
  //       "isSheduled":
  //           "sheduledDate": selectedDate.value.toIso8601String(),
  //     });

  //     if (response.data['status'] == true) {
  //       DialogHelper.showSuccess(StringConstant.notificationSentSuccessfully);

  //       // Reload the correct controller instance
  //       if (Get.isRegistered<NotificationsController>()) {
  //         final notificationsController = Get.find<NotificationsController>();
  //         notificationsController.page = 1;
  //         notificationsController.hasMore = true;
  //         await notificationsController.getNotifications(); // wait for reload
  //         notificationsController.notifications
  //             .refresh(); // optional force refresh
  //       }

  //       Get.back(); // go back after reload

  //       Get.back(); // go back after reload
  //     } else {
  //       DialogHelper.showError(
  //           response.data['message'] ?? StringConstant.somethingWentWrong);
  //     }
  //   } catch (e) {
  //     if (e is DioException) {
  //       DialogHelper.showError(
  //           e.response?.data['message'] ?? StringConstant.somethingWentWrong);
  //     }
  //   }
  // }
  Future<void> addNotification() async {
    final restaurantDetails =
        Get.find<HomeController>().restaurantDetails.value;

    if (restaurantDetails.subscriptionModel == null) {
      Get.dialog(
        ConfrimationDialog(
          title: StringConstant.subscriptionRequired,
          subTitle: StringConstant.subscriptionRequiredText,
          yesButtonText: StringConstant.checkoutSubscriptions,
          noButtonText: StringConstant.close,
          onYesTap: () => Get.offNamed(Routes.SUBSCRIPTION),
          onNoTap: Get.back,
        ),
      );
      return;
    }

    if (!formKey.currentState!.validate()) return;

    try {
      final DateTime scheduled = _combinedScheduled();
      if (!scheduled.isAfter(DateTime.now())) {
        DialogHelper.showError(StringConstant.scheduleMustBeInFuture);
        return;
      }

      final bool isScheduled = scheduled.isAfter(DateTime.now());
      var response = await APIManager.addPushNotification(
        data: {
          "title": titleController.text.trim(),
          "isSheduled": isScheduled,
          "sheduledDate": scheduled.toUtc().toIso8601String(),
        },
      );

      if (response.data['status'] == true) {
        DialogHelper.showSuccess(
          StringConstant.notificationSentSuccessfully,
        );

        if (Get.isRegistered<NotificationsController>()) {
          final notificationsController = Get.find<NotificationsController>();
          notificationsController.page = 1;
          notificationsController.hasMore = true;
          await notificationsController.getNotifications();
          notificationsController.notifications.refresh();
        }
        Get.back();
        Get.back();
      } else {
        DialogHelper.showError(
          response.data['message'] ?? StringConstant.somethingWentWrong,
        );
      }
    } catch (e) {
      if (e is DioException) {
        DialogHelper.showError(
          e.response?.data['message'] ?? StringConstant.somethingWentWrong,
        );
      }
    }
  }

  String? titleValidator(String? val) {
    if (val == null || val.isEmpty) {
      return StringConstant.notificationTitleEmpty;
    }
    if (val.length > 25) {
      return StringConstant.max25CharsAllowed;
    }
    return null;
  }

  String? scheduledDateValidator(String? val) {
    if (val == null || val.isEmpty) return StringConstant.scheduleDateRequired;
    return null;
  }

  String? scheduledTimeValidator(String? val) {
    if (val == null || val.isEmpty) {
      return StringConstant.scheduleTimeRequired;
    }
    return null;
  }
}
