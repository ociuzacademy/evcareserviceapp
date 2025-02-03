// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/models/employee_work_model.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/services/get_employee_works.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/widgets/employee_attendance_section.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/widgets/works_list_widget.dart';

class EmployeeHompPageWidget extends StatefulWidget {
  const EmployeeHompPageWidget({
    super.key,
  });

  @override
  State<EmployeeHompPageWidget> createState() => _EmployeeHompPageWidgetState();
}

class _EmployeeHompPageWidgetState extends State<EmployeeHompPageWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
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
      body: FutureBuilder<List<EmployeeWorkModel>>(
        future: getEmployeeWorks(),
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
          // if (!snapshot.hasData || snapshot.data!.isEmpty) {
          //   return Center(
          //     child: Column(
          //       children: [
          //         Image.asset("assets/images/empty.png"),
          //         const Text(
          //           "No repair works found.",
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 25,
          //           ),
          //         ),
          //       ],
          //     ),
          //   );
          // }

          // Success State
          final employeeWorks = snapshot.data!;
          final pendingRepairRequests = employeeWorks
              .where((work) => work.status == 'Mechanic Assigned')
              .toList();
          final completedRepairRequests = employeeWorks
              .where((work) =>
                  work.status == 'Repair Completed' ||
                  work.status == 'Vehicle Delivered')
              .toList();
          return TabBarView(
            controller: _tabController,
            children: [
              const EmployeeAttendanceSection(),
              WorksListWidget(
                workList: pendingRepairRequests,
              ),
              WorksListWidget(
                workList: completedRepairRequests,
              ),
            ],
          );
        },
      ),
    );
  }
}
