// To parse this JSON data, do
//
//     final serviceCentreRegisterDataModel = serviceCentreRegisterDataModelFromJson(jsonString);

import 'dart:convert';

ServiceCentreRegisterDataModel serviceCentreRegisterDataModelFromJson(
        String str) =>
    ServiceCentreRegisterDataModel.fromJson(json.decode(str));

String serviceCentreRegisterDataModelToJson(
        ServiceCentreRegisterDataModel data) =>
    json.encode(data.toJson());

class ServiceCentreRegisterDataModel {
  final String status;
  final String message;

  ServiceCentreRegisterDataModel({
    required this.status,
    required this.message,
  });

  factory ServiceCentreRegisterDataModel.fromJson(Map<String, dynamic> json) =>
      ServiceCentreRegisterDataModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
