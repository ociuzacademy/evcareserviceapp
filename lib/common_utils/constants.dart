import 'package:flutter/material.dart';

class Constants {
  static const TimeOfDay openingTime = TimeOfDay(
    hour: 9,
    minute: 0,
  ); // 9:00 AM
  static const TimeOfDay closingTime = TimeOfDay(
    hour: 18,
    minute: 0,
  ); // 6:00 PM
  static const TimeOfDay attendanceClosingTime = TimeOfDay(
    hour: 10,
    minute: 0,
  ); // 10:00 AM
}
