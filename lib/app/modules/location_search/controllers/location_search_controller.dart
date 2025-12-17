import 'dart:async';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import '../../../models/autocomplete_model_predictions.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../../services/uuid.dart';

class LocationSearchController extends GetxController {
  var isLoading = false.obs;
  var addressName = <AutocompleteModelPredictions>[].obs;
  bool isAll = false;
  late Timer? debounce = Timer(const Duration(milliseconds: 300), () {});
  String dataReceived = "";
  List<String> addressWithLatLong = [];
  double lat = 0.0;
  double long = 0.0;

  @override
  void onInit() {
    super.onInit();
    dataReceived = Get.arguments;
  }

  getApiGoogle(String input) async {
    if (input.isNotEmpty) {
      if (debounce?.isActive ?? false) debounce!.cancel();
      debounce = Timer(const Duration(milliseconds: 300), () async {
        isLoading.value = true;
        addressName.clear();

        final sessionToken = Uuid().generateV4();
        try {
          final apiKey = Platform.isAndroid
              ? dotenv.env['MAP_ID_ANDROID'] ?? ""
              : dotenv.env['MAP_ID_IOS'] ?? "";

          final response = await APIManager.googlePlacesAutocomplete(
              input, apiKey, sessionToken);

          if (response.data['predictions'] != null) {
            List<dynamic> predictions = response.data['predictions'];
            addressName.value = predictions.map((p) {
              return AutocompleteModelPredictions(
                description: p['description'],
                placeId: p['place_id'],
                structuredFormatting:
                    AutocompleteModelPredictionsStructuredFormatting(
                  mainText: p['structured_formatting']['main_text'],
                  secondaryText: p['structured_formatting']['secondary_text'],
                ),
                terms: (p['terms'] as List<dynamic>)
                    .map((t) => AutocompleteModelPredictionsTerms(
                        value: t['value'], offset: t['offset']))
                    .toList(),
              );
            }).toList();
            print(addressName.value);
          } else {
            // Handle empty predictions if necessary
          }
        } catch (e) {
          print(e);
          showMySnackbar(msg: "Failed to fetch locations");
        }
        isLoading.value = false;
      });
    }
  }

  Future<void> getCityName(
      AutocompleteModelPredictions autocompleteModelPredictions) async {
    await getLatLong(autocompleteModelPredictions.placeId!);
    var locationString = "";
    if (isAll) {
      locationString = autocompleteModelPredictions.description ?? "";
    } else {
      locationString = autocompleteModelPredictions.terms![0]!.value.toString();
    }
    if (dataReceived == "latLong") {
      addressWithLatLong.add(lat.toString());
      addressWithLatLong.add(long.toString());
      addressWithLatLong.add(autocompleteModelPredictions.description ?? "");
      Get.back(result: addressWithLatLong);
    } else {
      Get.back(result: locationString);
    }
  }

  Future<String> getFormattedAddress(double lat, double long) async {
    String formatted_address = "";
    List<Placemark> placemark = await placemarkFromCoordinates(lat, long);
    Placemark place = placemark[0];
    formatted_address = "${place.locality}";
    return formatted_address;
  }

  getLatLong(String placeId) async {
    try {
      final apiKey = Platform.isAndroid
          ? dotenv.env['MAP_ID_ANDROID'] ?? ""
          : dotenv.env['MAP_ID_IOS'] ?? "";

      final response = await APIManager.googlePlaceDetails(placeId, apiKey);
      if (response.data['result'] != null && 
          response.data['result']['geometry'] != null) {
        final location = response.data['result']['geometry']['location'];
        lat = location["lat"];
        long = location["lng"];
      }
    } catch (e) {
      print(e);
    }
  }
}
