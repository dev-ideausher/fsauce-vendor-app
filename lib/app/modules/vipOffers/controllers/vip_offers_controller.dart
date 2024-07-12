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

  RxList<Coupon> couponsList = <Coupon>[].obs;
  RxList<Coupon> inactiveCouponList = <Coupon>[].obs;
  Rx<Coupon> selectedCoupon = Coupon(title: '', typeOfOffer: '', validFor: '', validTill: '', description: '', termsAndConditions: [''], id: '', isActive: true, image: '').obs;

  @override
  void onInit() {
    getCoupons();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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
