import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:evcareserviceapp/common_utils/helper.dart';
import 'package:evcareserviceapp/common_widgets/form_text_field_without_icon.dart';
import 'package:evcareserviceapp/common_widgets/number_text_field_without_icon.dart';
import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:evcareserviceapp/screens/service_center_screens/add_to_store_screen/services/add_product.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/views/home_screen.dart';

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

  bool _isImageSelected = false;
  File? _imageFile;
  bool _isAddingProduct = false;

  @override
  void dispose() {
    super.dispose();
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _productPriceController.dispose();
    _productQuantityController.dispose();
  }

  _pickImageFromGallary() async {
    try {
      final XFile? pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _imageFile = File(pickedImage.path);
          _isImageSelected = true;
        });
      }
    } catch (e) {
      // print('Error: ${e.toString()}');
      if (mounted) {
        showErrorDialogue(context, 'Error: ${e.toString()}');
      }
    }
  }

  _pickImageFromCamera() async {
    try {
      final XFile? pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        setState(() {
          _imageFile = File(pickedImage.path);
          _isImageSelected = true;
        });
      }
    } catch (e) {
      // print('Error: ${e.toString()}');
      if (mounted) {
        showErrorDialogue(context, 'Error: ${e.toString()}');
      }
    }
  }

  Future<void> _addProduct() async {
    // Validate will return true if the form is valid, or false if
    // the form is invalid.
    if (_formKey.currentState!.validate() && _imageFile != null) {
      setState(() {
        _isAddingProduct = true;
      });
      try {
        final response = await addProduct(
          productName: _productNameController.text.trim(),
          productDescription: _productDescriptionController.text.trim(),
          productPrice: _productPriceController.text.trim(),
          productQuantity: _productQuantityController.text.trim(),
          productImage: _imageFile!,
        );

        bool status = response.status == "success";

        if (status && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message)),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          final errorMessage = e.toString();
          showErrorDialogue(
            context,
            "Adding new product failed due to $errorMessage",
          );
        }
      } finally {
        setState(() {
          _isAddingProduct = false;
        });
      }
    } else {
      if (mounted) {
        showErrorDialogue(
          context,
          "Please enter all the fields and select an image from either camera or gallery",
        );
      }
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
      body: _isAddingProduct
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : SingleChildScrollView(
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
                        NumberTextFieldWithoutIcon(
                          hintText: 'Enter product price',
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter product price';
                            }

                            return null;
                          },
                          numberEditingController: _productPriceController,
                        ),
                        SizedBox(
                          height: screenSize.height / 50,
                        ),
                        NumberTextFieldWithoutIcon(
                          hintText: 'Enter product quantity',
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter product quantity';
                            }

                            return null;
                          },
                          numberEditingController: _productQuantityController,
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
                          onPressed: _addProduct,
                        ),
                        _isImageSelected
                            ? Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image(
                                    image: FileImage(_imageFile!),
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
