class FeatureModel{
  String? id;
  String? name;

  FeatureModel({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FeatureModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

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