import 'dart:math';

import 'package:evcareserviceapp/pages/home_screen/utils/helper.dart';
import 'package:evcareserviceapp/pages/home_screen/widgets/home_page_widget.dart';
import 'package:evcareserviceapp/pages/home_screen/widgets/product_list.dart';
import 'package:evcareserviceapp/pages/home_screen/widgets/purchase_history_widget.dart';
import 'package:evcareserviceapp/pages/home_screen/widgets/repair_requests_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static List<Map<String, dynamic>> products = List.generate(
    20,
    (index) {
      final random = Random();
      return {
        "id": index,
        "name": "Product ${index + 1}",
        "description":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus pellentesque, augue nec molestie scelerisque, felis massa efficitur augue, in convallis eros libero eu lacus. Nulla mauris risus, feugiat et libero et, tincidunt tristique diam. Maecenas eu turpis pellentesque, bibendum ex nec, tincidunt elit. Maecenas ultricies hendrerit sapien, in tincidunt dui aliquet et. Fusce ac nulla sit amet dolor consequat tincidunt. Vestibulum finibus cursus fermentum. Vivamus pulvinar mauris orci, at lobortis lorem facilisis nec. Mauris in porttitor nisl, nec tincidunt lorem.",
        "price": random.nextDouble() * 1000,
        "quantity": random.nextInt(100),
        "image": "https://picsum.photos/id/${random.nextInt(100)}/200/200",
        "heroId": "hero-$index"
      };
    },
  );

  static List<Map<String, dynamic>> purchaseHistory = List.generate(
    10,
    (index) {
      final random = Random();
      final randomIndex = random.nextInt(products.length);
      final Map<String, dynamic> product = products[randomIndex];
      final int quantity = random.nextInt(10);
      final DateTime date = generateRandomDate();
      return {
        "id": index,
        "customerName": "Customer - ${index + 1}",
        "productName": product['name'],
        "unitPrice": product["price"],
        "quantity": quantity,
        "productCost": product["price"] * quantity,
        "purchaseDate": date,
      };
    },
  );

  static List<Map<String, dynamic>> repairRequests = List.generate(
    20,
    (index) {
      final random = Random();
      final String vehicleNumber = generateKeralaVehicleNumber();
      const String description =
          "Lorem ipsum dolor sit amet. Aut blanditiis enim est possimus nihil quo deserunt distinctio sit adipisci voluptas nam unde consequatur et consequuntur illo eos commodi explicabo. Et quae alias eum laborum omnis ut nostrum adipisci et possimus sequi eos reiciendis corporis qui ullam magni vel quia sunt.";
      final DateTime createdAt = generateRandomDate();
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
      final String mechanicName = selectedIndex == 0 ? "" : "Mechanic - $index";
      return {
        "customerName": "Customer - ${index + 1}",
        "vehicleNumber": vehicleNumber,
        "description": description,
        "mechanicName": mechanicName,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "currentStatus": currentStatus,
        "repairCost": repairCost
      };
    },
  );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;

  final PageController _pageController = PageController();

  final List<Widget> _appBodies = [
    const Center(child: HomePageWidget()),
    Center(
      child: ProductList(
        products: HomeScreen.products,
      ),
    ),
    Center(
      child: PurchaseHistoryWidget(
        purchaseHistory: HomeScreen.purchaseHistory,
      ),
    ),
    Center(
      child: RepairRequestsWidget(
        repairRequests: HomeScreen.repairRequests,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
