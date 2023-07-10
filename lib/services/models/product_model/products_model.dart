import 'dart:convert';

import 'package:e_commerce/services/models/product_model/ratings_model.dart';

// ------------------------------------------------------------------------
// For All Products

List<ProductsModel> productsModelFromJson(dynamic json) {
  if (json is List) {
    return List<ProductsModel>.from(json.map((x) => ProductsModel.fromJson(x)));
  } else if (json is Map) {
    // Handle the case when a single product is returned as a map
    return [ProductsModel.fromJson(Map<String, dynamic>.from(json))];
  } else {
    throw Exception('Invalid JSON format');
  }
}

String productsModelToJson(List<ProductsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// ------------------------------------------------------------
class ProductsModel {
  int? id;
  String title;
  double price;
  String description;
  String category;
  String image;
  RatingsModel? rating;

  ProductsModel({
     this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: json["rating"] == null
            ? null
            : RatingsModel.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating?.toJson(),
      };
}
