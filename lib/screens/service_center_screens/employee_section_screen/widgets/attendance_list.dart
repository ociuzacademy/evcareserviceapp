// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/screens/service_center_screens/employee_section_screen/models/attendance_record_model.dart';
import 'package:evcareserviceapp/screens/service_center_screens/employee_section_screen/services/get_employee_attendance_record.dart';
import 'package:evcareserviceapp/screens/service_center_screens/employee_section_screen/widgets/attendance_container.dart';

class AttendanceList extends StatefulWidget {
  const AttendanceList({
    super.key,
  });

  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return FutureBuilder<List<AttendanceRecordModel>>(
      future: getEmployeeAttendanceRecord(),
      builder: (context, snapshot) {
        // Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        }

        // Error State
        if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Image.asset("assets/images/error_image.png"),
                Text(
                  "${snapshot.error}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          );
        }

        // Empty Response data array
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              children: [
                Image.asset("assets/images/empty.png"),
                const Text(
                  "No employees found",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          );
        }

        // Success State
        List<AttendanceRecordModel> attendanceRecord = snapshot.data!;
        return ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.005,
            vertical: screenSize.height * 0.025,
          ),
          itemBuilder: (context, index) {
            AttendanceRecordModel employeeAttendanceData =
                attendanceRecord[index];
            return AttendanceContainer(
              employeeId: employeeAttendanceData.id,
              employeeName: employeeAttendanceData.name,
              status: employeeAttendanceData.status,
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: screenSize.height * 0.01,
            );
          },
          itemCount: attendanceRecord.length,
        );
      },
    );
  }
}
