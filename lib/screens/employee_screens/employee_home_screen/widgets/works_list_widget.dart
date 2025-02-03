// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/views/repair_request_details.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/models/employee_work_model.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/widgets/repair_request_container.dart';

class WorksListWidget extends StatelessWidget {
  final List<EmployeeWorkModel> workList;
  const WorksListWidget({
    super.key,
    required this.workList,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    if (workList.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.05),
        child: Center(
          child: Column(
            children: [
              Image.asset("assets/images/empty.png"),
              const Text(
                "No repair works found in this category.",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RepairRequestDetails(
                  repairRequestId: workList[index].id,
                ),
              ),
            ),
            child: RepairRequestContainer(
              customerName: workList[index].userName,
              vehicleNumber: workList[index].userName,
              currentStatus: workList[index].status,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: screenSize.height * 0.01,
        );
      },
      itemCount: workList.length,
    );
  }
}
