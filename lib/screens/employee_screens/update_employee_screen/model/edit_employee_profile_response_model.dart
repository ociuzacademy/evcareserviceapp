// To parse this JSON data, do
//
//     final editEmployeeProfileResponseModel = editEmployeeProfileResponseModelFromJson(jsonString);

import 'dart:convert';

EditEmployeeProfileResponseModel editEmployeeProfileResponseModelFromJson(
        String str) =>
    EditEmployeeProfileResponseModel.fromJson(json.decode(str));

String editEmployeeProfileResponseModelToJson(
        EditEmployeeProfileResponseModel data) =>
    json.encode(data.toJson());

class EditEmployeeProfileResponseModel {
  String status;
  String message;
  Data data;

  EditEmployeeProfileResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EditEmployeeProfileResponseModel.fromJson(
          Map<String, dynamic> json) =>
      EditEmployeeProfileResponseModel(
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
  int id;
  String username;
  String name;
  String email;
  String phoneNumber;
  String password;
  String utype;
  int serviceCentre;

  Data({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.utype,
    required this.serviceCentre,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        password: json["password"],
        utype: json["utype"],
        serviceCentre: json["service_centre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
        "utype": utype,
        "service_centre": serviceCentre,
      };
}
