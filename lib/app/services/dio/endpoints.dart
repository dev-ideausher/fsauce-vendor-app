class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://184.72.90.51:8000/v1/";

  //endpoints
  static const String onboardVendor = "vendor/onboarding";
  static const String fileUpload = "user/uploadFile";
  static const String updateVendor = "vendor/updateVendor";
  static const String addCategory = "vendor/menu/addCategory";
  static const String getCategory = "vendor/menu/getCategory";
  static const String deleteCategory = "vendor/menu/deleteCategory";
  static const String editCategory = "vendor/menu/editCategory";
  static const String addMenuItem = "vendor/menu/addMenu";
  static const String deleteMenuItem = "vendor/menu/deleteMenu";
  static const String editMenuItem = "vendor/menu/editMenu";
  static const String addJob = "vendor/job/addJob";
  static const String getJobs = "vendor/job/getJobList";
  static const String deleteJob = "vendor/job/deleteJob";
  static const String editJob = "vendor/job/editJob";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;
}
