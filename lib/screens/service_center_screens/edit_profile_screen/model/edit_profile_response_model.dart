// To parse this JSON data, do
//
//     final editProfileResponseModel = editProfileResponseModelFromJson(jsonString);

import 'dart:convert';

EditProfileResponseModel editProfileResponseModelFromJson(String str) =>
    EditProfileResponseModel.fromJson(json.decode(str));

String editProfileResponseModelToJson(EditProfileResponseModel data) =>
    json.encode(data.toJson());

class EditProfileResponseModel {
  String status;
  String message;
  Data data;

  EditProfileResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EditProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      EditProfileResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String name;
  String username;
  String address;
  String phone;
  String email;
  String password;
  String latitude;
  String longitude;
  String utype;
  String image;

  Data({
    required this.name,
    required this.username,
    required this.address,
    required this.phone,
    required this.email,
    required this.password,
    required this.latitude,
    required this.longitude,
    required this.utype,
    required this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        username: json["username"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        utype: json["utype"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "address": address,
        "phone": phone,
        "email": email,
        "password": password,
        "latitude": latitude,
        "longitude": longitude,
        "utype": utype,
        "image": image,
      };
}
