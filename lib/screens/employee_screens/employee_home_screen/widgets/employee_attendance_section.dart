// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/common_utils/constants.dart';
import 'package:evcareserviceapp/common_utils/helper.dart';
import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/services/submit_employee_attendance.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/widgets/disabled_padded_elevated_button.dart';
import 'package:flutter/material.dart';

class EmployeeAttendanceSection extends StatefulWidget {
  const EmployeeAttendanceSection({
    super.key,
  });

  @override
  State<EmployeeAttendanceSection> createState() =>
      _EmployeeAttendanceSectionState();
}

class _EmployeeAttendanceSectionState extends State<EmployeeAttendanceSection> {
  bool _isPresentToday = false;
  bool _isSubmittingAttendance = false;
  late TimeOfDay _loginTime;

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
      Constants.openingTime,
      Constants.attendanceClosingTime,
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

  Future<void> _markAttendance() async {
    setState(() {
      _isSubmittingAttendance = true;
    });
    try {
      final response = await submitEmployeeAttendance();
      if (response.status == "success" && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Submitting attendance success.'),
          ),
        );
      }
    } catch (e) {
      // Handle the error, e.g., show a snackbar
      if (mounted) {
        final errorMessage = e.toString();
        showErrorDialogue(
          context,
          "Submitting attendance failed due to $errorMessage.",
        );
      }
    } finally {
      setState(() {
        _isPresentToday = true;
        _isSubmittingAttendance = false;
        _loginTime = TimeOfDay.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String attendanceStatus = _getAttendanceStatus();

    if (_isPresentToday) {
      final String loginTimeFormat = _loginTime.format(context);
      return Text(
        "Login at $loginTimeFormat",
        style: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );
    }
    return _isSubmittingAttendance
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          )
        : Column(
            children: [
              (!_isPresentToday && attendanceStatus.isNotEmpty)
                  ? const DisabledPaddedElevatedButton(
                      buttonText: "No Attendance",
                    )
                  : PaddedElevatedButton(
                      buttonText: "Mark Attendance",
                      onPressed: _markAttendance,
                    ),
              if (attendanceStatus.isNotEmpty)
                Text(
                  attendanceStatus,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          );
  }
}
