class CuisineModel{
  String? id;
  String? name;
  String? image;

  CuisineModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CuisineModel.fromJson(Map<String, dynamic> json){
    return CuisineModel(id: json['_id'], name: json['name'], image: json['image']);
  }

  Map<String, dynamic> toJson(){
    return {
      '_id': id,
      'name': name,
      'image': image,
    };
  }
}