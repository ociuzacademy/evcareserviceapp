// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/common_utils/helper.dart';
import 'package:evcareserviceapp/common_widgets/number_text_field_without_icon.dart';
import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/views/home_screen.dart';
import 'package:evcareserviceapp/screens/service_center_screens/update_product_screen/services/update_product.dart';

class UpdateProductData extends StatefulWidget {
  final int productId;
  final double currentProductPrice;
  final int currentProductQuantity;
  const UpdateProductData({
    super.key,
    required this.productId,
    required this.currentProductPrice,
    required this.currentProductQuantity,
  });

  @override
  State<UpdateProductData> createState() => _UpdateProductDataState();
}

class _UpdateProductDataState extends State<UpdateProductData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _productPriceController;
  late TextEditingController _productQuantityController;

  bool _isUpdatingProduct = false;

  @override
  void initState() {
    super.initState();
    _productPriceController = TextEditingController(
      text: widget.currentProductPrice.toStringAsFixed(2),
    );
    _productQuantityController = TextEditingController(
      text: widget.currentProductQuantity.toString(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _productPriceController.dispose();
    _productQuantityController.dispose();
  }

  Future<void> _updateProduct() async {
    // Validate will return true if the form is valid, or false if
    // the form is invalid.
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isUpdatingProduct = true;
      });
      try {
        String newPrice = _productPriceController.text.trim();
        String newQuantity = _productQuantityController.text.trim();
        final response = await updateProduct(
          productId: widget.productId,
          productPrice: widget.currentProductPrice != double.parse(newPrice)
              ? newPrice
              : null,
          productQuantity:
              widget.currentProductQuantity != int.parse(newQuantity)
                  ? newQuantity
                  : null,
        );
        if (response.status == "success" && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message),
            ),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      } catch (e) {
        // Handle the error, e.g., show a snackbar
        if (mounted) {
          final errorMessage = e.toString();
          showErrorDialogue(
            context,
            "Updating product failed due to $errorMessage",
          );
        }
      } finally {
        setState(() {
          _isUpdatingProduct = false;
        });
      }
    } else {
      if (mounted) {
        showErrorDialogue(
          context,
          "Please fill all fields.",
        );
      }
    }
  }

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
      body: _isUpdatingProduct
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
                        NumberTextFieldWithoutIcon(
                          hintText: 'Enter new product price',
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter new product price';
                            }

                            return null;
                          },
                          numberEditingController: _productPriceController,
                        ),
                        SizedBox(
                          height: screenSize.height / 50,
                        ),
                        NumberTextFieldWithoutIcon(
                          hintText: 'Enter new product quantity',
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter new product quantity';
                            }

                            return null;
                          },
                          numberEditingController: _productQuantityController,
                        ),
                        SizedBox(
                          height: screenSize.height / 50,
                        ),
                        PaddedElevatedButton(
                          buttonText: "Update Product",
                          onPressed: _updateProduct,
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
