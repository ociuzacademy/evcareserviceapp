// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AttendanceContainer extends StatelessWidget {
  final String employeeName;
  final String status;
  const AttendanceContainer({
    super.key,
    required this.employeeName,
    required this.status,
  });

  Color _getColor() {
    // "present", , "onleave"
    switch (status) {
      case "present":
        return Colors.greenAccent;
      case "absent":
        return Colors.redAccent;
      default:
        return Colors.orangeAccent;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            employeeName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.005,
          ),
          Text(
            "Status: $status",
            style: TextStyle(
              color: _getColor(),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
