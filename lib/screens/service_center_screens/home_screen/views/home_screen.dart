import 'package:evcareserviceapp/screens/service_center_screens/edit_profile_screen/view/edit_profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/common_utils/local_storage.dart';
import 'package:evcareserviceapp/screens/common_screens/login_screen/views/login_screen.dart';
import 'package:evcareserviceapp/screens/service_center_screens/employee_section_screen/views/employee_section_screen.dart';
import 'package:evcareserviceapp/screens/service_center_screens/feedback_list_screen/view/feedback_list_screen.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/home_page_widget.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/product_list.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/purchase_history_widget.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/repair_requests_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;

  final PageController _pageController = PageController();

  late List<Widget> _appBodies;

  void _logout() async {
    await LocalStorage.serviceCentreLogout();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    // Initialize app bodies
    _appBodies = [
      const Center(
        child: HomePageWidget(),
      ),
      const Center(
        child: ProductList(),
      ),
      const Center(
        child: PurchaseHistoryWidget(),
      ),
      const Center(
        child: RepairRequestsWidget(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("EV Service Center"),
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
              icon: Icon(Icons.store),
              label: "Store",
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_checkout),
              label: "Purchase History",
            ),
            NavigationDestination(
              icon: Icon(Icons.build),
              label: "Repair Requests",
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
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            SizedBox(
              height: screenSize.height * 0.15,
            ),
            ListTile(
              leading: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              title: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.feedback,
                color: Colors.white,
              ),
              title: const Text(
                'Feedbacks',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FeedbackListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.group,
                color: Colors.white,
              ),
              title: const Text(
                'Employees',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EmployeeSectionScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                'Log out',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }
}
