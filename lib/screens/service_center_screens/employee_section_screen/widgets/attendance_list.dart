// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:evcareserviceapp/screens/service_center_screens/employee_section_screen/widgets/attendance_container.dart';
import 'package:flutter/material.dart';

class AttendanceList extends StatefulWidget {
  final List<Map<String, dynamic>> attendanceList;
  const AttendanceList({
    super.key,
    required this.attendanceList,
  });

  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  Future<void> _showResetAttendanceDialogueBox() async {
    if (mounted) {
      return showDialog(
        context: context,
        builder: (BuildContext dialogueContext) {
          return AlertDialog(
            title: const Text("Reset Attendance"),
            backgroundColor: Colors.black,
            surfaceTintColor: Colors.green.shade100,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            content: const Text(
              "Do you really want to reset today's attendance?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogueContext).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogueContext).pop();
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.05,
        vertical: screenSize.height * 0.005,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: PaddedElevatedButton(
              buttonText: "Reset Today's Attendance",
              onPressed: _showResetAttendanceDialogueBox,
            ),
          ),
          SliverList.separated(
            itemBuilder: (context, index) {
              return AttendanceContainer(
                employeeName: widget.attendanceList[index]["employeeName"],
                status: widget.attendanceList[index]["status"],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: screenSize.height * 0.01,
              );
            },
            itemCount: widget.attendanceList.length,
          ),
        ],
      ),
    );
  }
}
