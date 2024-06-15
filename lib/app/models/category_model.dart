import 'package:fsauce_vendor_app/app/models/menu_item_model.dart';

class CategoryModel {
  final String id;
  final String name;
  final bool isActive;
  final String vendor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final List<MenuItemModel> menu;

  CategoryModel({
    required this.id,
    required this.name,
    required this.isActive,
    required this.vendor,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.menu,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    // Parse the list of menu items
    List<dynamic> menuItems = json['menu'] ?? [];
    List<MenuItemModel> parsedMenu =
        menuItems.map((item) => MenuItemModel.fromJson(item)).toList();

    return CategoryModel(
      id: json['_id'],
      name: json['name'],
      isActive: json['isActive'],
      vendor: json['vendor'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      menu: parsedMenu,
    );
  }

  Map<String, dynamic> toJson() {
    // Convert the list of menu items to JSON
    List<Map<String, dynamic>> menuJson =
        menu.map((item) => item.toJson()).toList();

    return {
      '_id': id,
      'name': name,
      'isActive': isActive,
      'vendor': vendor,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
      'menu': menuJson,
    };
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    bool? isActive,
    String? vendor,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    List<MenuItemModel>? menu,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      vendor: vendor ?? this.vendor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      menu: menu ?? this.menu,
    );
  }
}
