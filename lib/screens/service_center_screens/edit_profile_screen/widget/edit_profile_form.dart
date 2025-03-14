// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:evcareserviceapp/common_utils/helper.dart';
import 'package:evcareserviceapp/common_utils/urls.dart';
import 'package:evcareserviceapp/common_widgets/form_text_field.dart';
import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:evcareserviceapp/screens/common_screens/register_screen/widgets/address_text_field.dart';
import 'package:evcareserviceapp/screens/common_screens/register_screen/widgets/email_text_field.dart';
import 'package:evcareserviceapp/screens/common_screens/register_screen/widgets/phone_number_text_field.dart';
import 'package:evcareserviceapp/screens/service_center_screens/edit_profile_screen/service/edit_service_centre.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/views/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/common_models/service_center_profile_model.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileForm extends StatefulWidget {
  final ServiceCentreProfileModel profileModel;
  const EditProfileForm({
    super.key,
    required this.profileModel,
  });

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController = TextEditingController();
  late TextEditingController _serviceCentreNameController =
      TextEditingController();
  late TextEditingController _addressController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _phoneNumberController = TextEditingController();

  bool _isEditing = false;
  File? _selectedImage;

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _usernameController.dispose();
    _serviceCentreNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(
      text: widget.profileModel.username,
    );
    _serviceCentreNameController = TextEditingController(
      text: widget.profileModel.name,
    );
    _addressController = TextEditingController(
      text: widget.profileModel.address,
    );
    _emailController = TextEditingController(
      text: widget.profileModel.email,
    );
    _phoneNumberController = TextEditingController(
      text: widget.profileModel.phone,
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _editServiceCentre() async {
    if (_formKey.currentState!.validate() && _selectedImage != null) {
      setState(() {
        _isEditing = true;
      });
      try {
        final response = await editServiceCentre(
          userName:
              widget.profileModel.username != _usernameController.text.trim()
                  ? _usernameController.text.trim()
                  : null,
          serviceCentreName: widget.profileModel.name !=
                  _serviceCentreNameController.text.trim()
              ? _serviceCentreNameController.text.trim()
              : null,
          address: widget.profileModel.address != _addressController.text.trim()
              ? _addressController.text.trim()
              : null,
          email: widget.profileModel.email != _emailController.text.trim()
              ? _emailController.text.trim()
              : null,
          phoneNumber:
              widget.profileModel.phone != _phoneNumberController.text.trim()
                  ? _phoneNumberController.text.trim()
                  : null,
          image: _selectedImage,
        );
        bool status = response.status == "success";

        if (status && mounted) {
          // Use context here because mounted is true
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
          // Use context here because mounted is true
          final errorMessage = e.toString();
          showErrorDialogue(
            context,
            "Registration failed due to $errorMessage.",
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isEditing = false;
          });
        }
      }
    } else {
      if (mounted) {
        // Use context here because this is synchronous
        showErrorDialogue(
          context,
          "Please fill all fields, and upload image.",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return _isEditing
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          )
        : Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : widget.profileModel.image != null
                              ? NetworkImage(
                                  "${Urls.baseUrl}${widget.profileModel.image!}",
                                )
                              : null,
                      backgroundColor: Colors.grey,
                      radius: 90,
                      child: _selectedImage == null
                          ? const Icon(Icons.camera_alt,
                              color: Colors.white, size: 40)
                          : null,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.75,
                    width: screenSize.width * 0.75,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          FormTextField(
                            textFieldIcon: const Icon(Icons.perm_identity),
                            hintText: 'Enter your username',
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                            formTextController: _usernameController,
                          ),
                          SizedBox(
                            height: screenSize.height * 0.01,
                          ),
                          FormTextField(
                            textFieldIcon: const Icon(Icons.store),
                            hintText: 'Enter service centre name',
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter service centre name';
                              }
                              return null;
                            },
                            formTextController: _serviceCentreNameController,
                          ),
                          SizedBox(
                            height: screenSize.height * 0.01,
                          ),
                          AddressTextField(
                            hintText: 'Enter address',
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter address';
                              }
                              return null;
                            },
                            addressTextController: _addressController,
                          ),
                          SizedBox(
                            height: screenSize.height * 0.01,
                          ),
                          EmailTextField(
                            hintText: "Enter your email",
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            emailTextController: _emailController,
                          ),
                          SizedBox(
                            height: screenSize.height * 0.01,
                          ),
                          PhoneNumberTextField(
                            hintText: 'Enter your phone number',
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phone number';
                              }
                              return null;
                            },
                            phoneNumberTextController: _phoneNumberController,
                          ),
                          SizedBox(
                            height: screenSize.height * 0.01,
                          ),
                          SizedBox(
                            height: screenSize.height * 0.01,
                          ),
                          PaddedElevatedButton(
                            buttonText: "Edit Profile",
                            onPressed: _editServiceCentre,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
