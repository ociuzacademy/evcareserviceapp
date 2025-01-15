// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/views/repair_request_details.dart';
import 'package:flutter/material.dart';

class RepairRequestsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> repairRequests;
  const RepairRequestsWidget({
    super.key,
    required this.repairRequests,
  });

  Icon getRepairRequestStatusIcon(String icon) {
    switch (icon) {
      case "Repair Requested":
        return const Icon(
          Icons.car_crash,
          color: Colors.red,
        );
      case "Mechanic Assigned":
        return const Icon(
          Icons.car_repair,
          color: Colors.orange,
        );
      case "Repair Completed":
        return const Icon(
          Icons.electric_car,
          color: Colors.yellow,
        );
      default:
        return const Icon(
          Icons.receipt,
          color: Colors.greenAccent,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.05,
      ),
      itemCount: repairRequests.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RepairRequestDetails(
                customerName: repairRequests[index]['customerName'],
                vehicleNumber: repairRequests[index]['vehicleNumber'],
                description: repairRequests[index]['description'],
                mechanicName: repairRequests[index]['mechanicName'],
                createdAt: repairRequests[index]['createdAt'],
                updatedAt: repairRequests[index]['updatedAt'],
                currentStatus: repairRequests[index]['currentStatus'],
                repairCost: repairRequests[index]['repairCost'],
              ),
            ),
          ),
          child: ListTile(
            title: Text(
              repairRequests[index]['customerName'],
            ),
            subtitle: Text(
              repairRequests[index]['vehicleNumber'],
            ),
            leading: getRepairRequestStatusIcon(
              repairRequests[index]['currentStatus'],
            ),
            tileColor: Colors.black,
            titleAlignment: ListTileTitleAlignment.center,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            subtitleTextStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            style: ListTileStyle.drawer,
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.green,
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: screenSize.height * 0.01,
      ),
    );
  }
}
