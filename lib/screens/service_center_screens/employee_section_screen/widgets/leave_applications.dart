// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/screens/service_center_screens/employee_section_screen/widgets/leave_application_container.dart';
import 'package:flutter/material.dart';

class LeaveApplications extends StatelessWidget {
  final List<Map<String, dynamic>> leaveApplications;
  const LeaveApplications({
    super.key,
    required this.leaveApplications,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.05,
        vertical: screenSize.height * 0.05,
      ),
      itemBuilder: (context, index) {
        return LeaveApplicationContainer(
          employeeName: leaveApplications[index]["employeeName"],
          date: leaveApplications[index]["date"],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: screenSize.height * 0.01,
        );
      },
      itemCount: leaveApplications.length,
    );
  }
}
