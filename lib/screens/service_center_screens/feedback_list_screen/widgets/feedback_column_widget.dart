// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class FeedbackColumnWidget extends StatelessWidget {
  final String title;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;
  const FeedbackColumnWidget({
    super.key,
    required this.title,
    required this.value,
    required this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
