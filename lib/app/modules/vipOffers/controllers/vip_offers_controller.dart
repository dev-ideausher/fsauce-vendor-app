import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/coupon_model.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/views/deals_bottom_sheet.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

class VipOffersController extends GetxController {
  //TODO: Implement VipOffersController

  final count = 0.obs;
  RxList<Coupon> couponsList = <Coupon>[].obs;
  RxList<Coupon> inactiveCouponList = <Coupon>[].obs;
  Rx<Coupon> selectedCoupon = Coupon(title: 'title', typeOfOffer: 'typeOfOffer', validFor: '', validTill: 'validTill', description: 'description', termsAndConditions: ['termsAndConditions'], id: 'id', isActive: true).obs;

  @override
  void onInit() {
    getCoupons();
    super.onInit();
  }

  Future<void> getCoupons() async{
    var response = await APIManager.getCouponList();
    List data = response.data["data"];

    couponsList.value = [];
    couponsList.value = data.map((e) => Coupon.fromJson(e)).toList();

    var responseData = await APIManager.getCouponList(status: false);
    List responseListData = responseData.data["data"];
    inactiveCouponList.value = [];
    inactiveCouponList.value = responseListData.map((e) => Coupon.fromJson(e)).toList();
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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

  void gotoEditVipOffer() {
    Get.toNamed(Routes.CREATE_OR_EDIT_VIP_OFFER, arguments: [true]);
  }
  void increment() => count.value++;
}
