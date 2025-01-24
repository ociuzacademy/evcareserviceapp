// To parse this JSON data, do
//
//     final serviceCenterProfileModel = serviceCenterProfileModelFromJson(jsonString);

import 'dart:convert';

ServiceCenterProfileModel serviceCenterProfileModelFromJson(String str) =>
    ServiceCenterProfileModel.fromJson(json.decode(str));

String serviceCenterProfileModelToJson(ServiceCenterProfileModel data) =>
    json.encode(data.toJson());

class ServiceCenterProfileModel {
  final String name;
  final String username;
  final String address;
  final String phone;
  final String email;
  final String? image; // Updated to nullable String
  final int id;

  ServiceCenterProfileModel({
    required this.name,
    required this.username,
    required this.address,
    required this.phone,
    required this.email,
    this.image, // Nullable field
    required this.id,
  });

  factory ServiceCenterProfileModel.fromJson(Map<String, dynamic> json) =>
      ServiceCenterProfileModel(
        name: json["name"],
        username: json["username"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        image: json[
            "image"], // This will be null if not present or null in the JSON
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "address": address,
        "phone": phone,
        "email": email,
        "image": image, // This will serialize as null if the value is null
        "id": id,
      };
}
