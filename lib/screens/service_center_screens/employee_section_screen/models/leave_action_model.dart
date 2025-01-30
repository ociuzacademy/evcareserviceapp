// To parse this JSON data, do
//
//     final leaveActionModel = leaveActionModelFromJson(jsonString);

import 'dart:convert';

LeaveActionModel leaveActionModelFromJson(String str) =>
    LeaveActionModel.fromJson(json.decode(str));

String leaveActionModelToJson(LeaveActionModel data) =>
    json.encode(data.toJson());

class LeaveActionModel {
  final String status;
  final String message;

  LeaveActionModel({
    required this.status,
    required this.message,
  });

  factory LeaveActionModel.fromJson(Map<String, dynamic> json) =>
      LeaveActionModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
