import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/widgets/employee_homp_page_widget.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/widgets/employee_profile_widget.dart';
import 'package:flutter/material.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  int _currentPageIndex = 0;

  final PageController _pageController = PageController();

  final List<Widget> _appBodies = [
    const EmployeeHompPageWidget(),
    const EmployeeProfileWidget(),
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
      body: _appBodies.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : PageView(
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
