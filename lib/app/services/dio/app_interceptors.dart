import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import '../../routes/app_pages.dart';
import '../dialog_helper.dart';
import '../snackbar.dart';
import '../storage.dart';
import 'exceptions.dart';
import 'jwt_decoder.dart';

class AppInterceptors extends Interceptor {
  static const _retryKey = 'authTokenRetry';

  bool isOverlayLoader;
  bool showSnakbar;

  AppInterceptors({this.isOverlayLoader = true, this.showSnakbar = true});

  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_isPublicRequest(options)) {
      super.onRequest(options, handler);
      return;
    }

    isOverlayLoader ? DialogHelper.showLoading() : null;

    final token = await Helpers.getValidFirebaseToken();
    if (token == null) {
      isOverlayLoader ? DialogHelper.hideDialog() : null;
      Helpers.handleSessionExpired();
      handler.reject(DioException(
        requestOptions: options,
        type: DioExceptionType.cancel,
        error: 'Session Expired. Please Login Again',
      ));
      return;
    }

    options.headers.addAll({
      "Authorization": "Bearer $token",
      // "type": "app"
    });
    super.onRequest(options, handler);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    isOverlayLoader ? DialogHelper.hideDialog() : null;
  }

  @override
  Future<dynamic> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRefreshToken(err)) {
      final retryCount = err.requestOptions.extra[_retryKey] == true;
      if (!retryCount) {
        try {
          final token = await Helpers.refreshFirebaseToken();
          if (token != null) {
            final retryOptions = err.requestOptions;
            retryOptions.extra[_retryKey] = true;
            retryOptions.headers['Authorization'] = 'Bearer $token';

            final response = await retry(retryOptions);
            isOverlayLoader ? DialogHelper.hideDialog() : null;
            return handler.resolve(response);
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }

    try {
      final errorMessage = DioExceptions.fromDioError(err).toString();
      isOverlayLoader ? DialogHelper.hideDialog() : null;
      showSnakbar == true
          ? showMySnackbar(msg: errorMessage, title: 'Error')
          : null;
    } catch (e) {
      debugPrint(e.toString());
    }

    return handler.next(err);
  }

  Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    final dio = Dio(BaseOptions(
      baseUrl: requestOptions.baseUrl,
      connectTimeout: requestOptions.connectTimeout,
      receiveTimeout: requestOptions.receiveTimeout,
      responseType: requestOptions.responseType,
    ));
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      contentType: requestOptions.contentType,
      responseType: requestOptions.responseType,
      sendTimeout: requestOptions.sendTimeout,
      receiveTimeout: requestOptions.receiveTimeout,
      extra: requestOptions.extra,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> refreshToken() async {
    try {
      return await Helpers.refreshFirebaseToken() != null;
    } catch (e) {
      return false;
    }
  }

  bool _isPublicRequest(RequestOptions options) {
    return options.path.contains("getPrivacyPolicy") ||
        options.path.contains("getTermsAndConditions") ||
        options.uri.toString().contains("googleapis.com") ||
        options.uri.toString().contains("maps.googleapis.com");
  }

  bool _shouldRefreshToken(DioException err) {
    final statusCode = err.response?.statusCode;
    final message = _errorMessage(err.response?.data).toLowerCase();
    return (statusCode == 400 ||
            statusCode == 401 ||
            statusCode == 403 ||
            statusCode == 500) &&
        (message.contains('firebase') ||
            message.contains('auth token') ||
            message.contains('id-token-expired') ||
            message.contains('unauthorized'));
  }

  String _errorMessage(dynamic data) {
    if (data is Map && data['message'] != null) {
      return data['message'].toString();
    }
    return data?.toString() ?? '';
  }
}

class Helpers {
  static const _tokenRefreshBuffer = Duration(minutes: 5);

  static bool _tokenIsValid() {
    final token = Get.find<GetStorageService>().encjwToken;
    if (token.isEmpty) return false;

    try {
      return JwtDecoder.getRemainingTime(token) > _tokenRefreshBuffer;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> validateToken({required Function() onSuccess}) async {
    final token = await getValidFirebaseToken();
    if (token != null) {
      onSuccess();
      return true;
    }
    handleSessionExpired();
    return false;
  }

  static Future<String?> getValidFirebaseToken() async {
    if (_tokenIsValid()) {
      return Get.find<GetStorageService>().encjwToken;
    }

    return refreshFirebaseToken();
  }

  static Future<String?> refreshFirebaseToken() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final token = await user.getIdToken(true);
    if (token == null || token.isEmpty) return null;

    Get.find<GetStorageService>().encjwToken = token;
    return token;
  }

  static void handleSessionExpired() {
    showMySnackbar(msg: "Session Expired. Please Login Again", title: 'Error');
    Get.find<GetStorageService>().logout();
    Get.offAllNamed(Routes.ONBOARDING);
  }
}
