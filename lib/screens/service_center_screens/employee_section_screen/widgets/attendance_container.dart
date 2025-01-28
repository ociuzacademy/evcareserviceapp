// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AttendanceContainer extends StatefulWidget {
  final String employeeName;
  final String status;
  const AttendanceContainer({
    super.key,
    required this.employeeName,
    required this.status,
  });

  @override
  State<AttendanceContainer> createState() => _AttendanceContainerState();
}

class _AttendanceContainerState extends State<AttendanceContainer> {
  Color _getColor() {
    // "present", , "onleave"
    switch (widget.status) {
      case "present":
        return Colors.greenAccent;
      case "absent":
        return Colors.redAccent;
      case "leave approved":
        return Colors.blueAccent;
      default:
        return Colors.orangeAccent;
    }
  }

  Future<void> _showActionDialogueBox({
    required String title,
    required String content,
    required String actionText,
    required VoidCallback onActionPressed, // Callback function parameter
  }) async {
    if (mounted) {
      return showDialog(
        context: context,
        builder: (BuildContext dialogueContext) {
          return AlertDialog(
            title: Text(title),
            backgroundColor: Colors.black,
            surfaceTintColor: Colors.green.shade100,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            content: Text(
              content,
              style: const TextStyle(
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
                  Navigator.of(dialogueContext).pop(); // Close the dialog
                  onActionPressed(); // Execute the passed function
                },
                child: Text(
                  actionText,
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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.employeeName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.005,
              ),
              RichText(
                text: TextSpan(
                  text: "Status: ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: widget.status,
                      style: TextStyle(
                        color: _getColor(),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          widget.status == "absent"
              ? Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        _showActionDialogueBox(
                          title: "Reject Leave",
                          content:
                              "Do you want to reject this employee's leave?",
                          actionText: "Reject",
                          onActionPressed: () {},
                        );
                      },
                      child: const Text("Reject"),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.05,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        _showActionDialogueBox(
                          title: "Approve Leave",
                          content:
                              "Do you want to approve this employee's leave?",
                          actionText: "Accept",
                          onActionPressed: () {},
                        );
                      },
                      child: const Text("Approve"),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
