// To parse this JSON data, do
//
//     final loginDataModel = loginDataModelFromJson(jsonString);

import 'dart:convert';

LoginDataModel loginDataModelFromJson(String str) =>
    LoginDataModel.fromJson(json.decode(str));

String loginDataModelToJson(LoginDataModel data) => json.encode(data.toJson());

class LoginDataModel {
  String? status;
  String? message;
  String? utype;
  int? userId;

  LoginDataModel({
    this.status,
    this.message,
    this.utype,
    this.userId,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
        status: json["status"],
        message: json["message"],
        utype: json["utype"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "utype": utype,
        "user_id": userId,
      };
}
