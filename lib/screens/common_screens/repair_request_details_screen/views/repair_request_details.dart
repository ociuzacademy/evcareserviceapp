// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/widgets/single_repair_details.dart';
import 'package:flutter/material.dart';
import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/widgets/details_row.dart';
import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/widgets/repair_dates_display_widget.dart';

import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/models/repair_request_item_model.dart';
import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/services/get_repair_request_item.dart';
import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/widgets/request_status_stepper_widget.dart';
import 'package:evcareserviceapp/screens/service_center_screens/assign_employee_screen/views/assign_employee_screen.dart';

class RepairRequestDetails extends StatefulWidget {
  final String accountType;
  final int repairRequestId;
  const RepairRequestDetails({
    super.key,
    required this.accountType,
    required this.repairRequestId,
  });

  @override
  State<RepairRequestDetails> createState() => _RepairRequestDetailsState();
}

class _RepairRequestDetailsState extends State<RepairRequestDetails> {
  Future<void> _showRepairCompleteDialogueBox() async {
    if (mounted) {
      return showDialog(
        context: context,
        builder: (BuildContext dialogueContext) {
          return AlertDialog(
            title: const Text("Repair Complete"),
            backgroundColor: Colors.black,
            surfaceTintColor: Colors.green.shade100,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            content: const Text(
              "Did you completed this repair request?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogueContext).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogueContext).pop();
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return FutureBuilder<RepairRequestItemModel>(
      future: getRepairRequestItem(repairId: widget.repairRequestId),
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
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            child: Column(
              children: [
                Image.asset("assets/images/empty.png"),
                const Text(
                  "No repair request details found",
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
        RepairRequestItemModel repairRequestItem = snapshot.data!;
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text("Repair Request Details"),
            backgroundColor: Colors.black,
            centerTitle: true,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            actions: [
              if (widget.accountType == "owner" &&
                  repairRequestItem.status == "Repair Requested")
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AssignEmployeeScreen(),
                  )),
                  child: const Icon(
                    Icons.build,
                  ),
                ),
              if (widget.accountType == "employee" &&
                  repairRequestItem.status == "Mechanic Assigned")
                InkWell(
                  onTap: _showRepairCompleteDialogueBox,
                  child: const Icon(
                    Icons.restore_page,
                  ),
                ),
              SizedBox(
                width: screenSize.width * 0.05,
              )
            ],
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.035),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: DetailsRow(
                    title: "Customer Name:",
                    details: repairRequestItem.userName,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                ),
                SliverToBoxAdapter(
                  child: DetailsRow(
                    title: "Vehicle Number:",
                    details: repairRequestItem.vehicleNum,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    color: Colors.green,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Text(
                    "Complaint Description:",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                ),
                SliverList.separated(
                  itemBuilder: (context, index) => SingleRepairDetails(
                    name: repairRequestItem.services[index].name,
                    time: repairRequestItem.services[index].time,
                    amount: repairRequestItem.services[index].amount,
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: screenSize.height * 0.025,
                  ),
                  itemCount: repairRequestItem.services.length,
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    color: Colors.green,
                  ),
                ),
                if (repairRequestItem.employeeName.isNotEmpty)
                  SliverToBoxAdapter(
                    child: DetailsRow(
                      title: "Mechanic Name:",
                      details: repairRequestItem.employeeName,
                    ),
                  ),
                if (repairRequestItem.employeeName.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                  ),
                if (repairRequestItem.employeeName.isNotEmpty)
                  const SliverToBoxAdapter(
                    child: Divider(
                      color: Colors.green,
                    ),
                  ),
                SliverToBoxAdapter(
                  child: RepairDatesDisplayWidget(
                    createdAt: repairRequestItem.createdAt,
                    updatedAt: repairRequestItem.updatedAt,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    color: Colors.green,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Text(
                    "Current Status:",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                ),
                SliverToBoxAdapter(
                  child: RequestStatusStepperWidget(
                    currentStatus: repairRequestItem.status,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    color: Colors.green,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                ),
                SliverToBoxAdapter(
                  child: DetailsRow(
                    title: "Repair Cost:",
                    details: "₹${repairRequestItem.repairCost}",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
