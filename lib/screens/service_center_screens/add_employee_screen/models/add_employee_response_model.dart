// To parse this JSON data, do
//
//     final addEmployeeResponseModel = addEmployeeResponseModelFromJson(jsonString);

import 'dart:convert';

AddEmployeeResponseModel addEmployeeResponseModelFromJson(String str) =>
    AddEmployeeResponseModel.fromJson(json.decode(str));

String addEmployeeResponseModelToJson(AddEmployeeResponseModel data) =>
    json.encode(data.toJson());

class AddEmployeeResponseModel {
  String? status;
  String? message;

  AddEmployeeResponseModel({
    this.status,
    this.message,
  });

  factory AddEmployeeResponseModel.fromJson(Map<String, dynamic> json) =>
      AddEmployeeResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
