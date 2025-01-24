// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/common_utils/helper.dart';
import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/services/complete_repair.dart';
import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/widgets/single_repair_details.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/views/employee_home_screen.dart';
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
  bool _isCompletingRepair = false;

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
                onPressed: _isCompletingRepair
                    ? null
                    : () {
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
                onPressed: _isCompletingRepair ? null : _completeRepair,
                child: Text(
                  _isCompletingRepair ? "Completing..." : "Submit",
                  style: const TextStyle(
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

  Future<void> _completeRepair() async {
    setState(() {
      _isCompletingRepair = true;
    });
    try {
      final response = await completeRepair(
        repairRequestId: widget.repairRequestId,
        employeeId: 1,
      );
      if (response.status == "success" && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Repair completed successfully.",
            ),
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const EmployeeHomeScreen(),
          ),
        );
      }
    } catch (e) {
      // Handle the error, e.g., show a snackbar
      if (mounted) {
        final errorMessage = e.toString();
        showErrorDialogue(
          context,
          "Completing repair failed due to $errorMessage",
        );
      }
    } finally {
      setState(() {
        _isCompletingRepair = false;
      });
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
                    builder: (context) => AssignEmployeeScreen(
                      repairRequestId: widget.repairRequestId,
                    ),
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
          body: _isCompletingRepair
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.035),
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
