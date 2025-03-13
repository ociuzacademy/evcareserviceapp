// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class EmployeeContainer extends StatelessWidget {
  const EmployeeContainer({
    super.key,
    required this.employeeName,
    required this.email,
    required this.phoneNumber,
  });

  final String employeeName;
  final String email;
  final String phoneNumber;

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
            "Name: $employeeName",
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
            "Email: $email",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.005,
          ),
          Text(
            "Phone: $phoneNumber",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
