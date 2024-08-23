import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

import '../../../models/rating_model.dart';

class RatingAndFeedbackManagementController extends GetxController {
  //TODO: Implement RatingAndFeedbackManagementController

  RxList<Rating> ratings = <Rating>[].obs;
  RxDouble selectedRatingFilter = 5.0.obs;

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
      var response = await APIManager.getRatings(id: id, rating: selectedRatingFilter.value.toInt());
      if(response.data["status"]){
        List data = response.data["data"];
        ratings.value = [];
        ratings.value = data.map((e) => Rating.fromJson(e)).toList();
      } else if(response.data["data"].toList().isEmpty){
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
