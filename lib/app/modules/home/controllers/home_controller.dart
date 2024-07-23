import 'dart:convert';

import 'package:fsauce_vendor_app/app/models/cuisine_model.dart';
import 'package:fsauce_vendor_app/app/models/dashboard_weekly_data_model.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/home/views/location_bottom_sheet.dart';
import 'package:fsauce_vendor_app/app/modules/navBar/controllers/nav_bar_controller.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
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
  void onInit() {
    getRestaurantDetails();
    getDashboardData();
    super.onInit();
  }

  void getDashboardData(){
    getDashboardWeeklyData();
    getDashboardMonthlyData();
    getDashboardYearlyData();
  }

  Future<void> getDashboardWeeklyData() async{
    try{
      var response = await APIManager.getDashboardData(dataFor: StringConstant.lastWeek);
      weeklyData.value = DashboardWeeklyData();
      if(response.data['status']){
        weeklyData.value = DashboardWeeklyData.fromJson(response.data['data']);
        print("WeeklyData value coupons: ${weeklyData.value.couponCounts!.length}");
        weeklyCouponChartData.value = List.generate(
            weeklyData.value.cards!.totalCoupons!, (int index){
          return ChartData(weeklyData.value.couponCounts![index]!.date!, double.parse(weeklyData.value.couponCounts![index]!.total!.toString()));
        });
        weeklyStampsChartData.value = List.generate(weeklyData.value.cards!.totalStamps!, (int index){
          return ChartData(weeklyData.value.redemptionsCount![index]!.date!, double.parse(weeklyData.value.redemptionsCount![index]!.total!.toString()));
        });
        weeklyRewardsChartData.value = List.generate(weeklyData.value.cards!.totalRewards!, (int index){
          return ChartData(weeklyData.value.rewardsCount![index]!.date!, double.parse(weeklyData.value.rewardsCount![index]!.total!.toString()));
        });
      } else{
        DialogHelper.showError(StringConstant.failedToGetDashboardData);
      }
    } catch(e){
      print("An error occurred while getting dashboard data: $e");
      // DialogHelper.showError(StringConstant.somethingWentWrong);
    }
  }

  Future<void> getDashboardMonthlyData() async{
    try{
      var response = await APIManager.getDashboardData(dataFor: StringConstant.lastMonth);
      if(response.data['status']){
        monthlyData.value = DashboardData.fromJson(response.data['data']);
        monthlyCouponChartData.value = List.generate(monthlyData.value.cards!.totalCoupons!, (int index){
          return ChartData(monthlyData.value.couponCounts!.graphData![index]!.week!, double.parse(monthlyData.value.couponCounts!.graphData![index]!.count!.toString()));
        });
        monthlyStampsChartData.value = List.generate(monthlyData.value.cards!.totalStamps!, (int index){
          return ChartData(monthlyData.value.redemptionsCount!.graphData![index]!.week!, double.parse(monthlyData.value.redemptionsCount!.graphData![index]!.count!.toString()));
        });
        monthlyRewardsChartData.value = List.generate(monthlyData.value.cards!.totalRewards!, (int index){
          return ChartData(monthlyData.value.rewardsCount!.graphData![index]!.week!, double.parse(monthlyData.value.rewardsCount!.graphData![index]!.count!.toString()));
        });
      } else{
        DialogHelper.showError(StringConstant.failedToGetDashboardData);
      }
    } catch(e){
      print("An error occurred while getting dashboard data: $e");
      // DialogHelper.showError(StringConstant.somethingWentWrong);
    }
  }

  Future<void> getDashboardYearlyData() async{
    try{
      var response = await APIManager.getDashboardData(dataFor: StringConstant.lastYear);
      if(response.data['status']){
        yearlyData.value = DashboardYearlyData.fromJson(response.data['data']);
        yearlyCouponChartData.value = List.generate(yearlyData.value.cards!.totalCoupons!, (int index){
          return ChartData(yearlyData.value.couponCounts![index]!.month!, double.parse(yearlyData.value.couponCounts![index]!.order!.toString()));
        });
        yearlyStampsChartData.value = List.generate(yearlyData.value.cards!.totalStamps!, (int index){
          return ChartData(yearlyData.value.redemptionsCount![index]!.month!, double.parse(yearlyData.value.redemptionsCount![index]!.order!.toString()));
        });
        yearlyStampsChartData.value = List.generate(yearlyData.value.cards!.totalRewards!, (int index){
          return ChartData(yearlyData.value.rewardsCount![index]!.month!, double.parse(yearlyData.value.rewardsCount![index]!.order!.toString()));
        });
      } else{
        DialogHelper.showError(StringConstant.failedToGetDashboardData);
      }
    } catch(e){
      print("An error occurred while getting dashboard data: $e");
      // DialogHelper.showError(StringConstant.somethingWentWrong);
    }
  }

  @override
  void onReady() {
    getRestaurantDetails();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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
    cuisine: [CuisineModel(id: "", name: "", image: "")],
  ).obs;

  String vendor = '';

  void getRestaurantDetails() async{
    var response = await APIManager.getVendor();
    vendor = response.data["data"]["_id"];
    print("vendor id: $vendor");
    restaurantDetails.value = RestaurantDetails.fromJson(response.data["data"]);
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
