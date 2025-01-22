// To parse this JSON data, do
//
//     final updateProductResponseModel = updateProductResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateProductResponseModel updateProductResponseModelFromJson(String str) =>
    UpdateProductResponseModel.fromJson(json.decode(str));

String updateProductResponseModelToJson(UpdateProductResponseModel data) =>
    json.encode(data.toJson());

class UpdateProductResponseModel {
  String? status;
  String? message;

  UpdateProductResponseModel({
    this.status,
    this.message,
  });

  factory UpdateProductResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateProductResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
