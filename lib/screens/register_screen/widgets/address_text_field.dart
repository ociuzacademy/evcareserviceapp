// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AddressTextField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController addressTextController;
  const AddressTextField({
    super.key,
    required this.hintText,
    this.validator,
    required this.addressTextController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_box),
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
      ),
      minLines: 3,
      maxLines: 6,
      keyboardType: TextInputType.multiline,
      validator: validator,
      controller: addressTextController,
    );
  }
}
