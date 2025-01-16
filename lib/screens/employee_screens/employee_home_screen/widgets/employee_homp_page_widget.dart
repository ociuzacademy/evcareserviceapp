// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/views/repair_request_details.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/widgets/repair_request_container.dart';
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

class _EmployeeHompPageWidgetState extends State<EmployeeHompPageWidget> {
  final TimeOfDay openingTime = const TimeOfDay(hour: 9, minute: 0);
  // 9:00 AM
  final TimeOfDay attendanceClosingTime = const TimeOfDay(hour: 10, minute: 0);
  // 10:00 AM
  final int employeeId = 2;

  late List<Map<String, dynamic>> pendingRepairRequests;
  late List<Map<String, dynamic>> completedRepairRequests;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: EmployeeAttendanceSection(
            openingTime: openingTime,
            attendanceClosingTime: attendanceClosingTime,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                const Divider(
                  color: Colors.green,
                ),
                SizedBox(
                  height: screenSize.height * 0.005,
                ),
                const Text(
                  "Pending Works",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.005,
                ),
              ],
            ),
          ),
        ),
        SliverList.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RepairRequestDetails(
                      customerName: pendingRepairRequests[index]
                          ['customerName'],
                      vehicleNumber: pendingRepairRequests[index]
                          ['vehicleNumber'],
                      description: pendingRepairRequests[index]['description'],
                      mechanicId: pendingRepairRequests[index]['mechanicId'],
                      mechanicName: pendingRepairRequests[index]
                          ['mechanicName'],
                      createdAt: pendingRepairRequests[index]['createdAt'],
                      updatedAt: pendingRepairRequests[index]['updatedAt'],
                      currentStatus: pendingRepairRequests[index]
                          ['currentStatus'],
                      repairCost: pendingRepairRequests[index]['repairCost'],
                    ),
                  ),
                ),
                child: RepairRequestContainer(
                  customerName: pendingRepairRequests[index]['customerName'],
                  vehicleNumber: pendingRepairRequests[index]['vehicleNumber'],
                  currentStatus: pendingRepairRequests[index]['currentStatus'],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: screenSize.height * 0.01,
            );
          },
          itemCount: pendingRepairRequests.length,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                const Divider(
                  color: Colors.green,
                ),
                SizedBox(
                  height: screenSize.height * 0.005,
                ),
                const Text(
                  "Completed Works",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.005,
                ),
              ],
            ),
          ),
        ),
        SliverList.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RepairRequestDetails(
                      customerName: completedRepairRequests[index]
                          ['customerName'],
                      vehicleNumber: completedRepairRequests[index]
                          ['vehicleNumber'],
                      description: completedRepairRequests[index]
                          ['description'],
                      mechanicId: completedRepairRequests[index]['mechanicId'],
                      mechanicName: completedRepairRequests[index]
                          ['mechanicName'],
                      createdAt: completedRepairRequests[index]['createdAt'],
                      updatedAt: completedRepairRequests[index]['updatedAt'],
                      currentStatus: completedRepairRequests[index]
                          ['currentStatus'],
                      repairCost: completedRepairRequests[index]['repairCost'],
                    ),
                  ),
                ),
                child: RepairRequestContainer(
                  customerName: completedRepairRequests[index]['customerName'],
                  vehicleNumber: completedRepairRequests[index]
                      ['vehicleNumber'],
                  currentStatus: completedRepairRequests[index]
                      ['currentStatus'],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: screenSize.height * 0.01,
            );
          },
          itemCount: completedRepairRequests.length,
        ),
      ],
    );
  }
}
