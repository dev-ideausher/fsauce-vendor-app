import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/views/deals_bottom_sheet.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class VipOffersController extends GetxController {
  //TODO: Implement VipOffersController

  final count = 0.obs;
  @override
  void onInit() {
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

  void showDealsBottomSheet() {
    Get.bottomSheet(
      const DealsBottomSheet(),
    );
  }

  void showDeleteDialog() {
    Get.dialog(ConfrimationDialog(
      onNoTap: Get.back,
      onYesTap: () {},
      subTitle: StringConstant.deleteOfferSub,
      title: StringConstant.deleteOffer,
    ));
  }

  void showInactiveDialog() {
    Get.dialog(ConfrimationDialog(
      onNoTap: Get.back,
      onYesTap: () {},
      subTitle: StringConstant.inactiveOfferSub,
      title: StringConstant.inactiveOffer,
    ));
  }

  void showActiveDialog() {
    Get.dialog(ConfrimationDialog(
      onNoTap: Get.back,
      onYesTap: () {},
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
