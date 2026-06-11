import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

import '../../../models/rating_model.dart';

class RatingAndFeedbackManagementController extends GetxController {
  RxList<Rating> ratings = <Rating>[].obs;
  RxDouble selectedRatingFilter = 5.0.obs;

  /// Average rating from API (`Rating` in JSON).
  final RxDouble averageRating = 0.0.obs;

  /// Total rating count from API (`totalRating` in JSON).
  final RxInt totalRatingCount = 0.obs;

  /// Share of each star level (5★ → 1★) within the current [ratings] list.
  List<double> starDistributionShares() {
    if (ratings.isEmpty) {
      return List<double>.filled(5, 0);
    }
    final counts = List<int>.filled(5, 0);
    for (final r in ratings) {
      final s = r.rating;
      if (s != null && s >= 1 && s <= 5) {
        counts[5 - s]++;
      }
    }
    final total = counts.fold<int>(0, (a, b) => a + b);
    if (total == 0) {
      return List<double>.filled(5, 0);
    }
    return counts.map((c) => c / total).toList();
  }

  int averageRatingStarRow() =>
      averageRating.value.round().clamp(0, 5);

  /// Reviews to show in the list (server returns all; filter is client-side when [selectedRatingFilter] is above zero).
  List<Rating> get displayedRatings {
    if (selectedRatingFilter.value <= 0) {
      return ratings;
    }
    final target = selectedRatingFilter.value.round();
    return ratings.where((r) => r.rating == target).toList();
  }

  @override
  void onInit() {
    super.onInit();
    getRatings();
  }

  void showRatingDeleteDialog(String id) {
    Get.dialog(ConfrimationDialog(
        title: StringConstant.deleteReview,
        subTitle: StringConstant.deleteReviewSub,
        onYesTap: () async {
          try {
            var response = await APIManager.deleteRating(id);
            if (response["status"]) {
              getRatings();
              DialogHelper.showSuccess(StringConstant.deletedSuccessfully);
            }
          } catch (e) {
            Get.snackbar("Error",StringConstant.somethingWentWrong);
          }
        },
        onNoTap: Get.back));
  }

  Future<void> getRatings() async{
    String id = Get.find<HomeController>().vendor;
    try{
      var response = await APIManager.getRatings(id: id);
      if (response.data["status"]) {
        final List data = response.data["data"] ?? [];
        ratings.value = data.map((e) => Rating.fromJson(e)).toList();
        final raw = response.data["Rating"];
        averageRating.value = (raw is num) ? raw.toDouble() : 0.0;
        final totalRaw = response.data["totalRating"];
        totalRatingCount.value = (totalRaw is num) ? totalRaw.toInt() : 0;
      } else if ((response.data["data"] as List?)?.isEmpty ?? true) {
        Get.snackbar(StringConstant.noRatingsFound, StringConstant.noRatingsFound);
      }
      else{
        Get.snackbar("Error",StringConstant.anErrorOccurredWhileGettingRatings);
      }
    } catch(e){
      Get.snackbar("Error", e.toString());
    }
  }
}
