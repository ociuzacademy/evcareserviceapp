// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/common_widgets/employee_container.dart';
import 'package:flutter/material.dart';

class EmployeesList extends StatelessWidget {
  final List<Map<String, dynamic>> employees;
  const EmployeesList({
    super.key,
    required this.employees,
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
        return EmployeeContainer(
          employeeName: employees[index]["employeeName"],
          email: employees[index]["email"],
          phoneNumber: employees[index]["phoneNumber"],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: screenSize.height * 0.01,
        );
      },
      itemCount: employees.length,
    );
  }
}
