import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fsauce_vendor_app/app/components/loyalty_card.dart';
import 'package:fsauce_vendor_app/app/models/coupon_model.dart';
import 'package:fsauce_vendor_app/app/models/loyalty_card.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'client.dart';
import 'endpoints.dart';

class APIManager {
  ///Post API
  static Future<Response> postApiExample({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.baseUrl, data: jsonEncode(body));
//onboarding vendor
  static Future<Response> onboardVendor() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.onboardVendor);

//profileUpdate
  static Future<Response> updateVendor({
    required RestaurantDetails restaurantDetails,
  }) async {
    print(restaurantDetails.toJson());
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.updateVendor, data: {
      'restaurantName': restaurantDetails.restaurantName,
      'restaurantLogo': restaurantDetails.restaurantLogo,
      'restaurantBanner': restaurantDetails.restaurantBanner,
      'location': restaurantDetails.location,
      'avgPrice': restaurantDetails.avgPrice,
      'description': restaurantDetails.description,
      'features': restaurantDetails.features,
      'timing': restaurantDetails.timing.map((timing) => timing.toJson()).toList(),
      'media': restaurantDetails.media,
    });
  }

  //Get Vendor
  static Future<Response> getVendor() async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
        .get(Endpoints.getVendor);
  }

  //addCategory
  static Future<Response> addCategory({
    required String categoryName,
  }) async {
    return await DioClient(Dio(), showSnakbar: false, isOverlayLoader: true)
        .post(Endpoints.addCategory, data: {"name": categoryName});
  }

  //getCategory

  static Future<Response> getCategories() async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).get(
      Endpoints.getCategory,
    );
  }

  //deleteCategor

  static Future<Map<String, dynamic>> deleteCategory(
      {required String id}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .delete(Endpoints.deleteCategory, queryParameters: {"id": id});
  }

  //edit category
  static Future<Response> editCategory({
    required String categoryName,
    required String id,
  }) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.editCategory, data: {"id": id, "name": categoryName});
  }

  // add menu item

  static Future<Response> addMenuItem({
    required String itemName,
    required String categoryId,
    required String imgUrl,
  }) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.addMenuItem,
            data: {"category": categoryId, "image": imgUrl, "name": itemName});
  }

  //delete menu item

  static Future<Map<String, dynamic>> deleteMenuItem(
      {required String id}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .delete(Endpoints.deleteMenuItem, queryParameters: {"id": id});
  }

  //edit menu item

  static Future<Response> editMenuItem({
    required String itemName,
    required String categoryId,
    required String imgUrl,
  }) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.editMenuItem,
            data: {"id": categoryId, "image": imgUrl, "name": itemName});
  }

  //add job
  static Future<Response> addNewJob({
    required String title,
    required String description,
    required String lastDate,
    required int minSalary,
    required int maxSalary,
    required String howToApply,
  }) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.addJob, data: {
      "title": title,
      "description": description,
      "lastDate": lastDate,
      "minSalary": minSalary,
      "maxSalary": maxSalary,
      "howToApply": howToApply
    });
  }

  //get jobs
  static Future<Response> getJobs(
      {required String page, required String limit}) async {
    return await DioClient(Dio(),
            showSnakbar: true, isOverlayLoader: page == "1")
        .get(Endpoints.getJobs,
            queryParameters: {"page": page, "limit": limit});
  }

  //delete job
  static Future<Map<String, dynamic>> deleteJob({required String id}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .delete(Endpoints.deleteJob, queryParameters: {"id": id});
  }

  //edit job

  static Future<Response> editJob({
    required String id,
    required String title,
    required String description,
    required String lastDate,
    required int minSalary,
    required int maxSalary,
    required String howToApply,
  }) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.editJob, data: {
      "id": id,
      "title": title,
      "description": description,
      "lastDate": lastDate,
      "minSalary": minSalary,
      "maxSalary": maxSalary,
      "howToApply": howToApply
    });
  }

  //Post Coupon
  static Future<Response> addCoupon({
    required String title,
    required String typeOfOffer,
    required String validFor,
    required String validTill,
    required String description,
    required List<String> termsAndConditions,
    required bool isActive,
  }) async{
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.addCoupon, data: {
          'title': title,
      'typeOfOffer': typeOfOffer,
      'validFor': validFor,
      'validTill': validTill,
      'description': description,
      'termsAndConditions': termsAndConditions,
      'isActive': isActive,
    },);
  }

  //Get Coupon list
  static Future<Response> getCouponList({int page = 1, int limit = 5, bool status = true}) async{
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .get("${Endpoints.getCouponList}status=$status&page=$page&limit=$limit");
  }

  //Get coupon
  static Future<Response> getCoupon(String id) async{
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .get("${Endpoints.getCoupon}$id");
  }

  //Edit coupon list
  static Future<Response> editCoupon(Coupon coupon, bool isActive) async{
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.editCoupon, data: {
      'title': coupon.title,
      'typeOfOffer': coupon.typeOfOffer,
      'validFor': coupon.validFor,
      'validTill': coupon.validTill,
      'description': coupon.description,
      'termsAndConditions': coupon.termsAndConditions,
      'isActive': isActive,
      'id': coupon.id,
      },
    );
  }

  //Delete Coupon
  static Future<Map<String, dynamic>> deleteCoupon(String id) async{
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .delete("${Endpoints.deleteCoupon}$id");
  }

  //Get loyalty cards
  static Future<Response> getLoyaltyCards({int page = 1, int limit = 5, bool status = true}) async{
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .get("${Endpoints.getLoyaltyCards}status=$status&page=$page&limit=$limit");
  }

  //Add loyalty card
  static Future<Response> addLoyaltyCard({
    required String title,
    required int noOfStamps,
    required String cardBackgroundColor,
    required String cardTextColor,
    required String stampBackgroundColor,
    required String stampColor,
    required String vendor,
    required bool isActive,
  }) async{
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.addLoyaltyCard, data: {
      'title': title,
      'noOfStamps': noOfStamps,
      'cardBackgroundColor': cardBackgroundColor,
      'cardTextColor': cardTextColor,
      'stampBackgroundColor': stampBackgroundColor,
      'stampColor': stampColor,
      'vendor': vendor,
      'isActive': isActive,
    },);
  }

  //Edit loyalty card
  static Future<Response> editLoyaltyCard(LoyaltyCardModel card, bool isActive) async{
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.editCoupon, data: {
      'title': card.title,
      'noOfStamps': card.noOfStamps,
      'cardBackgroundColor': card.cardBackgroundColor,
      'cardTextColor': card.cardTextColor,
      'stampBackgroundColor': card.stampBackgroundColor,
      'stampColor': card.stampColor,
      'vendor': card.vendor,
      'isActive': isActive,
      '_id': card.Id
    },
    );
  }

  //Delete loyalty card
  static Future<Map<String, dynamic>> deleteLoyaltyCard(String id) async{
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .delete("${Endpoints.delLoyaltyCard}$id");
  }


//file upload
  static Future<Response> uploadFile({
    required String filePath,
    Map<String, dynamic>? additionalData,
  }) async {
    final file = await MultipartFile.fromFile(filePath);

    FormData formData = FormData.fromMap({
      'file': file,
      ...?additionalData, // Add additional form data if any
    });

    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.fileUpload, data: formData);
  }

  //vendor file upload
  static Future<Response> uploadVendorFile({
    required String filePath,
    Map<String, dynamic>? additionalData,
  }) async {
    final file = await MultipartFile.fromFile(filePath);

    FormData formData = FormData.fromMap({
      'file': file,
      ...?additionalData, // Add additional form data if any
    });

    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.vendorFileUpload, data: formData);
  }
}
