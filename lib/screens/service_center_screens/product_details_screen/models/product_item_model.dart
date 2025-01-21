// To parse this JSON data, do
//
//     final productItemModel = productItemModelFromJson(jsonString);

import 'dart:convert';

ProductItemModel productItemModelFromJson(String str) =>
    ProductItemModel.fromJson(json.decode(str));

String productItemModelToJson(ProductItemModel data) =>
    json.encode(data.toJson());

class ProductItemModel {
  int? id;
  String? name;
  String? description;
  String? price;
  String? quantity;
  String? image;
  int? serviceCentre;

  ProductItemModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.quantity,
    this.image,
    this.serviceCentre,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) =>
      ProductItemModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        quantity: json["quantity"],
        image: json["image"],
        serviceCentre: json["service_centre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "quantity": quantity,
        "image": image,
        "service_centre": serviceCentre,
      };
}
