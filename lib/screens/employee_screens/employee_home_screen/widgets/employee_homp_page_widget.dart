// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/widgets/works_list_widget.dart';
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/widgets/employee_attendance_section.dart';

class EmployeeHompPageWidget extends StatefulWidget {
  final List<Map<String, dynamic>> repairRequests;
  const EmployeeHompPageWidget({
    super.key,
    required this.repairRequests,
  });

  @override
  State<EmployeeHompPageWidget> createState() => _EmployeeHompPageWidgetState();
}

class _EmployeeHompPageWidgetState extends State<EmployeeHompPageWidget>
    with SingleTickerProviderStateMixin {
  final TimeOfDay openingTime = const TimeOfDay(hour: 9, minute: 0);
  // 9:00 AM
  final TimeOfDay attendanceClosingTime = const TimeOfDay(hour: 10, minute: 0);
  // 10:00 AM
  final int employeeId = 2;

  late List<Map<String, dynamic>> pendingRepairRequests;
  late List<Map<String, dynamic>> completedRepairRequests;
  late final TabController _tabController;

  @override
  void initState() {
    pendingRepairRequests = widget.repairRequests
        .where((request) =>
            request['mechanicId'] == employeeId &&
            request['currentStatus'] == 'Mechanic Assigned')
        .toList();
    completedRepairRequests = widget.repairRequests
        .where((request) =>
            request['mechanicId'] == employeeId &&
            (request['currentStatus'] == 'Repair Completed' ||
                request['currentStatus'] == 'Vehicle Delivered'))
        .toList();
    _tabController = TabController(length: 3, vsync: this);
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
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: Size(
            screenSize.width,
            screenSize.height * 0.005,
          ),
          child: TabBar(
            controller: _tabController,
            dividerColor: Colors.green,
            indicatorColor: Colors.green.shade600,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            tabs: const [
              Tab(
                text: "Attendance",
              ),
              Tab(
                text: "Pending Works",
              ),
              Tab(
                text: "Completed Works",
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          EmployeeAttendanceSection(
            openingTime: openingTime,
            attendanceClosingTime: attendanceClosingTime,
          ),
          WorksListWidget(
            workList: pendingRepairRequests,
          ),
          WorksListWidget(
            workList: completedRepairRequests,
          ),
        ],
      ),
    );
  }
}
