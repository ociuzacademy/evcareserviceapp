// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/screens/service_center_screens/add_employee_screen/views/add_employee_screen.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/present_employee_container.dart';
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/service_center_details.dart';

class HomePageWidget extends StatefulWidget {
  final List<Map<String, dynamic>> employees;
  final int totalNumberOfEmployees;
  const HomePageWidget({
    super.key,
    required this.employees,
    required this.totalNumberOfEmployees,
  });

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddEmployeeScreen(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: ServiceCenterDetails(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: screenSize.height * 0.01,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                "Total number of employees: ${widget.totalNumberOfEmployees}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: screenSize.height * 0.01,
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                color: Colors.green,
              ),
            ),
            const SliverToBoxAdapter(
              child: Text(
                "Employees present today",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: screenSize.height * 0.01,
              ),
            ),
            SliverList.separated(
              itemBuilder: (context, index) {
                return PresentEmployeeContainer(
                  employeeName: widget.employees[index]['employeeName'],
                  email: widget.employees[index]['email'],
                  phoneNumber: widget.employees[index]['phoneNumber'],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: screenSize.height * 0.01,
                );
              },
              itemCount: widget.employees.length,
            )
          ],
        ),
      ),
    );
  }
}
