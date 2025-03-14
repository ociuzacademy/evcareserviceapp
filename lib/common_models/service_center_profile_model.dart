// To parse this JSON data, do
//
//     final serviceCentreProfileModel = serviceCentreProfileModelFromJson(jsonString);

import 'dart:convert';

ServiceCentreProfileModel serviceCentreProfileModelFromJson(String str) =>
    ServiceCentreProfileModel.fromJson(json.decode(str));

String serviceCentreProfileModelToJson(ServiceCentreProfileModel data) =>
    json.encode(data.toJson());

class ServiceCentreProfileModel {
  final String name;
  final String username;
  final String address;
  final String phone;
  final String email;
  final String? image; // Updated to nullable String
  final int id;

  ServiceCentreProfileModel({
    required this.name,
    required this.username,
    required this.address,
    required this.phone,
    required this.email,
    this.image, // Nullable field
    required this.id,
  });

  factory ServiceCentreProfileModel.fromJson(Map<String, dynamic> json) =>
      ServiceCentreProfileModel(
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
