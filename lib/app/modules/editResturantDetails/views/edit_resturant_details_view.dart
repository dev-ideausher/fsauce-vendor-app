import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import '../../../models/cuisine_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/edit_resturant_details_controller.dart';

class EditResturantDetailsView extends GetView<EditResturantDetailsController> {
  const EditResturantDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: StringConstant.restaurantDetails,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.kw),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.kheightBox,
                  Row(
                    children: [
                      Text(
                        StringConstant.restaurantName,
                        style: TextStyleUtil.manrope14w500(),
                      ),
                      Text(
                        "*",
                        style: TextStyleUtil.manrope14w500(
                            color: context.primary01),
                      )
                    ],
                  ),
                  6.kheightBox,
                  CustomTextField(
                      validator: (String? val) {
                        if (val == null || val.isEmpty) {
                          return StringConstant.restaurantNameCannotBeEmpty;
                        }
                        return null;
                      },
                      controller: controller.restaurantNameController,
                      fillColor: context.loginSignupTextfieldColor,
                      border: Border.all(color: context.black07),
                      hintText: StringConstant.enterRestaurantName),
                  20.kheightBox,
                  Row(
                    children: [
                      Text(
                        StringConstant.restaurantLogo,
                        style: TextStyleUtil.manrope14w500(),
                      ),
                      Text(
                        "*",
                        style: TextStyleUtil.manrope14w500(
                            color: context.primary01),
                      )
                    ],
                  ),
                  Text(
                    StringConstant.pngJpgJpeg,
                    style: TextStyleUtil.manrope14w500(color: context.black03),
                  ),
                  6.kheightBox,
                  Obx(() {
                    if (controller.selectedLogoImage.isNotEmpty) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12.kw),
                        child: Image.file(
                          width: double.infinity,
                          height: 100.kh,
                          File(controller.selectedLogoImage.value),
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  6.kheightBox,
                  Obx(() {
                    if (Get.find<HomeController>()
                            .restaurantDetails
                            .value
                            .restaurantLogo
                            .isNotEmpty &&
                        controller.selectedLogoImage.isEmpty) {
                      return Column(
                        children: <Widget>[
                          6.kheightBox,
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.kw),
                            child: CommonImageView(
                              url: Get.find<HomeController>()
                                  .restaurantDetails
                                  .value
                                  .restaurantLogo,
                              height: 150.kh,
                              width: 150.kh,
                              fit: BoxFit.cover,
                            ),
                          ),
                          6.kheightBox,
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  Obx(() {
                    if (Get.find<HomeController>()
                        .restaurantDetails
                        .value
                        .restaurantLogo
                        .isEmpty) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(12.kw),
                        onTap: () {
                          controller.pickLogo();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 100.kh,
                          decoration: BoxDecoration(
                            color: context.loginSignupTextfieldColor,
                            borderRadius: BorderRadius.circular(12.kw),
                            border: RDottedLineBorder.all(
                              color: context.black07,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.file_upload_outlined),
                              10.kheightBox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    StringConstant.uploadFile,
                                    style: TextStyleUtil.manrope14w500(
                                        color: context.primary01),
                                  ),
                                  4.kwidthBox,
                                  Text(
                                    StringConstant.or,
                                    style: TextStyleUtil.manrope14w500(
                                        color: context.black04),
                                  ),
                                  4.kwidthBox,
                                  Text(
                                    StringConstant.selectFile,
                                    style: TextStyleUtil.manrope14w500(
                                        color: context.primary01),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: controller.pickLogo,
                          style: TextButton.styleFrom(
                            foregroundColor: context.primary01,
                            padding: EdgeInsets.symmetric(vertical: 4.kh),
                          ),
                          icon: const Icon(Icons.edit_outlined, size: 20),
                          label: Text(
                            StringConstant.edit,
                            style: TextStyleUtil.manrope14w600(
                              color: context.primary01,
                            ),
                          ),
                        ),
                      );
                    }
                  }),
                  10.kheightBox,
                  Row(
                    children: [
                      Text(
                        StringConstant.restaurantBannerImage,
                        style: TextStyleUtil.manrope14w500(),
                      ),
                      Text(
                        "*",
                        style: TextStyleUtil.manrope14w500(
                            color: context.primary01),
                      )
                    ],
                  ),
                  6.kheightBox,
                  Obx(() {
                    if (controller.selectedBannerImage.isNotEmpty) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12.kw),
                        child: Image.file(
                          height: 160.kh,
                          width: double.infinity,
                          File(controller.selectedBannerImage.value),
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  6.kheightBox,
                  Obx(() {
                    if (Get.find<HomeController>()
                            .restaurantDetails
                            .value
                            .restaurantBanner
                            .isNotEmpty &&
                        controller.selectedBannerImage.isEmpty) {
                      return Column(
                        children: <Widget>[
                          6.kheightBox,
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.kw),
                            child: CommonImageView(
                              url: Get.find<HomeController>()
                                  .restaurantDetails
                                  .value
                                  .restaurantBanner,
                              height: 160.kh,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          6.kheightBox,
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  Obx(() {
                    if (Get.find<HomeController>()
                        .restaurantDetails
                        .value
                        .restaurantBanner
                        .isEmpty) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(12.kw),
                        onTap: () {
                          controller.pickBanner();
                        },
                        child: Container(
                          height: 160.kh,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: context.black07),
                            borderRadius: BorderRadius.circular(12.kw),
                            color: context.loginSignupTextfieldColor,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.panorama_outlined, size: 22),
                                6.kwidthBox,
                                Text(
                                  StringConstant.uploadPhoto,
                                  style: TextStyleUtil.manrope14w500(
                                    color: context.black03,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: controller.pickBanner,
                          style: TextButton.styleFrom(
                            foregroundColor: context.primary01,
                            padding: EdgeInsets.symmetric(vertical: 4.kh),
                          ),
                          icon: const Icon(Icons.edit_outlined, size: 20),
                          label: Text(
                            StringConstant.edit,
                            style: TextStyleUtil.manrope14w600(
                              color: context.primary01,
                            ),
                          ),
                        ),
                      );
                    }
                  }),
                  20.kheightBox,
                  Row(
                    children: [
                      Text(
                        StringConstant.address,
                        style: TextStyleUtil.manrope14w500(),
                      ),
                      Text(
                        "*",
                        style: TextStyleUtil.manrope14w500(
                            color: context.primary01),
                      )
                    ],
                  ),
                  10.kheightBox,
                  InkWell(
                    onTap: () => Get.toNamed(Routes.LOCATION_SEARCH,
                            arguments: "latLong")!
                        .then((value) {
                      if (value != null) {
                        final List<String> addressWithLatLong = value;
                        final lat =
                            double.tryParse(addressWithLatLong.first) ?? 0.0;
                        final long =
                            double.tryParse(addressWithLatLong[1]) ?? 0.0;
                        final address = addressWithLatLong.length > 2
                            ? addressWithLatLong[2]
                            : "";

                        controller.moveToNewLatLng(lat, long, address: address);

                        //getEventList("city=" + currentAddress.value);
                      }
                    }),
                    child: Obx(() {
                      // Update controller text from observable
                      if (controller.addressText.value !=
                          controller.addressController.text) {
                        controller.addressController.text =
                            controller.addressText.value;
                      }
                      return CustomTextField(
                          enabled: false,
                          validator: (String? val) {
                            if (val == null || val.isEmpty) {
                              return StringConstant
                                  .restaurantAddressCannotBeEmpty;
                            }
                            return null;
                          },
                          controller: controller.addressController,
                          fillColor: context.loginSignupTextfieldColor,
                          border: Border.all(color: context.black07),
                          hintText: StringConstant.enterAddress);
                    }),
                  ),
                  10.kheightBox,
                  Text(StringConstant.dropAPinToLinkYourAddress,
                      style: TextStyleUtil.manrope14w500()),
                  8.kheightBox,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.kh),
                    child: Container(
                      color: Colors.white,
                      height: 220.kh,
                      width: 100.w,
                      child: MapPicker(
                          iconWidget: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 30,
                          ),
                          mapPickerController: controller.mapPickerController,
                          // child: GoogleMap(
                          //   gestureRecognizers: {
                          //     Factory<OneSequenceGestureRecognizer>(
                          //       () => EagerGestureRecognizer(),
                          //     ),
                          //   },
                          //   zoomControlsEnabled: false,
                          //   initialCameraPosition: controller.cameraPosition,
                          //   onMapCreated: (map) => controller.mapController = map,
                          //   onCameraIdle: () async {
                          //     debugPrint(
                          //         "🗺️ Camera idle - starting address update");
                          //     controller.mapPickerController.mapFinishedMoving!();

                          //     await controller.updateDragLocation();
                          //     debugPrint("🗺️ Address update completed");
                          //   },
                          //   onCameraMove: (cameraPosition1) {
                          //     debugPrint(
                          //         "🗺️ Camera moving to: ${cameraPosition1.target.latitude}, ${cameraPosition1.target.longitude}");
                          //     this.controller.cameraPosition = cameraPosition1;
                          //   },
                          //   mapType: MapType.normal,
                          //   myLocationButtonEnabled: false,
                          // ),
                          child: GoogleMap(
                            zoomControlsEnabled: false,
                            initialCameraPosition: controller.cameraPosition,
                            onMapCreated: (map) {
                              controller.mapController = map;

                              if (controller.resturLat.value != 0.0) {
                                map.animateCamera(
                                  CameraUpdate.newLatLngZoom(
                                    LatLng(
                                      controller.resturLat.value,
                                      controller.resturLong.value,
                                    ),
                                    14.5,
                                  ),
                                );
                              }
                            },
                            onCameraMove: (pos) {
                              controller.cameraPosition = pos;
                            },
                            onCameraIdle: () async {
                              controller
                                  .mapPickerController.mapFinishedMoving!();
                              await controller.updateDragLocation();
                            },
                          )),
                    ),
                  ),
                  20.kheightBox,
                  Row(
                    children: [
                      Text(
                        StringConstant.avgPriceFor2,
                        style: TextStyleUtil.manrope14w500(),
                      ),
                      Text(
                        "*",
                        style: TextStyleUtil.manrope14w500(
                            color: context.primary01),
                      )
                    ],
                  ),
                  10.kheightBox,
                  CustomTextField(
                      validator: (String? val) {
                        if (val == null || val.isEmpty) {
                          return StringConstant.restaurantPriceCannotBeEmpty;
                        }
                        return null;
                      },
                      controller: controller.averagePriceController,
                      fillColor: context.loginSignupTextfieldColor,
                      border: Border.all(color: context.black07),
                      hintText: StringConstant.enterPrice),
                  20.kheightBox,
                  Text(
                    StringConstant.description,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  10.kheightBox,
                  CustomTextField(
                      controller: controller.descriptionController,
                      fillColor: context.loginSignupTextfieldColor,
                      border: Border.all(color: context.black07),
                      hintText: StringConstant.enterDescription),
                  20.kheightBox,
                  Divider(height: 1, thickness: 1, color: context.borderColor1),
                  20.kheightBox,
                  _cuisineBlock(context, controller),
                  32.kheightBox,
                  SafeArea(
                    child: CustomRedElevatedButton(
                        buttonText: StringConstant.save,
                        height: 56.kh,
                        width: double.infinity,
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.updateDetails();
                          }
                        }),
                  ),
                  40.kheightBox,
                ],
              ),
            ),
          ),
        ));
  }
}

Widget _cuisineBlock(
  BuildContext context,
  EditResturantDetailsController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(Icons.restaurant_menu_outlined, size: 20, color: context.primary01),
          6.kwidthBox,
          Text(
            StringConstant.cuisine,
            style: TextStyleUtil.manrope14w500(),
          ),
          Text(
            "*",
            style: TextStyleUtil.manrope14w500(color: context.primary01),
          ),
        ],
      ),
      6.kheightBox,
      Text(
        StringConstant.cuisineSelectionHint,
        style: TextStyleUtil.manrope12w400(color: context.black03)
            .copyWith(height: 1.4),
      ),
      12.kheightBox,
      Obx(() {
        if (controller.multiSelectCuisineItems.isEmpty) {
          return _cuisineLoadingPlaceholder(context);
        }
        final h = MediaQuery.sizeOf(context).height;
        return Container(
          key: ValueKey(
            controller.initialCuisineModels
                .map((CuisineModel e) => e.id ?? '')
                .join(','),
          ),
          padding: EdgeInsets.fromLTRB(4.kh, 2.kh, 4.kh, 10.kh),
          decoration: BoxDecoration(
            color: context.loginSignupTextfieldColor,
            borderRadius: BorderRadius.circular(12.kw),
            border: Border.all(color: context.borderColor1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: MultiSelectDialogField<CuisineModel>(
            listType: MultiSelectListType.LIST,
            searchable: true,
            searchHint: StringConstant.searchCuisines,
            separateSelectedItems: false,
            searchIcon: const Icon(Icons.search, size: 22),
            closeSearchIcon: const Icon(Icons.close, size: 20),
            dialogHeight: (h * 0.52).clamp(320.0, 520.0),
            backgroundColor: context.white,
            barrierColor: Colors.black26,
            initialValue: List<CuisineModel>.from(
              controller.initialCuisineModels,
            ),
            validator: (List<CuisineModel>? c) {
              if (c == null || c.isEmpty) {
                return StringConstant.restaurantCuisineCannotBeEmpty;
              }
              return null;
            },
            items: controller.multiSelectCuisineItems,
            title: Text(
              StringConstant.selectCuisine,
              style: TextStyleUtil.manrope18w600(color: context.black01),
            ),
            selectedColor: context.primary01,
            unselectedColor: context.black04.withValues(alpha: 0.4),
            checkColor: context.white,
            itemsTextStyle: TextStyleUtil.manrope14w400(color: context.black01),
            selectedItemsTextStyle:
                TextStyleUtil.manrope14w500(color: context.black01),
            searchTextStyle: TextStyleUtil.manrope14w400(),
            searchHintStyle: TextStyleUtil.manrope14w400(color: context.black04),
            chipDisplay: MultiSelectChipDisplay(
              height: 40.kh,
              scroll: true,
              icon: Icon(Icons.check_rounded, size: 18, color: context.primary01),
              textStyle: TextStyleUtil.manrope12w600(color: context.primary01),
              chipColor: context.primary07,
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: context.primary01.withValues(alpha: 0.2),
                ),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.kw),
            ),
            buttonIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 24,
              color: context.primary01,
            ),
            buttonText: Text(
              controller.initialCuisineModels.isEmpty
                  ? StringConstant.selectCuisine
                  : '${controller.initialCuisineModels.length} ${StringConstant.selectedCountSuffix}',
              style: TextStyleUtil.manrope14w500(
                color: controller.initialCuisineModels.isEmpty
                    ? context.black04
                    : context.black01,
              ),
            ),
            confirmText: Text(
              StringConstant.done,
              style: TextStyleUtil.manrope16w600(color: context.primary01),
            ),
            cancelText: Text(
              StringConstant.cancel,
              style: TextStyleUtil.manrope16w500(color: context.black03),
            ),
            onConfirm: (List<CuisineModel> results) {
              controller.initialCuisineModels.value = results;
            },
          ),
        );
      }),
    ],
  );
}

/// Shown while cuisine options are being fetched.
Widget _cuisineLoadingPlaceholder(BuildContext context) {
  return Container(
    height: 56.kh,
    padding: EdgeInsets.symmetric(horizontal: 16.kw),
    decoration: BoxDecoration(
      color: context.loginSignupTextfieldColor,
      borderRadius: BorderRadius.circular(12.kw),
      border: Border.all(color: context.borderColor1),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.2,
            color: context.primary01,
          ),
        ),
        14.kwidthBox,
        Expanded(
          child: Text(
            StringConstant.loadingCuisines,
            style: TextStyleUtil.manrope14w500(color: context.black03),
          ),
        ),
      ],
    ),
  );
}
