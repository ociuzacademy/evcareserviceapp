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
  int? id;
  String? image;

  ProductModel({
    this.serviceCentre,
    this.name,
    this.description,
    this.price,
    this.quantity,
    this.id,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        serviceCentre: json["service_centre"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        quantity: json["quantity"],
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "service_centre": serviceCentre,
        "name": name,
        "description": description,
        "price": price,
        "quantity": quantity,
        "id": id,
        "image": image,
      };
}
