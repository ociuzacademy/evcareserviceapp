// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/common_utils/helper.dart';
import 'package:evcareserviceapp/screens/service_center_screens/employee_section_screen/services/approve_leave.dart';
import 'package:evcareserviceapp/screens/service_center_screens/employee_section_screen/services/reject_leave.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/views/home_screen.dart';
import 'package:flutter/material.dart';

class AttendanceContainer extends StatefulWidget {
  final int employeeId;
  final String employeeName;
  final String status;
  const AttendanceContainer({
    super.key,
    required this.employeeId,
    required this.employeeName,
    required this.status,
  });

  @override
  State<AttendanceContainer> createState() => _AttendanceContainerState();
}

class _AttendanceContainerState extends State<AttendanceContainer> {
  bool _isLoading = false;
  Color _getColor() {
    // "present", , "onleave"
    switch (widget.status) {
      case "Present":
        return Colors.greenAccent;
      case "Absent":
        return Colors.redAccent;
      case "Leave Approved":
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
                onPressed: _isLoading
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
                onPressed: _isLoading
                    ? null
                    : () {
                        Navigator.of(dialogueContext).pop(); // Close the dialog
                        onActionPressed(); // Execute the passed function
                      },
                child: Text(
                  _isLoading ? "Loading..." : actionText,
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

  Future<void> _approveLeave() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await approveLeave(
        employeeId: widget.employeeId,
      );
      if (response.status == "success" && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } catch (e) {
      // Handle the error, e.g., show a snackbar
      if (mounted) {
        final errorMessage = e.toString();
        showErrorDialogue(
          context,
          "Approving employee leave failed due to $errorMessage",
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _rejectLeave() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await rejectLeave(
        employeeId: widget.employeeId,
      );
      if (response.status == "success" && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } catch (e) {
      // Handle the error, e.g., show a snackbar
      if (mounted) {
        final errorMessage = e.toString();
        showErrorDialogue(
          context,
          "Rejecting employee leave failed due to $errorMessage",
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          )
        : Container(
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
                        fontSize: 18,
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: widget.status,
                            style: TextStyle(
                              color: _getColor(),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                widget.status == "Absent"
                    ? Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.black,
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                              _showActionDialogueBox(
                                title: "Reject Leave",
                                content:
                                    "Do you want to reject this employee's leave?",
                                actionText: "Reject",
                                onActionPressed: _rejectLeave,
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
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                              _showActionDialogueBox(
                                title: "Approve Leave",
                                content:
                                    "Do you want to approve this employee's leave?",
                                actionText: "Accept",
                                onActionPressed: _approveLeave,
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
