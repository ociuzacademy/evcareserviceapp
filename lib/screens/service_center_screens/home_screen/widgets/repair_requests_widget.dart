// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/common_utils/local_storage.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/models/repair_request_model.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/services/get_repair_requests.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/repair_request_list.dart';
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
  RequestOption _currentOption = RequestOption.all;
  late Future<List<RepairRequestModel>> _displayingRepairRequests;
  int? _serviceCentreId;

  @override
  void initState() {
    super.initState();
    _getServiceCentreId();
  }

  Future<void> _getServiceCentreId() async {
    final userId = await LocalStorage.getServiceCentreId();
    if (mounted) {
      setState(() {
        _serviceCentreId = userId;
        if (_serviceCentreId != null) {
          _displayingRepairRequests = getRepairRequests(
            serviceCentreId: _serviceCentreId!,
          );
        }
      });
    }
  }

  List<RepairRequestModel> _filterRequests(
    List<RepairRequestModel> repairRequests,
  ) {
    switch (_currentOption) {
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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return _serviceCentreId == null
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          )
        : FutureBuilder<List<RepairRequestModel>>(
            future: _displayingRepairRequests,
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
                      value: _currentOption,
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
                            _currentOption = newValue;
                          });
                        }
                      },
                    ),
                  ),
                  RepairRequestList(
                    filteredRequests: filteredRequests,
                  ),
                ],
              );
            },
          );
  }
}
