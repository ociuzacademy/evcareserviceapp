// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/screens/assign_employee_screen/views/assign_employee_screen.dart';
import 'package:evcareserviceapp/screens/repair_request_details_screen/widgets/request_status_stepper_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RepairRequestDetails extends StatefulWidget {
  final String customerName;
  final String vehicleNumber;
  final String description;
  final String mechanicName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String currentStatus;
  final double repairCost;
  const RepairRequestDetails({
    super.key,
    required this.customerName,
    required this.vehicleNumber,
    required this.description,
    required this.mechanicName,
    required this.createdAt,
    required this.updatedAt,
    required this.currentStatus,
    required this.repairCost,
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
            title: const Text("Repair Completed"),
            backgroundColor: Colors.black,
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
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogueContext).pop();
                },
                child: const Text("Submit"),
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
    final dateFormat = DateFormat("dd/MM/yyyy");

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
          if (widget.currentStatus == "Repair Requested")
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AssignEmployeeScreen(),
              )),
              child: const Icon(
                Icons.build,
              ),
            ),
          if (widget.currentStatus == "Mechanic Assigned")
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.035),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Customer Name:",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  widget.customerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Vehicle Number:",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  widget.vehicleNumber,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.green,
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            const Text(
              "Complaint Description:",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              widget.description,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            const Divider(
              color: Colors.green,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Mechanic Name:",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  widget.mechanicName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            const Divider(
              color: Colors.green,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenSize.width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Complaint Registered Date",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        dateFormat.format(widget.createdAt),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.28,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Latest Updated Date",
                        softWrap: true,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        dateFormat.format(widget.updatedAt),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.green,
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            const Text(
              "Current Status:",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            RequestStatusStepperWidget(
              currentStatus: widget.currentStatus,
            ),
            const Divider(
              color: Colors.green,
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Repair Cost:",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "₹${widget.repairCost.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
