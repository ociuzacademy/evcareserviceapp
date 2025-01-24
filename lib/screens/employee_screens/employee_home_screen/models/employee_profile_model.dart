// To parse this JSON data, do
//
//     final employeeProfileModel = employeeProfileModelFromJson(jsonString);

import 'dart:convert';

EmployeeProfileModel employeeProfileModelFromJson(String str) =>
    EmployeeProfileModel.fromJson(json.decode(str));

String employeeProfileModelToJson(EmployeeProfileModel data) =>
    json.encode(data.toJson());

class EmployeeProfileModel {
  final int id;
  final String username;
  final String name;
  final String email;
  final String phoneNumber;
  final String serviceName;

  EmployeeProfileModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.serviceName,
  });

  factory EmployeeProfileModel.fromJson(Map<String, dynamic> json) =>
      EmployeeProfileModel(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        serviceName: json["service_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "service_name": serviceName,
      };
}
