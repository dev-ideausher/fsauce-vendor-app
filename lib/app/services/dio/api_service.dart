import 'dart:convert';
import 'package:dio/dio.dart';
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
        .post(Endpoints.updateVendor, data: restaurantDetails.toJson());
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
}
