// To parse this JSON data, do
//
//     final addProductResponseModel = addProductResponseModelFromJson(jsonString);

import 'dart:convert';

AddProductResponseModel addProductResponseModelFromJson(String str) =>
    AddProductResponseModel.fromJson(json.decode(str));

String addProductResponseModelToJson(AddProductResponseModel data) =>
    json.encode(data.toJson());

class AddProductResponseModel {
  String? status;
  String? message;

  AddProductResponseModel({
    this.status,
    this.message,
  });

  factory AddProductResponseModel.fromJson(Map<String, dynamic> json) =>
      AddProductResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
