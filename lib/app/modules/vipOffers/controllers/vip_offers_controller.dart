import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/coupon_model.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/views/deals_bottom_sheet.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VipOffersController extends GetxController {
  //TODO: Implement VipOffersController
  ScrollController scrollController = ScrollController();
  RxBool activeCouponsLoading = false.obs;
  int activeCouponPage = 1;

  RxList<Coupon> couponsList = <Coupon>[].obs;
  RxList<Coupon> inactiveCouponList = <Coupon>[].obs;
  Rx<Coupon> selectedCoupon = Coupon(title: '', typeOfOffer: '', validFor: '', validTill: '', description: '', termsAndConditions: [''], id: '', isActive: true, image: '').obs;

  int currentPage = 1;
  final int limit = 10;
  var isLoading = false.obs;
  var isMoreDataAvailable = true.obs;

  int inactiveCurrentPage = 1;
  final int inactiveLimit = 10;
  var inactiveIsLoading = false.obs;
  var inactiveIsMoreDataAvailable = true.obs;

  @override
  void onInit() {
    getCoupons();
    scrollController = ScrollController()..addListener(_scrollListener);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    super.onClose();
  }

  _scrollListener() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter <= 0 && activeCouponsLoading.value == false) {
      addNewCoupons();
    }
  }

  Future<void> addNewCoupons() async{
    activeCouponPage += 1;
    activeCouponsLoading.value = true;
    try{
      final response = await APIManager.getCouponList(page: activeCouponPage, limit: limit);
      if(response.statusCode == 200){
        List<Coupon> fetchedCoupons = (response.data["data"] as List)
            .map((coupon) => Coupon.fromJson(coupon))
            .toList();
        couponsList.addAll(fetchedCoupons);
        activeCouponsLoading.value = false;
        return;
      } else{
        Get.snackbar("Message", response.data['message'] ?? "");
        activeCouponsLoading.value = false;
        return;
      }
    } catch(e){
      print("An error occurred while getting new coupons: $e");
      activeCouponsLoading.value = false;
      Get.snackbar("Error", "Could not get coupons");
      return;
    }
  }

  void updateCoupons() {
    updateInactiveCoupons();
    updateActiveCoupons();
  }

  void getCoupons(){
    getActiveCoupons();
    getInactiveCoupons();
  }

  void updateActiveCoupons() async {
    try {
      var response = await APIManager.getCouponList(
          page: currentPage, limit: limit);
      List<Coupon> fetchedCoupons = (response.data["data"] as List)
          .map((coupon) => Coupon.fromJson(coupon))
          .toList();

      if (fetchedCoupons.length < limit) {
        isMoreDataAvailable.value = false;
      } else {
        currentPage++;
      }
      couponsList.value = [];
      couponsList.addAll(fetchedCoupons);
    } catch (e) {
      print(e);
    }
  }

  void updateInactiveCoupons() async {
    try {
      var response = await APIManager.getCouponList(
          page: inactiveCurrentPage, limit: inactiveLimit, status: false);
      List<Coupon> fetchedCoupons = (response.data["data"] as List)
          .map((coupon) => Coupon.fromJson(coupon))
          .toList();

      if (fetchedCoupons.length < inactiveLimit) {
        inactiveIsMoreDataAvailable.value = false;
      } else {
        inactiveCurrentPage++;
      }
      inactiveCouponList.value = [];
      inactiveCouponList.addAll(fetchedCoupons);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getActiveCoupons() async{
    if (isLoading.value || !isMoreDataAvailable.value) return;

    isLoading.value = true;

    try{
      final response = await APIManager.getCouponList(
        page: currentPage, limit: limit,
      );
      List<Coupon> fetchedCoupons = (response.data["data"] as List)
          .map((coupon) => Coupon.fromJson(coupon))
          .toList();

      if (fetchedCoupons.length < limit) {
        isMoreDataAvailable.value = false;
      } else {
        currentPage++;
      }

      couponsList.addAll(fetchedCoupons);
    } catch(e){
      print("Error occurred while getting coupons: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getInactiveCoupons() async{
    if (inactiveIsLoading.value || !inactiveIsMoreDataAvailable.value) return;

    inactiveIsLoading.value = true;

    try{
      final response = await APIManager.getCouponList(
        page: inactiveCurrentPage, limit: inactiveLimit, status: false
      );
      List<Coupon> fetchedCoupons = (response.data["data"] as List)
          .map((coupon) => Coupon.fromJson(coupon))
          .toList();

      if (fetchedCoupons.length < inactiveLimit) {
        inactiveIsMoreDataAvailable.value = false;
      } else {
        inactiveCurrentPage++;
      }

      inactiveCouponList.addAll(fetchedCoupons);
    } catch(e){
      print("Error occurred while getting coupons: $e");
    } finally {
      inactiveIsLoading.value = false;
    }
  }

  void showDealsBottomSheet() {
    Get.bottomSheet(
      DealsBottomSheet(coupon: selectedCoupon.value),
    );
  }

  void showDeleteDialog(Coupon coupon) {
    Get.dialog(ConfrimationDialog(
      onNoTap: Get.back,
      onYesTap: () {
        APIManager.deleteCoupon(coupon.id);
        couponsList.remove(coupon);
      },
      subTitle: StringConstant.deleteOfferSub,
      title: StringConstant.deleteOffer,
    ));
  }

  void showInactiveDialog(Coupon coupon) {
    Get.dialog(ConfrimationDialog(
      onNoTap: Get.back,
      onYesTap: () {
        APIManager.editCoupon(coupon, false);
        couponsList.remove(coupon);
        inactiveCouponList.add(coupon);
      },
      subTitle: StringConstant.inactiveOfferSub,
      title: StringConstant.inactiveOffer,
    ));
  }

  void showActiveDialog(Coupon coupon) {
    Get.dialog(ConfrimationDialog(
      onNoTap: Get.back,
      onYesTap: () {
        APIManager.editCoupon(coupon, true);
        couponsList.add(coupon);
        inactiveCouponList.remove(coupon);
      },
      subTitle: StringConstant.activeOfferSub,
      title: StringConstant.activeOffer,
    ));
  }

  void gotoCreateVipOffer() {
    Get.toNamed(Routes.CREATE_OR_EDIT_VIP_OFFER, arguments: [false]);
  }

  void gotoEditVipOffer(Coupon coupon) {
    selectedCoupon.value = coupon;
    Get.toNamed(Routes.CREATE_OR_EDIT_VIP_OFFER, arguments: [true]);
  }
}
