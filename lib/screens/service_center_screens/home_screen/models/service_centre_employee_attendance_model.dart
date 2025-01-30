// To parse this JSON data, do
//
//     final serviceCentreEmployeeAttendanceModel = serviceCentreEmployeeAttendanceModelFromJson(jsonString);

import 'dart:convert';

List<ServiceCentreEmployeeAttendanceModel>
    serviceCentreEmployeeAttendanceModelFromJson(String str) =>
        List<ServiceCentreEmployeeAttendanceModel>.from(json
            .decode(str)
            .map((x) => ServiceCentreEmployeeAttendanceModel.fromJson(x)));

String serviceCentreEmployeeAttendanceModelToJson(
        List<ServiceCentreEmployeeAttendanceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceCentreEmployeeAttendanceModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phoneNumber;
  final int serviceCentre;

  ServiceCentreEmployeeAttendanceModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.serviceCentre,
  });

  factory ServiceCentreEmployeeAttendanceModel.fromJson(
          Map<String, dynamic> json) =>
      ServiceCentreEmployeeAttendanceModel(
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
