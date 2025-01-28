// To parse this JSON data, do
//
//     final employeeAttendanceResponseModel = employeeAttendanceResponseModelFromJson(jsonString);

import 'dart:convert';

EmployeeAttendanceResponseModel employeeAttendanceResponseModelFromJson(
        String str) =>
    EmployeeAttendanceResponseModel.fromJson(json.decode(str));

String employeeAttendanceResponseModelToJson(
        EmployeeAttendanceResponseModel data) =>
    json.encode(data.toJson());

class EmployeeAttendanceResponseModel {
  final String status;
  final String message;

  EmployeeAttendanceResponseModel({
    required this.status,
    required this.message,
  });

  factory EmployeeAttendanceResponseModel.fromJson(Map<String, dynamic> json) =>
      EmployeeAttendanceResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
