// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RepairRequestsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> repairRequests;
  const RepairRequestsWidget({
    super.key,
    required this.repairRequests,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
    );
  }
}
