// To parse this JSON data, do
//
//     final repairCompletedResponseModel = repairCompletedResponseModelFromJson(jsonString);

import 'dart:convert';

RepairCompletedResponseModel repairCompletedResponseModelFromJson(String str) =>
    RepairCompletedResponseModel.fromJson(json.decode(str));

String repairCompletedResponseModelToJson(RepairCompletedResponseModel data) =>
    json.encode(data.toJson());

class RepairCompletedResponseModel {
  final String status;
  final String message;

  RepairCompletedResponseModel({
    required this.status,
    required this.message,
  });

  factory RepairCompletedResponseModel.fromJson(Map<String, dynamic> json) =>
      RepairCompletedResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
