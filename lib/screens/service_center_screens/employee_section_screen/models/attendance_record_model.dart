// To parse this JSON data, do
//
//     final attendanceRecordModel = attendanceRecordModelFromJson(jsonString);

import 'dart:convert';

List<AttendanceRecordModel> attendanceRecordModelFromJson(String str) =>
    List<AttendanceRecordModel>.from(
        json.decode(str).map((x) => AttendanceRecordModel.fromJson(x)));

String attendanceRecordModelToJson(List<AttendanceRecordModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttendanceRecordModel {
  final int id;
  final String name;
  final String status;

  AttendanceRecordModel({
    required this.id,
    required this.name,
    required this.status,
  });

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) =>
      AttendanceRecordModel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
      };
}
