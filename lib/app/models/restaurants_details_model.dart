class RestaurantDetails {
  String restaurantName;
  String restaurantLogo;
  String restaurantBanner;
  String location;
  int avgPrice;
  String description;
  List<String> features;
  List<Timing> timing;
  List<String> media;

  RestaurantDetails({
    required this.restaurantName,
    required this.restaurantLogo,
    required this.restaurantBanner,
    required this.location,
    required this.avgPrice,
    required this.description,
    required this.features,
    required this.timing,
    required this.media,
  });

  RestaurantDetails.fromJson(Map<String, dynamic> json)
      : restaurantName = json['restaurantName'],
        restaurantLogo = json['restaurantLogo'],
        restaurantBanner = json['restaurantBanner'],
        location = json['location'],
        avgPrice = json['avgPrice'],
        description = json['description'],
        features =
            json['features'] != null ? List<String>.from(json['features']) : [],
        timing = json['timing'] != null
            ? (json['timing'] as List)
                .map((timingJson) => Timing.fromJson(timingJson))
                .toList()
            : [],
        media = json['media'] != null ? List<String>.from(json['media']) : [];

  Map<String, dynamic> toJson() => {
        'restaurantName': restaurantName,
        'restaurantLogo': restaurantLogo,
        'restaurantBanner': restaurantBanner,
        'location': location,
        'avgPrice': avgPrice,
        'description': description,
        'features': features,
        'timing': timing.map((timing) => timing.toJson()).toList(),
        'media': media,
      };

  RestaurantDetails copyWith({
    String? restaurantName,
    String? restaurantLogo,
    String? restaurantBanner,
    String? location,
    int? avgPrice,
    String? description,
    List<String>? features,
    List<Timing>? timing,
    List<String>? media,
  }) =>
      RestaurantDetails(
        restaurantName: restaurantName ?? this.restaurantName,
        restaurantLogo: restaurantLogo ?? this.restaurantLogo,
        restaurantBanner: restaurantBanner ?? this.restaurantBanner,
        location: location ?? this.location,
        avgPrice: avgPrice ?? this.avgPrice,
        description: description ?? this.description,
        features: features ?? this.features,
        timing: timing ?? this.timing,
        media: media ?? this.media,
      );
}

class Timing {
  String day;
  String startTime;
  String closeTime;
  bool isActive;

  Timing({
    required this.day,
    required this.startTime,
    required this.closeTime,
    required this.isActive,
  });

  Timing.fromJson(Map<String, dynamic> json)
      : day = json['day'],
        startTime = json['startTime'],
        closeTime = json['closeTime'],
        isActive = json['isActive'];

  Map<String, dynamic> toJson() => {
        'day': day,
        'startTime': startTime,
        'closeTime': closeTime,
        'isActive': isActive,
      };
}
