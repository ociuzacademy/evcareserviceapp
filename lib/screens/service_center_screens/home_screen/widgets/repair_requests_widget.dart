// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/views/repair_request_details.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/models/repair_request_model.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/services/get_repair_requests.dart';
import 'package:flutter/material.dart';

enum RequestOption {
  all(
    "All",
    "All",
  ),
  repairRequested(
    "Repair Requested",
    "Repair Requested",
  ),
  mechanicAssigned(
    "Mechanic Assigned",
    "Mechanic Assigned",
  ),
  repairCompleted(
    "Repair Completed",
    "Repair Completed",
  ),
  vehicleDelivered("Vehicle Delivered", "Vehicle Delivered");

  const RequestOption(this.label, this.value);
  final String label;
  final String value;
}

class RepairRequestsWidget extends StatefulWidget {
  const RepairRequestsWidget({
    super.key,
  });

  @override
  State<RepairRequestsWidget> createState() => _RepairRequestsWidgetState();
}

class _RepairRequestsWidgetState extends State<RepairRequestsWidget> {
  RequestOption currentOption = RequestOption.all;
  late Future<List<RepairRequestModel>> displayingRepairRequests;

  @override
  void initState() {
    super.initState();
    displayingRepairRequests = getRepairRequests(serviceCentreId: 2);
  }

  List<RepairRequestModel> _filterRequests(
    List<RepairRequestModel> repairRequests,
  ) {
    switch (currentOption) {
      case RequestOption.repairRequested:
        return repairRequests
            .where((request) =>
                request.status == RequestOption.repairRequested.value)
            .toList();
      case RequestOption.mechanicAssigned:
        return repairRequests
            .where((request) =>
                request.status == RequestOption.mechanicAssigned.value)
            .toList();
      case RequestOption.repairCompleted:
        return repairRequests
            .where((request) =>
                request.status == RequestOption.repairCompleted.value)
            .toList();
      case RequestOption.vehicleDelivered:
        return repairRequests
            .where((request) =>
                request.status == RequestOption.vehicleDelivered.value)
            .toList();
      default:
        return repairRequests;
    }
  }

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
    return FutureBuilder<List<RepairRequestModel>>(
      future: displayingRepairRequests,
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
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              children: [
                Image.asset("assets/images/empty.png"),
                const Text(
                  "No products found",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          );
        }

        // Success State
        final List<RepairRequestModel> repairRequests = snapshot.data!;
        final List<RepairRequestModel> filteredRequests =
            _filterRequests(repairRequests);
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: DropdownButton<RequestOption>(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                ),
                isExpanded: true,
                dropdownColor: Colors.green,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                value: currentOption,
                items: RequestOption.values
                    .map<DropdownMenuItem<RequestOption>>((option) {
                  return DropdownMenuItem<RequestOption>(
                    value: option,
                    child: Text(option.label),
                  );
                }).toList(),
                onChanged: (RequestOption? newValue) {
                  if (newValue != null) {
                    setState(() {
                      currentOption = newValue;
                    });
                  }
                },
              ),
            ),
            SliverList.separated(
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
            ),
          ],
        );
      },
    );
  }
}
