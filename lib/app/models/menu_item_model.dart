class MenuItemModel {
  final String id;
  final String name;
  final String image;
  final String category;
  final String vendor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  MenuItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.vendor,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      category: json['category'],
      vendor: json['vendor'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
      'category': category,
      'vendor': vendor,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }

  MenuItemModel copyWith({
    String? id,
    String? name,
    String? image,
    String? category,
    String? vendor,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return MenuItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      category: category ?? this.category,
      vendor: vendor ?? this.vendor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }
}
