class FeatureModel{
  String? id;
  String? name;

  FeatureModel({
    required this.id,
    required this.name,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json){
    return FeatureModel(id: json['_id'], name: json['name']);
  }

  Map<String, dynamic> toJson(){
    return {
      '_id': id,
      'name': name,
    };
  }
}