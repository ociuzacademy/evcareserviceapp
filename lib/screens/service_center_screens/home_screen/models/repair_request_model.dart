// To parse this JSON data, do
//
//     final repairRequestModel = repairRequestModelFromJson(jsonString);

import 'dart:convert';

List<RepairRequestModel> repairRequestModelFromJson(String str) =>
    List<RepairRequestModel>.from(
        json.decode(str).map((x) => RepairRequestModel.fromJson(x)));

String repairRequestModelToJson(List<RepairRequestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RepairRequestModel {
  final String userName;
  final String vehicleNum;
  final int id;
  final String status;

  RepairRequestModel({
    required this.userName,
    required this.vehicleNum,
    required this.id,
    required this.status,
  });

  factory RepairRequestModel.fromJson(Map<String, dynamic> json) =>
      RepairRequestModel(
        userName: json["user_name"],
        vehicleNum: json["vehicle_num"],
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "vehicle_num": vehicleNum,
        "id": id,
        "status": status,
      };
}
