// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.005,
        vertical: screenSize.height * 0.025,
      ),
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
    );
  }
}
