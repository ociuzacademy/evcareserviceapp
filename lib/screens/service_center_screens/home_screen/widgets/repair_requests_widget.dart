// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/views/repair_request_details.dart';
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
  final List<Map<String, dynamic>> repairRequests;

  const RepairRequestsWidget({
    super.key,
    required this.repairRequests,
  });

  @override
  State<RepairRequestsWidget> createState() => _RepairRequestsWidgetState();
}

class _RepairRequestsWidgetState extends State<RepairRequestsWidget> {
  RequestOption currentOption = RequestOption.all;
  late List<Map<String, dynamic>> displayingRepairRequests;

  @override
  void initState() {
    super.initState();
    _updateDisplayingRepairRequests();
  }

  void _updateDisplayingRepairRequests() {
    setState(() {
      switch (currentOption) {
        case RequestOption.repairRequested:
          displayingRepairRequests = widget.repairRequests
              .where((request) =>
                  request['currentStatus'] ==
                  RequestOption.repairRequested.value)
              .toList();
          break;
        case RequestOption.mechanicAssigned:
          displayingRepairRequests = widget.repairRequests
              .where((request) =>
                  request['currentStatus'] ==
                  RequestOption.mechanicAssigned.value)
              .toList();
          break;
        case RequestOption.repairCompleted:
          displayingRepairRequests = widget.repairRequests
              .where((request) =>
                  request['currentStatus'] ==
                  RequestOption.repairCompleted.value)
              .toList();
          break;
        case RequestOption.vehicleDelivered:
          displayingRepairRequests = widget.repairRequests
              .where((request) =>
                  request['currentStatus'] ==
                  RequestOption.vehicleDelivered.value)
              .toList();
          break;
        default:
          displayingRepairRequests = widget.repairRequests;
          break;
      }
    });
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
                  _updateDisplayingRepairRequests();
                });
              }
            },
          ),
        ),
        SliverList.separated(
          itemCount: displayingRepairRequests.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RepairRequestDetails(
                    customerName: displayingRepairRequests[index]
                        ['customerName'],
                    vehicleNumber: displayingRepairRequests[index]
                        ['vehicleNumber'],
                    description: displayingRepairRequests[index]['description'],
                    mechanicId: displayingRepairRequests[index]['mechanicId'],
                    mechanicName: displayingRepairRequests[index]
                        ['mechanicName'],
                    createdAt: displayingRepairRequests[index]['createdAt'],
                    updatedAt: displayingRepairRequests[index]['updatedAt'],
                    currentStatus: displayingRepairRequests[index]
                        ['currentStatus'],
                    repairCost: displayingRepairRequests[index]['repairCost'],
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                ),
                child: ListTile(
                  title: Text(
                    displayingRepairRequests[index]['customerName'],
                  ),
                  subtitle: Text(
                    displayingRepairRequests[index]['vehicleNumber'],
                  ),
                  leading: getRepairRequestStatusIcon(
                    displayingRepairRequests[index]['currentStatus'],
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
  }
}
