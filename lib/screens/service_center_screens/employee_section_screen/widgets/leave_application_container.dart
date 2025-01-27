// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/common_widgets/custom_column_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveApplicationContainer extends StatefulWidget {
  final String employeeName;
  final DateTime date;
  const LeaveApplicationContainer({
    super.key,
    required this.employeeName,
    required this.date,
  });

  @override
  State<LeaveApplicationContainer> createState() =>
      _LeaveApplicationContainerState();
}

class _LeaveApplicationContainerState extends State<LeaveApplicationContainer> {
  Future<void> _showLeaveApplicationRejectDialogueBox() async {
    if (mounted) {
      return showDialog(
        context: context,
        builder: (BuildContext dialogueContext) {
          return AlertDialog(
            title: const Text("Reject Leave Application"),
            backgroundColor: Colors.black,
            surfaceTintColor: Colors.green.shade100,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            content: const Text(
              "Do you really want to reject this leave application?",
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
                  "Reject",
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

  Future<void> _showLeaveApplicationAcceptDialogueBox() async {
    if (mounted) {
      return showDialog(
        context: context,
        builder: (BuildContext dialogueContext) {
          return AlertDialog(
            title: const Text("Accept Leave Application"),
            backgroundColor: Colors.black,
            surfaceTintColor: Colors.green.shade100,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            content: const Text(
              "Do you really want to accept this leave application?",
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
                  "Accept",
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
    final dateFormat = DateFormat("dd/MM/yyyy");

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.05,
        vertical: screenSize.height * 0.01,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomColumnWidget(
                title: 'Employee Name',
                value: widget.employeeName,
                crossAxisAlignment: CrossAxisAlignment.start,
                titleStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                valueStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              CustomColumnWidget(
                title: 'Date',
                value: dateFormat.format(widget.date),
                crossAxisAlignment: CrossAxisAlignment.end,
                titleStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                valueStyle: const TextStyle(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _showLeaveApplicationRejectDialogueBox,
                child: const Text(
                  "Reject",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton(
                onPressed: _showLeaveApplicationAcceptDialogueBox,
                child: const Text(
                  "Accept",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
