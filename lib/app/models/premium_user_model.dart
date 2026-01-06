import 'dart:convert';

class PremiumUserModel {
  final List<Result>? results;
  final int? page;
  final int? limit;
  final int? totalPages;

  PremiumUserModel({
    this.results,
    this.page,
    this.limit,
    this.totalPages,
  });

  PremiumUserModel copyWith({
    List<Result>? results,
    int? page,
    int? limit,
    int? totalPages,
  }) =>
      PremiumUserModel(
        results: results ?? this.results,
        page: page ?? this.page,
        limit: limit ?? this.limit,
        totalPages: totalPages ?? this.totalPages,
      );

  factory PremiumUserModel.fromRawJson(String str) =>
      PremiumUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PremiumUserModel.fromJson(Map<String, dynamic> json) =>
      PremiumUserModel(
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
      };
}

class Result {
  final String? id;
  final String? name;
  final String? profilePic;

  Result({
    this.id,
    this.name,
    this.profilePic,
  });

  Result copyWith({
    String? id,
    String? name,
    String? profilePic,
  }) =>
      Result(
        id: id ?? this.id,
        name: name ?? this.name,
        profilePic: profilePic ?? this.profilePic,
      );

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        name: json["name"],
        profilePic: json["profilePic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "profilePic": profilePic,
      };
}
