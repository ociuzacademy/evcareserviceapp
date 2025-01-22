// To parse this JSON data, do
//
//     final purchaseHistoryModel = purchaseHistoryModelFromJson(jsonString);

import 'dart:convert';

List<PurchaseHistoryModel> purchaseHistoryModelFromJson(String str) =>
    List<PurchaseHistoryModel>.from(
        json.decode(str).map((x) => PurchaseHistoryModel.fromJson(x)));

String purchaseHistoryModelToJson(List<PurchaseHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PurchaseHistoryModel {
  int? id;
  String? userName;
  String? productName;
  String? unitPrice;
  int? quantity;
  String? price;
  DateTime? date;
  int? user;
  int? product;
  int? serviceCentre;

  PurchaseHistoryModel({
    this.id,
    this.userName,
    this.productName,
    this.unitPrice,
    this.quantity,
    this.price,
    this.date,
    this.user,
    this.product,
    this.serviceCentre,
  });

  factory PurchaseHistoryModel.fromJson(Map<String, dynamic> json) =>
      PurchaseHistoryModel(
        id: json["id"],
        userName: json["user_name"],
        productName: json["product_name"],
        unitPrice: json["unit_price"],
        quantity: json["quantity"],
        price: json["price"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        user: json["user"],
        product: json["product"],
        serviceCentre: json["service_centre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "product_name": productName,
        "unit_price": unitPrice,
        "quantity": quantity,
        "price": price,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "user": user,
        "product": product,
        "service_centre": serviceCentre,
      };
}
