import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/coupon_model.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/views/deals_bottom_sheet.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

class VipOffersController extends GetxController {
  ScrollController activeScrollController = ScrollController();
  ScrollController inActiveScrollController = ScrollController();

  RxList<Coupon> couponsList = <Coupon>[].obs;
  RxList<Coupon> inactiveCouponList = <Coupon>[].obs;
  Rx<Coupon> selectedCoupon = Coupon(title: '', typeOfOffer: '', validFor: '', validTill: '', description: '', termsAndConditions: [''], id: '', isActive: true, image: '').obs;

  int currentActivePage = 1;
  final int activeLimit = 5;
  var isActiveLoading = false.obs;
  var isMoreActiveDataAvailable = true.obs;

  int currentInactivePage = 1;
  final int inActiveLimit = 5;
  var isInActiveLoading = false.obs;
  var isMoreInactiveDataAvailable = true.obs;

  @override
  void onInit() {
    getCoupons();
    activeScrollController = ScrollController()..addListener(_scrollListener);
    inActiveScrollController = ScrollController()..addListener(_inactiveScrollListener);
    super.onInit();
  }

  @override
  void onClose() {
    activeScrollController.removeListener(_scrollListener);
    inActiveScrollController.removeListener(_inactiveScrollListener);
    super.onClose();
  }

  _scrollListener() {
    if (activeScrollController.position.extentAfter <= 0 && isActiveLoading.value == false) {
      addActiveCoupons();
    }
  }

  _inactiveScrollListener(){
    if(inActiveScrollController.position.extentAfter <= 0 && isInActiveLoading.value == false){
      addInactiveCoupons();
    }
  }

  void addInactiveCoupons() async{
    if (isInActiveLoading.value || !isMoreInactiveDataAvailable.value) return;

    isInActiveLoading.value = true;
    try{
      var response = await APIManager.getCouponList(page: currentInactivePage + 1, limit: inActiveLimit, status: false);
      List<Coupon> fetchedCoupons = (response.data['data'] as List).map((coupon) => Coupon.fromJson(coupon)).toList();

      if(fetchedCoupons.length < inActiveLimit){
        isMoreInactiveDataAvailable.value = false;
      } else{
        ++currentInactivePage;
      }

      inactiveCouponList.addAll(fetchedCoupons);
    } catch(e){
      print("An error occurred while adding inactive coupons!: $e");
    } finally {
      isInActiveLoading.value = false;
    }
    return;
  }

  void addActiveCoupons() async{
    if (isActiveLoading.value || !isMoreActiveDataAvailable.value) return;

    isActiveLoading.value = true;
    try{
      var response = await APIManager.getCouponList(page: currentActivePage + 1, limit: activeLimit, status: true);
      List<Coupon> fetchedCoupons = (response.data['data'] as List).map((coupon) => Coupon.fromJson(coupon)).toList();

      if(fetchedCoupons.length < activeLimit){
        isMoreActiveDataAvailable.value = false;
      } else{
        ++currentActivePage;
      }

      couponsList.addAll(fetchedCoupons);
    } catch(e){
      print("An error occurred while adding active coupons!: $e");
    } finally {
      isActiveLoading.value = false;
    }
    return;
  }

  Future<void> getCoupons() async{
    currentActivePage = 1;
    isMoreActiveDataAvailable.value = true;
    isActiveLoading.value = false;
    var response = await APIManager.getCouponList(status: true);
    List<Coupon> fetchedCoupons = (response.data["data"] as List)
        .map((coupon) => Coupon.fromJson(coupon))
        .toList();

    couponsList.value = fetchedCoupons;

    currentInactivePage = 1;
    isMoreInactiveDataAvailable.value = true;
    isInActiveLoading.value = false;
    var inactiveResponse = await APIManager.getCouponList(status: false);
    List<Coupon> fetchedInactiveCoupon = (inactiveResponse.data['data'] as List)
    .map((coupon) => Coupon.fromJson(coupon))
    .toList();

    inactiveCouponList.value = fetchedInactiveCoupon;
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
        addActiveCoupons();
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
        addInactiveCoupons();
      },
      subTitle: StringConstant.activeOfferSub,
      title: StringConstant.activeOffer,
    ));
  }

  void gotoCreateVipOffer() {
    Get.toNamed(Routes.CREATE_OR_EDIT_VIP_OFFER, arguments: [false, couponsList]);
  }

  void gotoEditVipOffer(Coupon coupon) {
    selectedCoupon.value = coupon;
    Get.toNamed(Routes.CREATE_OR_EDIT_VIP_OFFER, arguments: [true]);
  }
}
