// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromJson(jsonString);

import 'dart:convert';

List<EmployeeModel> employeeModelFromJson(String str) =>
    List<EmployeeModel>.from(
        json.decode(str).map((x) => EmployeeModel.fromJson(x)));

String employeeModelToJson(List<EmployeeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phoneNumber;
  final int serviceCentre;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.serviceCentre,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        serviceCentre: json["service_centre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "service_centre": serviceCentre,
      };
}
