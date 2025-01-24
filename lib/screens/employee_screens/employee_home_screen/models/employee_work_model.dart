// To parse this JSON data, do
//
//     final employeeWorkModel = employeeWorkModelFromJson(jsonString);

import 'dart:convert';

List<EmployeeWorkModel> employeeWorkModelFromJson(String str) =>
    List<EmployeeWorkModel>.from(
        json.decode(str).map((x) => EmployeeWorkModel.fromJson(x)));

String employeeWorkModelToJson(List<EmployeeWorkModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeWorkModel {
  final String userName;
  final String vehicleNum;
  final int id;
  final String status;

  EmployeeWorkModel({
    required this.userName,
    required this.vehicleNum,
    required this.id,
    required this.status,
  });

  factory EmployeeWorkModel.fromJson(Map<String, dynamic> json) =>
      EmployeeWorkModel(
        userName: json["user_name"],
        vehicleNum: json["vehicle_num"],
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "vehicle_num": vehicleNum,
        "id": id,
        "status": status,
      };
}
