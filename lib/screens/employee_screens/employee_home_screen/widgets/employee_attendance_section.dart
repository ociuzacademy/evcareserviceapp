// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/common_utils/constants.dart';
import 'package:evcareserviceapp/common_utils/helper.dart';
import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/models/employee_attendance_status_model.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/services/get_employee_attendance_status.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/services/submit_employee_attendance.dart';

class EmployeeAttendanceSection extends StatefulWidget {
  const EmployeeAttendanceSection({
    super.key,
  });

  @override
  State<EmployeeAttendanceSection> createState() =>
      _EmployeeAttendanceSectionState();
}

class _EmployeeAttendanceSectionState extends State<EmployeeAttendanceSection> {
  bool? _isPresentToday;
  bool _isSubmittingAttendance = false;

  @override
  void initState() {
    super.initState();
    _getCurrentAttendanceStatus();
  }

  Future<void> _getCurrentAttendanceStatus() async {
    final EmployeeAttendanceStatusModel attendanceStatusModel =
        await getEmployeeAttendanceStatus();
    setState(() {
      _isPresentToday = attendanceStatusModel.attendance;
    });
    print(_isPresentToday);
  }

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
          SnackBar(
            content: Text(response.message),
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final String attendanceStatus = _getAttendanceStatus();

    if (_isPresentToday != null && _isPresentToday == true) {
      return const Text(
        "Congratulations, You have successfully logged in.",
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );
    }
    return _isPresentToday == null
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          )
        : _isSubmittingAttendance
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : Column(
                children: [
                  (_isPresentToday == false && attendanceStatus.isNotEmpty)
                      ? const SizedBox()
                      : PaddedElevatedButton(
                          buttonText: "Mark Attendance",
                          onPressed: _markAttendance,
                        ),
                  attendanceStatus.isNotEmpty
                      ? SizedBox(
                          height: screenSize.height * 0.5,
                          width: screenSize.width,
                          child: Center(
                            child: Text(
                              attendanceStatus,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              );
  }
}
