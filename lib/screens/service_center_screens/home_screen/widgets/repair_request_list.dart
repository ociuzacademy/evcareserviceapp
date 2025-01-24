// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/views/repair_request_details.dart';
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/screens/service_center_screens/home_screen/models/repair_request_model.dart';

class RepairRequestList extends StatelessWidget {
  final List<RepairRequestModel> filteredRequests;
  const RepairRequestList({
    super.key,
    required this.filteredRequests,
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

    if (filteredRequests.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.05),
          child: Center(
            child: Column(
              children: [
                Image.asset("assets/images/empty.png"),
                const Text(
                  "No repair works found in this category",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverList.separated(
      itemCount: filteredRequests.length,
      itemBuilder: (context, index) {
        RepairRequestModel requestItem = filteredRequests[index];
        return InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RepairRequestDetails(
                accountType: "owner",
                repairRequestId: requestItem.id,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
            ),
            child: ListTile(
              title: Text(
                requestItem.userName,
              ),
              subtitle: Text(
                requestItem.vehicleNum,
              ),
              leading: getRepairRequestStatusIcon(
                requestItem.status,
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
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: screenSize.height * 0.01,
      ),
    );
  }
}
