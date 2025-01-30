// To parse this JSON data, do
//
//     final employeeAttendanceStatusModel = employeeAttendanceStatusModelFromJson(jsonString);

import 'dart:convert';

EmployeeAttendanceStatusModel employeeAttendanceStatusModelFromJson(
        String str) =>
    EmployeeAttendanceStatusModel.fromJson(json.decode(str));

String employeeAttendanceStatusModelToJson(
        EmployeeAttendanceStatusModel data) =>
    json.encode(data.toJson());

class EmployeeAttendanceStatusModel {
  final bool attendance;
  final int employeeId;

  EmployeeAttendanceStatusModel({
    required this.attendance,
    required this.employeeId,
  });

  factory EmployeeAttendanceStatusModel.fromJson(Map<String, dynamic> json) =>
      EmployeeAttendanceStatusModel(
        attendance: json["attendance"],
        employeeId: json["employee_id"],
      );

  Map<String, dynamic> toJson() => {
        "attendance": attendance,
        "employee_id": employeeId,
      };
}
