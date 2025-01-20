// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  int? serviceCentre;
  String? name;
  String? description;
  String? price;
  String? quantity;
  String? imagePath;
  int? id;

  ProductModel({
    this.serviceCentre,
    this.name,
    this.description,
    this.price,
    this.quantity,
    this.imagePath,
    this.id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        serviceCentre: json["service_centre"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        quantity: json["quantity"],
        imagePath: json["image_path"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "service_centre": serviceCentre,
        "name": name,
        "description": description,
        "price": price,
        "quantity": quantity,
        "image_path": imagePath,
        "id": id,
      };
}
