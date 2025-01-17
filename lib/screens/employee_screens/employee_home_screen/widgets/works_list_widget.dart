// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/views/repair_request_details.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/widgets/repair_request_container.dart';
import 'package:flutter/material.dart';

class WorksListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> workList;
  const WorksListWidget({
    super.key,
    required this.workList,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RepairRequestDetails(
                  customerName: workList[index]['customerName'],
                  vehicleNumber: workList[index]['vehicleNumber'],
                  description: workList[index]['description'],
                  mechanicId: workList[index]['mechanicId'],
                  mechanicName: workList[index]['mechanicName'],
                  createdAt: workList[index]['createdAt'],
                  updatedAt: workList[index]['updatedAt'],
                  currentStatus: workList[index]['currentStatus'],
                  repairCost: workList[index]['repairCost'],
                ),
              ),
            ),
            child: RepairRequestContainer(
              customerName: workList[index]['customerName'],
              vehicleNumber: workList[index]['vehicleNumber'],
              currentStatus: workList[index]['currentStatus'],
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
