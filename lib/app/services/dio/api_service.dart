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
