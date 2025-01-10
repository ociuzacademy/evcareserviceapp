// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/common_widgets/form_text_field_without_icon.dart';
import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';

class UpdateProductData extends StatefulWidget {
  final double currentProductPrice;
  final int currentProductQuantity;
  const UpdateProductData({
    super.key,
    required this.currentProductPrice,
    required this.currentProductQuantity,
  });

  @override
  State<UpdateProductData> createState() => _UpdateProductDataState();
}

class _UpdateProductDataState extends State<UpdateProductData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Product Data"),
        backgroundColor: Colors.black,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: screenSize.height - 100,
            width: screenSize.width - 50,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FormTextFieldWithoutIcon(
                    initialValue: widget.currentProductPrice.toStringAsFixed(2),
                    hintText: 'Enter new product price',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: screenSize.height / 50,
                  ),
                  FormTextFieldWithoutIcon(
                    initialValue: widget.currentProductQuantity.toString(),
                    hintText: 'Enter new product quantity',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: screenSize.height / 50,
                  ),
                  PaddedElevatedButton(
                    buttonText: "Update Product",
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
