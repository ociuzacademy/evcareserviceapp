import 'package:evcareserviceapp/common_widgets/form_text_field_without_icon.dart';
import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:evcareserviceapp/screens/add_employee_screen/widgets/email_text_field_without_icon.dart';
import 'package:evcareserviceapp/screens/add_employee_screen/widgets/password_text_field_without_icon.dart';
import 'package:evcareserviceapp/screens/add_employee_screen/widgets/phone_number_text_field_without_icon.dart';
import 'package:flutter/material.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _employeeUsernameController =
      TextEditingController();
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _employeeEmailController =
      TextEditingController();
  final TextEditingController _employeePhoneNumberController =
      TextEditingController();
  final TextEditingController _employeePasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _employeeUsernameController.dispose();
    _employeeNameController.dispose();
    _employeeEmailController.dispose();
    _employeePhoneNumberController.dispose();
    _employeePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Employee'),
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
                    hintText: 'Enter employee username',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter employee username';
                      }

                      return null;
                    },
                    textEditingController: _employeeUsernameController,
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
                    textEditingController: _employeeNameController,
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
                    emailTextController: _employeeEmailController,
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
                    phoneNumberTextController: _employeePhoneNumberController,
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
                    passwordTextController: _employeePasswordController,
                  ),
                  SizedBox(
                    height: screenSize.height / 50,
                  ),
                  PaddedElevatedButton(
                    buttonText: "Add Employee",
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
