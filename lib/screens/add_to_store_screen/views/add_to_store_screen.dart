import 'dart:io';

import 'package:evcareserviceapp/common_widgets/form_text_field_without_icon.dart';
import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddToStoreScreen extends StatefulWidget {
  const AddToStoreScreen({super.key});

  @override
  State<AddToStoreScreen> createState() => _AddToStoreScreenState();
}

class _AddToStoreScreenState extends State<AddToStoreScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();

  bool isImageSelected = false;
  File? imageFile;

  Future<void> _showErrorDialogue(String message) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }

  _pickImageFromGallary() async {
    try {
      final XFile? pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
          isImageSelected = true;
        });
      }
    } catch (e) {
      // print('Error: ${e.toString()}');
      _showErrorDialogue('Error: ${e.toString()}');
    }
  }

  _pickImageFromCamera() async {
    try {
      final XFile? pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
          isImageSelected = true;
        });
      }
    } catch (e) {
      // print('Error: ${e.toString()}');
      _showErrorDialogue('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
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
                  SizedBox(
                    height: screenSize.height / 50,
                  ),
                  FormTextFieldWithoutIcon(
                    hintText: 'Enter product name',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product name';
                      }

                      return null;
                    },
                    textEditingController: _productNameController,
                  ),
                  SizedBox(
                    height: screenSize.height / 50,
                  ),
                  FormTextFieldWithoutIcon(
                    hintText: 'Enter product description',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product description';
                      }

                      return null;
                    },
                    textEditingController: _productDescriptionController,
                  ),
                  SizedBox(
                    height: screenSize.height / 50,
                  ),
                  FormTextFieldWithoutIcon(
                    hintText: 'Enter product price',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product price';
                      }

                      return null;
                    },
                    textEditingController: _productPriceController,
                  ),
                  SizedBox(
                    height: screenSize.height / 50,
                  ),
                  FormTextFieldWithoutIcon(
                    hintText: 'Enter product quantity',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product quantity';
                      }

                      return null;
                    },
                    textEditingController: _productQuantityController,
                  ),
                  SizedBox(
                    height: screenSize.height / 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.green,
                          ),
                        ),
                        onPressed: _pickImageFromGallary,
                        icon: const Icon(
                          Icons.add_photo_alternate,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.green,
                          ),
                        ),
                        onPressed: _pickImageFromCamera,
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  PaddedElevatedButton(
                    buttonText: "Add Product",
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                    },
                  ),
                  isImageSelected
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                              image: FileImage(imageFile!),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
