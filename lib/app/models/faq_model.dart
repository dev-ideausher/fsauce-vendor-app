class FaqModel {
  String? sId;
  String? title;
  String? solution;
  String? userType;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FaqModel(
      {this.sId,
      this.title,
      this.solution,
      this.userType,
      this.createdAt,
      this.updatedAt,
      this.iV});

  FaqModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    solution = json['solution'];
    userType = json['userType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['solution'] = solution;
    data['userType'] = userType;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
