import 'dart:math';

import 'package:evcareserviceapp/screens/service_center_screens/employee_section_screen/widgets/attendance_list.dart';
import 'package:evcareserviceapp/screens/service_center_screens/employee_section_screen/widgets/employees_list.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/utils/helper.dart';
import 'package:flutter/material.dart';

class EmployeeSectionScreen extends StatefulWidget {
  const EmployeeSectionScreen({super.key});

  static List<Map<String, dynamic>> employees = List.generate(
    10,
    (index) {
      return {
        "id": index,
        "employeeName": "Employee - ${index + 1}",
        "email": Helper.generateRandomEmail(),
        "phoneNumber": Helper.generateRandomIndianMobileNumber(),
      };
    },
  );

  static List<Map<String, dynamic>> attendanceList = List.generate(
    employees.length,
    (index) {
      final random = Random();
      List<String> attendanceStatuses = [
        "present",
        "absent",
        "leave approved",
        "leave rejected"
      ];

      return {
        "id": index,
        "employeeId": index,
        "employeeName": employees[index]["employeeName"],
        "status": attendanceStatuses[random.nextInt(attendanceStatuses.length)]
      };
    },
  );

  @override
  State<EmployeeSectionScreen> createState() => _EmployeeSectionScreenState();
}

class _EmployeeSectionScreenState extends State<EmployeeSectionScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Employee Section"),
        backgroundColor: Colors.black,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        bottom: PreferredSize(
          preferredSize: Size(
            screenSize.width,
            screenSize.height * 0.05,
          ),
          child: TabBar(
            controller: _tabController,
            dividerColor: Colors.green,
            indicatorColor: Colors.green.shade600,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            tabs: const [
              Tab(
                text: "Employees",
              ),
              Tab(
                text: "Attendance",
              )
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          EmployeesList(
            employees: EmployeeSectionScreen.employees,
          ),
          AttendanceList(
            attendanceList: EmployeeSectionScreen.attendanceList,
          )
        ],
      ),
    );
  }
}
