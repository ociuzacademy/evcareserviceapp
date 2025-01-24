// To parse this JSON data, do
//
//     final feedbackModel = feedbackModelFromJson(jsonString);

import 'dart:convert';

List<FeedbackModel> feedbackModelFromJson(String str) =>
    List<FeedbackModel>.from(
        json.decode(str).map((x) => FeedbackModel.fromJson(x)));

String feedbackModelToJson(List<FeedbackModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedbackModel {
  final String userName;
  final String feedback;
  final int repair;
  final DateTime date;

  FeedbackModel({
    required this.userName,
    required this.feedback,
    required this.repair,
    required this.date,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        userName: json["user_name"],
        feedback: json["feedback"],
        repair: json["repair"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "feedback": feedback,
        "repair": repair,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
