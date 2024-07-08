class CuisineModel{
  String? id;
  String? name;

  CuisineModel({
    required this.id,
    required this.name,
  });

  factory CuisineModel.fromJson(Map<String, dynamic> json){
    return CuisineModel(id: json['_id'], name: json['name']);
  }

  Map<String, dynamic> toJson(){
    return {
      '_id': id,
      'name': name,
    };
  }
}