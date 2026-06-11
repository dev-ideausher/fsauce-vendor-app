import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fsauce_vendor_app/app/models/cuisine_model.dart';
import 'package:fsauce_vendor_app/app/models/dashboard_weekly_data_model.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/home/views/location_bottom_sheet.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

import '../../../constants/string_constant.dart';
import '../../../models/dashboard_monthly_data_model.dart';
import '../../../models/dashboard_yearly_data_model.dart';
import '../views/chart.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  Rx<DashboardWeeklyData> weeklyData = DashboardWeeklyData().obs;
  Rx<DashboardData> monthlyData = DashboardData().obs;
  Rx<DashboardYearlyData> yearlyData = DashboardYearlyData().obs;

  RxList<ChartData> weeklyCouponChartData = <ChartData>[].obs;
  RxList<ChartData> weeklyStampsChartData = <ChartData>[].obs;
  RxList<ChartData> weeklyRewardsChartData = <ChartData>[].obs;

  RxList<ChartData> monthlyCouponChartData = <ChartData>[].obs;
  RxList<ChartData> monthlyStampsChartData = <ChartData>[].obs;
  RxList<ChartData> monthlyRewardsChartData = <ChartData>[].obs;

  RxList<ChartData> yearlyCouponChartData = <ChartData>[].obs;
  RxList<ChartData> yearlyStampsChartData = <ChartData>[].obs;
  RxList<ChartData> yearlyRewardsChartData = <ChartData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await Stripe.instance.applySettings();
  }

  void getDashboardData() {
    getDashboardWeeklyData();
    getDashboardMonthlyData();
    getDashboardYearlyData();
  }

  Future<void> getDashboardWeeklyData() async {
    try {
      var response =
          await APIManager.getDashboardData(dataFor: StringConstant.lastWeek);
      weeklyData.value = DashboardWeeklyData();
      if (response.data['status']) {
        weeklyData.value = DashboardWeeklyData.fromJson(response.data['data']);
        weeklyCouponChartData.value = weeklyData.value.couponCounts!
            .map((e) => ChartData(
                  e!.date!,
                  e.total!.toDouble(),
                ))
            .toList();

        weeklyStampsChartData.value = weeklyData.value.redemptionsCount!
            .map((e) => ChartData(
                  e!.date!,
                  e.total!.toDouble(),
                ))
            .toList();

        weeklyRewardsChartData.value = weeklyData.value.rewardsCount!
            .map((e) => ChartData(
                  e!.date!,
                  e.total!.toDouble(),
                ))
            .toList();
      } else {
        Get.snackbar("Error", StringConstant.failedToGetDashboardData);
      }
    } catch (e) {
      print("An error occurred while getting weekly dashboard data: $e");
      // Get.snackbar("Error", StringConstant.somethingWentWrong);
    }
  }

  Future<void> getDashboardMonthlyData() async {
    try {
      var response =
          await APIManager.getDashboardData(dataFor: StringConstant.lastMonth);
      if (response.data['status']) {
        monthlyData.value = DashboardData.fromJson(response.data['data']);
        monthlyCouponChartData.value =
            monthlyData.value.couponCounts!.graphData!
                .map((e) => ChartData(
                      e!.week!,
                      e.count!.toDouble(),
                    ))
                .toList();

        monthlyStampsChartData.value =
            monthlyData.value.redemptionsCount!.graphData!
                .map((e) => ChartData(
                      e!.week!,
                      e.count!.toDouble(),
                    ))
                .toList();

        monthlyRewardsChartData.value =
            monthlyData.value.rewardsCount!.graphData!
                .map((e) => ChartData(
                      e!.week!,
                      e.count!.toDouble(),
                    ))
                .toList();
      } else {
        Get.snackbar("Error", StringConstant.failedToGetDashboardData);
      }
    } catch (e) {
      print("An error occurred while getting monthly dashboard data: $e");
      // Get.snackbar("Error", StringConstant.somethingWentWrong);
    }
  }

  Future<void> getDashboardYearlyData() async {
    try {
      var response =
          await APIManager.getDashboardData(dataFor: StringConstant.lastYear);
      if (response.data['status']) {
        yearlyData.value = DashboardYearlyData.fromJson(response.data['data']);
        yearlyCouponChartData.value = yearlyData.value.couponCounts!
            .map((e) => ChartData(
                  e!.month!,
                  e.total!.toDouble(),
                ))
            .toList();

        yearlyStampsChartData.value = yearlyData.value.redemptionsCount!
            .map((e) => ChartData(
                  e!.month!,
                  e.total!.toDouble(),
                ))
            .toList();

        yearlyRewardsChartData.value = yearlyData.value.rewardsCount!
            .map((e) => ChartData(
                  e!.month!,
                  e.total!.toDouble(),
                ))
            .toList();
      } else {
        Get.snackbar("Error", StringConstant.failedToGetDashboardData);
      }
    } catch (e) {
      print("An error occurred while getting yearly dashboard data: $e");
      // Get.snackbar("Error", StringConstant.somethingWentWrong);
    }
  }

  @override
  void onReady() {
    getRestaurantDetails();
    getDashboardData();
    super.onReady();
  }

  Rx<RestaurantDetails> restaurantDetails = RestaurantDetails(
    restaurantName: '',
    restaurantLogo: '',
    restaurantBanner: '',
    location: '',
    avgPrice: 0,
    description: '',
    features: [],
    timing: [],
    media: [],
    lat: '',
    lon: '',
    cuisine: [CuisineModel(id: "", name: "", image: "")],
  ).obs;

  String vendor = '';

  Future<void> getRestaurantDetails() async {
    try {
      var response = await APIManager.getVendor();
      vendor = response.data["data"]["_id"];
      print("vendor id: $vendor");
      restaurantDetails.value =
          RestaurantDetails.fromJson(response.data["data"]);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showLocationBottomSheet() {
    Get.bottomSheet(const LocationBottomSheet());
  }

  void gotoNotifications() {
    Get.toNamed(Routes.NOTIFICATIONS);
  }

  void gotoScanQr() {
    Get.toNamed(Routes.QR_SCAN);
  }

  void gotoJobsScreen() {
    Get.toNamed(Routes.JOBS);
  }

  void goToRestaurantDetails() {
    Get.toNamed(Routes.RATING_AND_FEEDBACK_MANAGEMENT);
  }
}
