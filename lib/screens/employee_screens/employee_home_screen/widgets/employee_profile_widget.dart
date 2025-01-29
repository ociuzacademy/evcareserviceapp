// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/common_utils/local_storage.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/services/get_employee_profile_details.dart';
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:evcareserviceapp/screens/common_screens/login_screen/views/login_screen.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/models/employee_profile_model.dart';

class EmployeeProfileWidget extends StatefulWidget {
  final int employeeId;
  const EmployeeProfileWidget({
    super.key,
    required this.employeeId,
  });

  @override
  State<EmployeeProfileWidget> createState() => _EmployeeProfileWidgetState();
}

class _EmployeeProfileWidgetState extends State<EmployeeProfileWidget> {
  void _logout() async {
    await LocalStorage.employeeLogout();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return FutureBuilder<EmployeeProfileModel>(
      future: getEmployeeProfileDetails(employeeId: widget.employeeId),
      builder: (context, snapshot) {
        // Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        }

        // Error State
        if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Image.asset("assets/images/error_image.png"),
                Text(
                  "${snapshot.error}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          );
        }

        // Empty Response data array
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            child: Column(
              children: [
                Image.asset("assets/images/empty.png"),
                const Text(
                  "No employee profile details found.",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          );
        }

        // Success State
        EmployeeProfileModel profileModel = snapshot.data!;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.04,
          ),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: const AssetImage(
                  "assets/icons/icons8-profile-picture-100.png",
                ),
                radius: screenSize.width * 0.2,
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              const Text(
                "My Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(
                color: Colors.green,
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Username:",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    profileModel.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Name:",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    profileModel.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Email:",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    profileModel.email,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Phone Number:",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    profileModel.phoneNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              PaddedElevatedButton(
                buttonText: "Logout",
                onPressed: _logout,
              ),
            ],
          ),
        );
      },
    );
  }
}
