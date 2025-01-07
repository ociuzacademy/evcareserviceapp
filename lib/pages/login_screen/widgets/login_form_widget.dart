// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/common_widgets/form_text_field.dart';
import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:evcareserviceapp/common_widgets/rich_text_widget.dart';
import 'package:flutter/material.dart';

class LoginFormWidget extends StatefulWidget {
  final String imageUrl;
  final String bottomMessage;
  final Widget formRedirect;
  final Widget formDestination;
  const LoginFormWidget({
    super.key,
    required this.imageUrl,
    required this.bottomMessage,
    required this.formRedirect,
    required this.formDestination,
  });

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Small screen: Display a column
          return Center(
            child: SingleChildScrollView(
              child: SizedBox(
                height: screenSize.height - 50.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(widget.imageUrl),
                      radius: 90,
                    ),
                    SizedBox(
                      height: screenSize.height / 50,
                    ),
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            FormTextField(
                              textFieldIcon: const Icon(Icons.perm_identity),
                              hintText: 'Enter your username',
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
                            FormTextField(
                              textFieldIcon: const Icon(Icons.password),
                              hintText: 'Enter your password',
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }

                                if (value.length < 6) {
                                  return 'Password must have at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: screenSize.height / 50,
                            ),
                            RichTextWidget(
                              bottomMessage: widget.bottomMessage,
                              formRedirect: widget.formRedirect,
                            ),
                            PaddedElevatedButton(
                              onPressed: () {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                if (_formKey.currentState!.validate()) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          widget.formDestination,
                                    ),
                                  );
                                }
                              },
                              buttonText: "Login",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          // Large screen: Display a row
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/login_screen.png"),
              ],
            ),
          );
        }
      },
    );
  }
}
