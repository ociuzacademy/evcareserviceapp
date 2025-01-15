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
  String? serviceCentreId;
  String? employeeId;

  LoginDataModel({
    this.status,
    this.message,
    this.utype,
    this.serviceCentreId,
    this.employeeId,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
        status: json["status"],
        message: json["message"],
        utype: json["utype"],
        serviceCentreId: json["service_centre_id"],
        employeeId: json["employee_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "utype": utype,
        "service_centre_id": serviceCentreId,
        "employee_id": employeeId,
      };
}
