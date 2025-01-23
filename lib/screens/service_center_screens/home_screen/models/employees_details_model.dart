// To parse this JSON data, do
//
//     final employeesDetailsModel = employeesDetailsModelFromJson(jsonString);

import 'dart:convert';

List<EmployeesDetailsModel> employeesDetailsModelFromJson(String str) =>
    List<EmployeesDetailsModel>.from(
        json.decode(str).map((x) => EmployeesDetailsModel.fromJson(x)));

String employeesDetailsModelToJson(List<EmployeesDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeesDetailsModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phoneNumber;
  final int serviceCentre;

  EmployeesDetailsModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.serviceCentre,
  });

  factory EmployeesDetailsModel.fromJson(Map<String, dynamic> json) =>
      EmployeesDetailsModel(
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
