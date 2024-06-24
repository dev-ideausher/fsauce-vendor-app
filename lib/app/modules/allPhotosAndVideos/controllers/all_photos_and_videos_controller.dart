import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/restaurants_details_model.dart';
import 'package:fsauce_vendor_app/app/modules/profileDetails/controllers/profile_details_controller.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class AllPhotosAndVideosController extends GetxController {
  //TODO: Implement AllPhotosAndVideosController

  @override
  void onInit() {
    getRestaurantUploads();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  RxList<String> selectedFiles = <String>[].obs;
  List<String> uploadedFilesUrl = [];
  RxList<String> restaurantUploads = <String>[].obs;

  void getRestaurantUploads(){
    Get.find<ProfileDetailsController>().getRestaurantDetails();
    restaurantUploads.value = Get.find<ProfileDetailsController>().restaurantDetails.value.media;
    print("Here are the photos of the restaurant: ${restaurantUploads.length}");
  }

  Future<void> pickMultipleFiles() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      print("picked file: ${pickedFiles.first.path}");
      for(XFile file in pickedFiles){
        selectedFiles.add(file.path);
      }
    }
  }

  Future<void> uploadAllImagesAndVideos() async{
    print("Trying to upload images and videos");
    if(selectedFiles.isNotEmpty){
      for(String selectedImage in selectedFiles){
        var response = await APIManager.uploadFile(filePath: selectedImage);
        if(!response.data['status']){
          DialogHelper.showError('Image upload error!');
        } else if(response.data['status']){
          uploadedFilesUrl.add(response.data);
        }
      }
      saveAllImagesAndVideos();
    } else if(selectedFiles.isEmpty){
      DialogHelper.showError(StringConstant.noFilesSelected);
    }
  }

  Future<void> saveAllImagesAndVideos() async{
    print("Trying to save images and videos");
    RestaurantDetails details = Get.find<ProfileDetailsController>().restaurantDetails.value;
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
            media: [uploadedFilesUrl.first],
          )
      );
      if(response.data["status"]){
        Get.find<ProfileDetailsController>().getRestaurantDetails();
        Get.bottomSheet(const AddedSuccessfullBottomSheet(subTitle: StringConstant.imagesAndVideosSavedSuccessfully));
        selectedFiles.clear();
      }
      else if(!response.data["status"]){
        DialogHelper.showError(StringConstant.anErrorOccurred);
      }
    } else{
      DialogHelper.showError(StringConstant.uploadAllImagesError);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
