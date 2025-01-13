// To parse this JSON data, do
//
//     final serviceCenterRegisterDataModel = serviceCenterRegisterDataModelFromJson(jsonString);

import 'dart:convert';

ServiceCenterRegisterDataModel serviceCenterRegisterDataModelFromJson(
        String str) =>
    ServiceCenterRegisterDataModel.fromJson(json.decode(str));

String serviceCenterRegisterDataModelToJson(
        ServiceCenterRegisterDataModel data) =>
    json.encode(data.toJson());

class ServiceCenterRegisterDataModel {
  String? status;
  String? message;

  ServiceCenterRegisterDataModel({
    this.status,
    this.message,
  });

  factory ServiceCenterRegisterDataModel.fromJson(Map<String, dynamic> json) =>
      ServiceCenterRegisterDataModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
