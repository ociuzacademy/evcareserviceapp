// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/common_widgets/form_text_field.dart';
import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:evcareserviceapp/common_widgets/password_text_field.dart';
import 'package:evcareserviceapp/common_widgets/rich_text_widget.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/views/home_screen.dart';
import 'package:evcareserviceapp/screens/common_screens/login_screen/services/user_login.dart';
import 'package:evcareserviceapp/screens/common_screens/register_screen/views/register_screen.dart';
import 'package:flutter/material.dart';

class LoginFormWidget extends StatefulWidget {
  final String imageUrl;
  final String bottomMessage;
  const LoginFormWidget({
    super.key,
    required this.imageUrl,
    required this.bottomMessage,
  });

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoggingIn = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _serviceCenterLogin() async {
    // Validate will return true if the form is valid, or false if
    // the form is invalid.
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoggingIn = true;
      });
      try {
        final response = await userLogin(
          userName: _usernameController.text,
          password: _passwordController.text,
        );
        if (response.status == "success" && mounted) {
          if (response.utype == "owner") {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
        }
      } catch (e) {
        // Handle the error, e.g., show a snackbar
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login failed")),
          );
        }
      } finally {
        setState(() {
          _isLoggingIn = false;
        });
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all fields.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return _isLoggingIn
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          )
        : LayoutBuilder(
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
                                    textFieldIcon:
                                        const Icon(Icons.perm_identity),
                                    hintText: 'Enter your username',
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter username';
                                      }
                                      return null;
                                    },
                                    formTextController: _usernameController,
                                  ),
                                  SizedBox(
                                    height: screenSize.height / 50,
                                  ),
                                  PasswordTextField(
                                    hintText: 'Enter your password',
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
                                  RichTextWidget(
                                    bottomMessage: widget.bottomMessage,
                                    formRedirect: const RegisterScreen(),
                                  ),
                                  PaddedElevatedButton(
                                    onPressed: _serviceCenterLogin,
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
