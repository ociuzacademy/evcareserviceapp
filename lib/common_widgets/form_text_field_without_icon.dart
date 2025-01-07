// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class FormTextFieldWithoutIcon extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final String? initialValue;
  const FormTextFieldWithoutIcon({
    super.key,
    required this.hintText,
    this.validator,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true, // Enable background color
        fillColor: Colors.white, // Set background color
        hintStyle: const TextStyle(
          color: Colors.grey,
        ), // Hint text color
        enabledBorder: const OutlineInputBorder(
          // Border when not focused
          borderSide: BorderSide(
            color: Colors.green,
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          // Border when focused
          borderSide: BorderSide(
            color: Colors.lightGreen,
            width: 2.5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          // Border when validation fails
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          // Border when focused and validation fails
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 2.5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
      ), // Input text color
      validator: validator,
    );
  }
}
