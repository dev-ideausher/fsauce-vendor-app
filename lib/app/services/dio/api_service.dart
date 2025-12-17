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

  static Future<Response> onboardVendor() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.onboardVendor);

  static Future<Response> updateVendor({
    required RestaurantDetails restaurantDetails,
  }) async {
    print(restaurantDetails.toJson());
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.updateVendor, data: restaurantDetails.toJson());
  }

  static Future<Response> getVendor() async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
        .get(Endpoints.getVendor);
  }

  static Future<Response> addCategory({
    required String categoryName,
  }) async {
    return await DioClient(Dio(), showSnakbar: false, isOverlayLoader: true)
        .post(Endpoints.addCategory, data: {"name": categoryName});
  }

  static Future<Response> getCategories() async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).get(
      Endpoints.getCategory,
    );
  }

  static Future<Map<String, dynamic>> deleteCategory(
      {required String id}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .delete(Endpoints.deleteCategory, queryParameters: {"id": id});
  }

  static Future<Response> editCategory({
    required String categoryName,
    required String id,
  }) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.editCategory, data: {"id": id, "name": categoryName});
  }

  static Future<Response> addMenuItem({
    required String itemName,
    required String categoryId,
    required String imgUrl,
  }) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.addMenuItem,
            data: {"category": categoryId, "image": imgUrl, "name": itemName});
  }

  static Future<Map<String, dynamic>> deleteMenuItem(
      {required String id}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .delete(Endpoints.deleteMenuItem, queryParameters: {"id": id});
  }

  static Future<Response> editMenuItem({
    required String itemName,
    required String categoryId,
    required String imgUrl,
  }) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.editMenuItem,
            data: {"id": categoryId, "image": imgUrl, "name": itemName});
  }

  static Future<Response> addNewJob(
      {required Map<String, dynamic> data}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.addJob, data: data);
  }

  static Future<Response> getJobs(
      {required String page, required String limit}) async {
    return await DioClient(Dio(),
            showSnakbar: true, isOverlayLoader: page == "1")
        .get(Endpoints.getJobs,
            queryParameters: {"page": page, "limit": limit});
  }

  static Future<Map<String, dynamic>> deleteJob({required String id}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .delete(Endpoints.deleteJob, queryParameters: {"id": id});
  }

  static Future<Response> editJob({required Map<String, dynamic> data}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.editJob, data: data);
  }

  static Future<Response> addCoupon(
      {required Map<String, dynamic> data}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(
      Endpoints.addCoupon,
      data: data,
    );
  }

  static Future<Response> getCouponList(
      {int page = 1, int limit = 5, bool status = true}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).get(
        "${Endpoints.getCouponList}status=$status&page=$page&limit=$limit");
  }

  static Future<Response> getCoupon(String id) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .get("${Endpoints.getCoupon}$id");
  }

  static Future<Response> editCoupon(Coupon coupon, bool isActive) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(
      Endpoints.editCoupon,
      data: {
        "title": coupon.title,
        "typeOfOffer": coupon.typeOfOffer,
        "validFor": coupon.validFor,
        "validTill": coupon.validTill,
        "description": coupon.description,
        "termsAndConditions": coupon.termsAndConditions,
        "id": coupon.id,
        "isActive": isActive,
        "image": coupon.image,
        "isSheduled": coupon.isSheduled ?? "",
        "sheduleDate": coupon.sheduleDate ?? "",
      },
    );
  }

  static Future<Map<String, dynamic>> deleteCoupon(String id) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .delete("${Endpoints.deleteCoupon}$id");
  }

  static Future<Response> getLoyaltyCards(
      {int page = 1, int limit = 5, bool status = true}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).get(
        "${Endpoints.getLoyaltyCards}status=$status&page=$page&limit=$limit");
  }

  static Future<Response> addLoyaltyCard(
      {required Map<String, dynamic> data}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(
      Endpoints.addLoyaltyCard,
      data: data,
    );
  }

  static Future<Response> editLoyaltyCard(
      LoyaltyCardModel card, bool isActive) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.editCoupon, data: card.toJson());
  }

  static Future<Map<String, dynamic>> deleteLoyaltyCard(String id) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .delete("${Endpoints.delLoyaltyCard}$id");
  }

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

  static Future<Map<String, dynamic>> deleteMedia(String url, String id) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .delete(Endpoints.deleteMedia, data: {
      "url": url,
      "userid": id,
    });
  }

  static Future<Response> getRatings(
      {int rating = 5, required String id}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .get(Endpoints.getRatings, queryParameters: {
      'id': id,
      'rating': rating,
    });
  }

  static Future<Map<String, dynamic>> deleteRating(String id) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .delete(Endpoints.deleteRating, queryParameters: {
      "id": id,
    });
  }

  static Future<Response> addPushNotification(
      {required Map<String, dynamic> data}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(
      Endpoints.addNotification,
      data: data,
    );
  }

  static Future<Response> getNotifications(
      {int page = 1, int limit = 10}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
        .get(Endpoints.getNotification, queryParameters: {
      "page": page,
      "limit": limit,
      "limit": limit,
    });
  }

  static Future<Response> getVendorNotifications(
      {int page = 1, int limit = 10}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
        .get(Endpoints.getVendorNotifications, queryParameters: {
      "page": page,
      "limit": limit,
      "limit": limit,
    });
  }

  static Future<Map<String, dynamic>> deleteNotification(
      {required String id}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .delete(Endpoints.deleteNotification, queryParameters: {"id": id});
  }

  static Future<Response> editNotification(
      {required String id, required bool isActive}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .patch(Endpoints.editNotification,
            data: {"id": id, "isActive": isActive});
  }

  static Future<Response> getPrivacyPolicy() async {
    return await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false)
        .get(Endpoints.getPrivacyPolicy);
  }

  static Future<Response> getContentPolicy() async {
    return await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false)
        .get(Endpoints.getContentPolicy);
  }

  static Future<Response> getFaqList(
      {int page = 1, int limit = 10, String search = ""}) async {
    return await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false)
        .get(Endpoints.getFaqList, queryParameters: {
      "page": page,
      "limit": limit,
      "search": search,
    });
  }

  static Future<Response> getTermsAndConditions() async {
    return await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false)
        .get(Endpoints.getTermsAndConditions);
  }

  static Future<Response> getFeatures() async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
        .get(Endpoints.getFeatures);
  }

  static Future<Response> getCuisines() async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .get(Endpoints.getCuisine);
  }

  static Future<Response> scanLoyaltyCard(
      {required Map<String, dynamic> data}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.scanLoyaltyCard, data: data);
  }

  static Future<Response> getLoyaltyStampDatewise({String? date}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false).get(
        Endpoints.getLoyaltyStampDatewise,
        queryParameters: date != null ? {"date": date} : null);
  }

  static Future<Response> getLoyaltyScanStats({String? date}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false).get(
        Endpoints.getLoyaltyScanStats,
        queryParameters: date != null ? {"date": date} : null);
  }

  static Future<Response> getDashboardData({required String dataFor}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .get(Endpoints.dashboardData, queryParameters: {"dataFor": dataFor});
  }

  static Future<Response> redeemCouponCode({required String code}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.redeemCouponCode, data: {"couponCode": code});
  }

  static Future<Response> getSubscriptionPlans() async {
    return await DioClient(Dio(), showSnakbar: false, isOverlayLoader: true)
        .get(Endpoints.getSubscriptionPlans);
  }

  static Future<Response> getVendorSubscriptionList() async {
    return await DioClient(Dio(), showSnakbar: false, isOverlayLoader: true)
        .get(Endpoints.getVendorSubscriptionList);
  }

  static Future<Response> deleteCard(String id) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .get("${Endpoints.delCard}$id");
  }

  static Future<Response> addVendorSubscription(
      {required Map<String, dynamic> data}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(
      Endpoints.vendorSubscription,
      data: data,
    );
  }

  static Future<Response> addCard({required Map<String, dynamic> data}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(
      Endpoints.addCard,
      data: data,
    );
  }

  static Future<Response> getCardDataList() async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).get(
      Endpoints.getCardList,
    );
  }

  static Future<Response> cancelSubscription(
      {required Map<String, dynamic> data}) async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .post(Endpoints.cancelSubscription, data: data);
  }

  static Future<Map<String, dynamic>> deleteAccount() async {
    return await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
        .delete(Endpoints.deleteVendor);
  }

  static Future<Response> getLocation(String placeApiKey) async =>
      await DioClient(Dio(), baseUrl: Endpoints.mapApiUrl).get(placeApiKey);
  static Future<Response> getLocationLatLong(String placeApiKey) async =>
      await DioClient(Dio(), baseUrl: Endpoints.mapApiUrl).get(placeApiKey);

  static Future<Response> googlePlacesAutocomplete(
      String query, String apiKey, String sessionToken) async {
    return await DioClient(Dio(), baseUrl: Endpoints.mapApiUrl).get(
      "autocomplete/json",
      queryParameters: {
        "input": query,
        "key": apiKey,
        "sessiontoken": sessionToken,
      },
    );
  }

  static Future<Response> googlePlaceDetails(
      String placeId, String apiKey) async {
    return await DioClient(Dio(), baseUrl: Endpoints.mapApiUrl).get(
      "details/json",
      queryParameters: {
        "place_id": placeId,
        "key": apiKey,
        "fields": "geometry",
      },
    );
  }
}
