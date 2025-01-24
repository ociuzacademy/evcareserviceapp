// To parse this JSON data, do
//
//     final assignEmployeeResponseModel = assignEmployeeResponseModelFromJson(jsonString);

import 'dart:convert';

AssignEmployeeResponseModel assignEmployeeResponseModelFromJson(String str) =>
    AssignEmployeeResponseModel.fromJson(json.decode(str));

String assignEmployeeResponseModelToJson(AssignEmployeeResponseModel data) =>
    json.encode(data.toJson());

class AssignEmployeeResponseModel {
  final String status;
  final String message;

  AssignEmployeeResponseModel({
    required this.status,
    required this.message,
  });

  factory AssignEmployeeResponseModel.fromJson(Map<String, dynamic> json) =>
      AssignEmployeeResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
