import 'dart:math';

import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/widgets/employee_homp_page_widget.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/widgets/employee_profile_widget.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/utils/helper.dart';
import 'package:flutter/material.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();

  static List<Map<String, dynamic>> repairRequests = List.generate(
    20,
    (index) {
      final random = Random();
      final String vehicleNumber = Helper.generateKeralaVehicleNumber();
      const String description =
          "Lorem ipsum dolor sit amet. Aut blanditiis enim est possimus nihil quo deserunt distinctio sit adipisci voluptas nam unde consequatur et consequuntur illo eos commodi explicabo. Et quae alias eum laborum omnis ut nostrum adipisci et possimus sequi eos reiciendis corporis qui ullam magni vel quia sunt.";
      final DateTime createdAt = Helper.generateRandomDate();
      const List<String> statuses = [
        "Repair Requested",
        "Mechanic Assigned",
        "Repair Completed",
        "Vehicle Delivered"
      ];
      final int selectedIndex = random.nextInt(statuses.length);
      final DateTime updatedAt = createdAt.add(Duration(days: selectedIndex));
      final String currentStatus = statuses[selectedIndex];
      final double repairCost = random.nextDouble() * 1000;
      final int mechanicId = selectedIndex == 0 ? 0 : random.nextInt(10);
      final String mechanicName = selectedIndex == 0 ? "" : "Mechanic - $index";
      return {
        "customerName": "Customer - ${index + 1}",
        "vehicleNumber": vehicleNumber,
        "description": description,
        "mechanicId": mechanicId,
        "mechanicName": mechanicName,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "currentStatus": currentStatus,
        "repairCost": repairCost
      };
    },
  );
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  int _currentPageIndex = 0;

  final PageController _pageController = PageController();

  final List<Widget> _appBodies = [
    EmployeeHompPageWidget(
      repairRequests: EmployeeHomeScreen.repairRequests,
    ),
    const EmployeeProfileWidget(
      username: "employee_1",
      employeeName: "Employee - 1",
      email: "employee1@email.com",
      phoneNumber: "+919876543210",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Employee Home"),
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
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.green,
          backgroundColor: Colors.black,
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(
                  color: Colors.black,
                ); // Icon color for selected item
              }
              return const IconThemeData(
                color: Colors.white,
              ); // Icon color for unselected items
            },
          ),
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(
                  color: Colors.green, // Text color for selected item
                  fontWeight: FontWeight.bold,
                );
              }
              return const TextStyle(
                color: Colors.grey, // Text color for unselected items
                fontWeight: FontWeight.normal,
              );
            },
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
          selectedIndex: _currentPageIndex,
          // labelBehavior: ,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: _appBodies,
      ),
    );
  }
}
