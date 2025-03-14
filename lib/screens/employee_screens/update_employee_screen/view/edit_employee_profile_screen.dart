// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/common_utils/helper.dart';
import 'package:evcareserviceapp/common_widgets/form_text_field_without_icon.dart';
import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:evcareserviceapp/screens/employee_screens/update_employee_screen/service/edit_employee_profile.dart';
import 'package:evcareserviceapp/screens/service_center_screens/add_employee_screen/widgets/email_text_field_without_icon.dart';
import 'package:evcareserviceapp/screens/service_center_screens/add_employee_screen/widgets/password_text_field_without_icon.dart';
import 'package:evcareserviceapp/screens/service_center_screens/add_employee_screen/widgets/phone_number_text_field_without_icon.dart';
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/models/employee_profile_model.dart';

class EditEmployeeProfileScreen extends StatefulWidget {
  final EmployeeProfileModel employeeProfileModel;
  const EditEmployeeProfileScreen({
    super.key,
    required this.employeeProfileModel,
  });

  @override
  State<EditEmployeeProfileScreen> createState() =>
      _EditEmployeeProfileScreenState();
}

class _EditEmployeeProfileScreenState extends State<EditEmployeeProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController = TextEditingController();
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isEditingProfile = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(
      text: widget.employeeProfileModel.username,
    );
    _nameController = TextEditingController(
      text: widget.employeeProfileModel.name,
    );
    _emailController = TextEditingController(
      text: widget.employeeProfileModel.email,
    );
    _phoneNumberController = TextEditingController(
      text: widget.employeeProfileModel.phoneNumber,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
  }

  Future<void> _addEmployee() async {
    // Validate will return true if the form is valid, or false if
    // the form is invalid.
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditingProfile = true;
      });
      try {
        final response = await editEmployeeProfile(
          username: widget.employeeProfileModel.username !=
                  _usernameController.text.trim()
              ? _usernameController.text.trim()
              : null,
          employeeName:
              widget.employeeProfileModel.name != _nameController.text.trim()
                  ? _nameController.text.trim()
                  : null,
          email:
              widget.employeeProfileModel.email != _emailController.text.trim()
                  ? _emailController.text.trim()
                  : null,
          phoneNumber: widget.employeeProfileModel.phoneNumber !=
                  _phoneNumberController.text.trim()
              ? _phoneNumberController.text.trim()
              : null,
          password: _passwordController.text.trim(),
        );
        if (response.status == "success" && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message),
            ),
          );
          Navigator.of(context).pop();
        }
      } catch (e) {
        // Handle the error, e.g., show a snackbar
        if (mounted) {
          final errorMessage = e.toString();
          showErrorDialogue(
            context,
            "Editing employee profile failed due to $errorMessage",
          );
        }
      } finally {
        setState(() {
          _isEditingProfile = false;
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
        title: const Text('Edit Employee Profile'),
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
      body: _isEditingProfile
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
                          hintText: 'Enter employee username',
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter employee username';
                            }

                            return null;
                          },
                          textEditingController: _usernameController,
                        ),
                        SizedBox(
                          height: screenSize.height / 50,
                        ),
                        FormTextFieldWithoutIcon(
                          hintText: 'Enter employee name',
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter employee name';
                            }

                            return null;
                          },
                          textEditingController: _nameController,
                        ),
                        SizedBox(
                          height: screenSize.height / 50,
                        ),
                        EmailTextFieldWithoutIcon(
                          hintText: 'Enter employee email',
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter employee email';
                            }

                            return null;
                          },
                          emailTextController: _emailController,
                        ),
                        SizedBox(
                          height: screenSize.height / 50,
                        ),
                        PhoneNumberTextFieldWithoutIcon(
                          hintText: 'Enter employee phone number',
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter employee phone number';
                            }

                            return null;
                          },
                          phoneNumberTextController: _phoneNumberController,
                        ),
                        SizedBox(
                          height: screenSize.height / 50,
                        ),
                        PasswordTextFieldWithoutIcon(
                          hintText: 'Enter employee password',
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }

                            if (value.length < 6) {
                              return 'Password must have at least 6 characters';
                            }
                            return null;
                          },
                          passwordTextController: _passwordController,
                        ),
                        SizedBox(
                          height: screenSize.height / 50,
                        ),
                        PaddedElevatedButton(
                          buttonText: "Add Employee",
                          onPressed: _addEmployee,
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
