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

          if (response.data['suggestions'] != null) {
            List<dynamic> suggestions = response.data['suggestions'];
            addressName.value = suggestions.map((s) {
              var p = s['placePrediction'];
              // Map new API response to old model to maintain compatibility
              return AutocompleteModelPredictions(
                description: p['text']['text'],
                placeId: p['placeId'],
                structuredFormatting:
                    AutocompleteModelPredictionsStructuredFormatting(
                  mainText: p['structuredFormat']['mainText']['text'],
                  secondaryText: p['structuredFormat']['secondaryText']['text'],
                ),
                terms: [
                  AutocompleteModelPredictionsTerms(
                      value: p['structuredFormat']['mainText']['text'],
                      offset: 0)
                ],
              );
            }).toList();
            print(addressName.value);
          } else {
            // Handle empty suggestions if necessary
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
      if (response.data['location'] != null) {
        final location = response.data['location'];
        lat = location["latitude"];
        long = location["longitude"];
      }
    } catch (e) {
      print(e);
    }
  }
}
