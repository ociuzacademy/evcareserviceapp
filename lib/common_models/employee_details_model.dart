// To parse this JSON data, do
//
//     final employeeDetailsModel = employeeDetailsModelFromJson(jsonString);

import 'dart:convert';

List<EmployeeDetailsModel> employeeDetailsModelFromJson(String str) =>
    List<EmployeeDetailsModel>.from(
        json.decode(str).map((x) => EmployeeDetailsModel.fromJson(x)));

String employeeDetailsModelToJson(List<EmployeeDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeDetailsModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phoneNumber;
  final int serviceCentre;

  EmployeeDetailsModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.serviceCentre,
  });

  factory EmployeeDetailsModel.fromJson(Map<String, dynamic> json) =>
      EmployeeDetailsModel(
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
