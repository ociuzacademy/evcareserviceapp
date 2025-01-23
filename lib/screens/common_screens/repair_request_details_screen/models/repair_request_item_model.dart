// To parse this JSON data, do
//
//     final repairRequestItemModel = repairRequestItemModelFromJson(jsonString);

import 'dart:convert';

RepairRequestItemModel repairRequestItemModelFromJson(String str) =>
    RepairRequestItemModel.fromJson(json.decode(str));

String repairRequestItemModelToJson(RepairRequestItemModel data) =>
    json.encode(data.toJson());

class RepairRequestItemModel {
  final int id;
  final String userName;
  final String vehicleNum;
  final String employeeName;
  final List<Service> services;
  final DateTime createdAt;
  final String status;
  final DateTime updatedAt;
  final String repairCost;
  final int serviceCentre;

  RepairRequestItemModel({
    required this.id,
    required this.userName,
    required this.vehicleNum,
    required this.employeeName,
    required this.services,
    required this.createdAt,
    required this.status,
    required this.updatedAt,
    required this.repairCost,
    required this.serviceCentre,
  });

  factory RepairRequestItemModel.fromJson(Map<String, dynamic> json) =>
      RepairRequestItemModel(
        id: json["id"],
        userName: json["user_name"],
        vehicleNum: json["vehicle_num"],
        employeeName: json["employee_name"],
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        repairCost: json["repair_cost"],
        serviceCentre: json["service_centre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "vehicle_num": vehicleNum,
        "employee_name": employeeName,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "repair_cost": repairCost,
        "service_centre": serviceCentre,
      };
}

class Service {
  final String name;
  final String time;
  final int amount;

  Service({
    required this.name,
    required this.time,
    required this.amount,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        name: json["name"],
        time: json["time"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "time": time,
        "amount": amount,
      };
}
