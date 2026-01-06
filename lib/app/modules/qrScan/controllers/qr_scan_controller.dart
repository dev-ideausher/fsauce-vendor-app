import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/models/premium_user_model.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

import '../../../constants/string_constant.dart';

class QrScanController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController couponCodeController = TextEditingController();

  final premiumUsers = <Result>[].obs;
  final selectedPremiumUser = Rx<Result?>(null);

  final canRedeem = false.obs;
  final showUserError = false.obs;

  final isLoading = false.obs;
  final isMoreLoading = false.obs;

  final ScrollController scrollController = ScrollController();

  int page = 1;
  int totalPages = 1;
  final int limit = 10;
  String searchQuery = "";

  @override
  void onInit() {
    super.onInit();
    fetchUsers(isInitial: true);
    scrollController.addListener(_onScroll);
  }

  void updateRedeemState() {
    canRedeem.value = selectedPremiumUser.value != null &&
        couponCodeController.text.isNotEmpty;
  }

  void onSearch(String value) {
    searchQuery = value;
    fetchUsers(isInitial: true);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        !isMoreLoading.value &&
        page < totalPages) {
      loadMore();
    }
  }

  Future<void> fetchUsers({bool isInitial = false}) async {
    try {
      if (isInitial) {
        page = 1;
        premiumUsers.clear();
        isLoading.value = true;
      } else {
        isMoreLoading.value = true;
      }

      final response = await APIManager.getPremiumUsers(
        page: page.toString(),
        limit: limit.toString(),
        search: searchQuery,
      );

      if (response.data['status'] == true) {
        final model = PremiumUserModel.fromJson(response.data['data']);
        totalPages = model.totalPages ?? 1;
        premiumUsers.addAll(model.results ?? []);
      }
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  void loadMore() {
    page++;
    fetchUsers();
  }

  Future<void> redeemCode({required String userId}) async {
    if (!formKey.currentState!.validate()) return;

    try {
      final response = await APIManager.redeemCouponCode(
        code: couponCodeController.text,
        userId: userId,
      );

      if (response.data['status']) {
        Get.bottomSheet(
          const AddedSuccessfullBottomSheet(
            subTitle: StringConstant.redeemedSuccessfully,
          ),
        );

        Future.delayed(const Duration(seconds: 1), () {
          couponCodeController.clear();
          selectedPremiumUser.value = null;
          canRedeem.value = false;
          Get.offAllNamed(Routes.NAV_BAR);
        });
      } else {
        DialogHelper.showError(
            response.data['message'] ?? StringConstant.somethingWentWrong);
      }
    } catch (e) {
      if (e is DioException) {
        DialogHelper.showError(
            e.response?.data['message'] ?? StringConstant.somethingWentWrong);
      }
    }
  }

  @override
  void onClose() {
    couponCodeController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
