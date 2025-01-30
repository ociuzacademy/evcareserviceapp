// To parse this JSON data, do
//
//     final employeeCountModel = employeeCountModelFromJson(jsonString);

import 'dart:convert';

EmployeeCountModel employeeCountModelFromJson(String str) =>
    EmployeeCountModel.fromJson(json.decode(str));

String employeeCountModelToJson(EmployeeCountModel data) =>
    json.encode(data.toJson());

class EmployeeCountModel {
  final String status;
  final int serviceCentreId;
  final int employeeCount;

  EmployeeCountModel({
    required this.status,
    required this.serviceCentreId,
    required this.employeeCount,
  });

  factory EmployeeCountModel.fromJson(Map<String, dynamic> json) =>
      EmployeeCountModel(
        status: json["status"],
        serviceCentreId: json["service_centre_id"],
        employeeCount: json["employee_count"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "service_centre_id": serviceCentreId,
        "employee_count": employeeCount,
      };
}
