import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/models/faq_model.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

class HelpAndSupportScreenController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxList<FaqModel> faqs = <FaqModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool isMoreLoading = false.obs;

  int page = 1;
  final int limit = 10;
  bool hasMore = true;
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    getFaqList(isRefresh: true);
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchController.dispose();
    _debounce?.cancel();
    super.onClose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      page = 1;
      hasMore = true;
      getFaqList(isRefresh: true);
    });
  }

  Future<void> getFaqList({bool isRefresh = false}) async {
    if (isLoading.value || (isMoreLoading.value && !isRefresh)) return;

    if (isRefresh) {
      isLoading.value = true;
      faqs.clear();
      page = 1;
      hasMore = true;
    } else if (!hasMore) {
      return;
    } else {
      isMoreLoading.value = true;
    }

    try {
      var response = await APIManager.getFaqList(
        page: page,
        limit: limit,
        search: searchController.text,
      );

      if (response.data['status']) {
        List<dynamic> data = response.data['data'];
        List<FaqModel> newFaqs = data.map((e) => FaqModel.fromJson(e)).toList();

        if (newFaqs.length < limit) {
          hasMore = false;
        }

        if (isRefresh) {
          faqs.assignAll(newFaqs);
        } else {
          faqs.addAll(newFaqs);
        }

        if (newFaqs.isNotEmpty) {
          page++;
        }
      }
    } catch (e) {
      print("Error fetching FAQs: $e");
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }
}
