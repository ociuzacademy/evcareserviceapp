// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DisabledPaddedElevatedButton extends StatelessWidget {
  final String buttonText;
  const DisabledPaddedElevatedButton({
    super.key,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Colors.grey,
          ),
        ),
        onPressed: null,
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
