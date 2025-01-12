import 'package:evcareserviceapp/screens/login_screen/views/login_screen.dart';
import 'package:evcareserviceapp/screens/register_screen/widgets/register_form_widget.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.black,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: const RegisterFormWidget(
        imageUrl: "assets/images/register_page_image.png",
        bottomMessage: "If you already have an account, ",
        formRedirect: LoginScreen(),
        formDestination: LoginScreen(),
      ),
    );
  }
}
