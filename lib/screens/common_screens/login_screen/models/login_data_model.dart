import 'dart:convert';

LoginDataModel loginDataModelFromJson(String str) =>
    LoginDataModel.fromJson(json.decode(str));

String loginDataModelToJson(LoginDataModel data) => json.encode(data.toJson());

class LoginDataModel {
  final String status;
  final String message;
  final String utype;
  final int? serviceCentreId;
  final int? employeeId;

  LoginDataModel({
    required this.status,
    required this.message,
    required this.utype,
    this.serviceCentreId,
    this.employeeId,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
        status: json["status"],
        message: json["message"],
        utype: json["utype"],
        serviceCentreId:
            json["service_centre_id"] is int ? json["service_centre_id"] : null,
        employeeId: json["employee_id"] is int ? json["employee_id"] : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "utype": utype,
        "service_centre_id": serviceCentreId,
        "employee_id": employeeId,
      };
}
