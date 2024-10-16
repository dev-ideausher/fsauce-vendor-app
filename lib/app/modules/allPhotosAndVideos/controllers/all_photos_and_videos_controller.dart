import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/modules/profileDetails/controllers/profile_details_controller.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:video_player/video_player.dart';

class AllPhotosAndVideosController extends GetxController {
  //TODO: Implement AllPhotosAndVideosController

  @override
  void onInit() {
    getRestaurantUploads();
    super.onInit();
  }

  RxList<String> selectedFiles = <String>[].obs;
  List<String> uploadedFilesUrl = [];
  RxList<String> restaurantUploads = <String>[].obs;

  void getRestaurantUploads(){
    Get.find<HomeController>().getRestaurantDetails();
    restaurantUploads.value = Get.find<HomeController>().restaurantDetails.value.media;
  }

  bool isImage(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType!.startsWith('image/');
  }

  void confirmDeleteImage(int index){
    String id = Get.find<HomeController>().vendor;
    Get.dialog(
      ConfrimationDialog(
        onNoTap: Get.back,
        onYesTap: () async {
          try {
            var response = await APIManager.deleteMedia(restaurantUploads[index], id);
            if (response["status"]) {
              getRestaurantUploads();
              restaurantUploads.remove(restaurantUploads[index]);
              DialogHelper.showSuccess("Deleted Successfully!");
            }
          } catch (e) {
            Get.snackbar("Error","Something went wrong!");
          }
        },
        subTitle: StringConstant.deleteMediaSub,
        title: StringConstant.deleteMedia,
      ),
    );
  }

  Future<void> pickMultipleFiles() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultipleMedia();

    if (pickedFiles != null) {
      for(XFile file in pickedFiles){
        selectedFiles.add(file.path);
      }
    }
  }

  Future<void> uploadAllImagesAndVideos() async{
    if(selectedFiles.isNotEmpty){
      for(int index = 0; index < selectedFiles.length; index++){
        var response = await APIManager.uploadFile(filePath: selectedFiles[index]);
        if(!response.data['status']){
          Get.snackbar("Error", StringConstant.imageUploadError);
        } else if(response.data['status']){
          uploadedFilesUrl.add(response.data['data']);
        }
      }
      saveAllImagesAndVideos();
    } else if(selectedFiles.isEmpty){
      Get.snackbar("Error", StringConstant.noFilesSelected);
    }
  }

  Future<void> saveAllImagesAndVideos() async{
    RestaurantDetails details = Get.find<HomeController>().restaurantDetails.value;
    if(uploadedFilesUrl.isNotEmpty){
      var response = await APIManager.updateVendor(
          restaurantDetails: RestaurantDetails(
            restaurantName: details.restaurantName,
            restaurantLogo: details.restaurantLogo,
            restaurantBanner: details.restaurantBanner,
            location: details.location,
            avgPrice: details.avgPrice,
            description: details.description,
            features: details.features,
            timing: details.timing,
            lat: details.lat,
            lon: details.lon,
            stripeCardId: details.stripeCardId ?? "",
            stripeCustomerId: details.stripeCustomerId ?? "",
            media: List.from(uploadedFilesUrl)..addAll(details.media),
            cuisine: details.cuisine
          )
      );
      if(response.data["status"]){
        Get.back();
        Get.bottomSheet(const AddedSuccessfullBottomSheet(subTitle: StringConstant.imagesAndVideosSavedSuccessfully));
        selectedFiles.clear();
        Get.find<HomeController>().getRestaurantDetails();
      }
      else if(!response.data["status"]){
        Get.snackbar("Error", StringConstant.anErrorOccurred);
      }
    } else{
      Get.snackbar("Error", StringConstant.uploadAllImagesError);
    }
  }
}
