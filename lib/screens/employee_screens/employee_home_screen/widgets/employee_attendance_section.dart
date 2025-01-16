// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/widgets/disabled_padded_elevated_button.dart';
import 'package:flutter/material.dart';

class EmployeeAttendanceSection extends StatefulWidget {
  final TimeOfDay openingTime;
  final TimeOfDay attendanceClosingTime;
  const EmployeeAttendanceSection({
    super.key,
    required this.openingTime,
    required this.attendanceClosingTime,
  });

  @override
  State<EmployeeAttendanceSection> createState() =>
      _EmployeeAttendanceSectionState();
}

class _EmployeeAttendanceSectionState extends State<EmployeeAttendanceSection> {
  bool _isPresentToday = false;
  final TimeOfDay loginTime = const TimeOfDay(hour: 9, minute: 30);

  String _getAttendanceStatus() {
    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);

    // Check if today is Sunday
    if (now.weekday == DateTime.sunday) {
      return "Closed (Sunday)";
    }

    // Check if current time is within opening and closing times
    if (_isTimeBetween(
      currentTime,
      widget.openingTime,
      widget.attendanceClosingTime,
    )) {
      return "";
    } else {
      return "You are late. Please contact HR.";
    }
  }

  bool _isTimeBetween(
    TimeOfDay currentTime,
    TimeOfDay startTime,
    TimeOfDay endTime,
  ) {
    final currentMinutes = currentTime.hour * 60 + currentTime.minute;
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;

    return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
  }

  @override
  Widget build(BuildContext context) {
    final String attendanceStatus = _getAttendanceStatus();

    if (_isPresentToday) {
      final String loginTimeFormat = loginTime.format(context);
      return Text(
        "Login at $loginTimeFormat",
        style: const TextStyle(
          color: Colors.green,
          fontSize: 18,
        ),
      );
    }
    return Column(
      children: [
        (!_isPresentToday && attendanceStatus.isNotEmpty)
            ? const DisabledPaddedElevatedButton(
                buttonText: "No Attendance",
              )
            : PaddedElevatedButton(
                buttonText: "Mark Attendance",
                onPressed: () {
                  setState(() {
                    _isPresentToday = true;
                  });
                },
              ),
        if (attendanceStatus.isNotEmpty)
          Text(
            attendanceStatus,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
      ],
    );
  }
}
