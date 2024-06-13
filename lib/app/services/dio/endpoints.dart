class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://184.72.90.51:8000/v1/";

  //endpoints
  static const String onboardVendor = "vendor/onboarding";
  static const String fileUpload = "user/uploadFile";
  static const String updateVendor = "vendor/updateVendor";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;
}
