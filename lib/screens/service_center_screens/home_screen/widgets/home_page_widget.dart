// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/screens/service_center_screens/add_employee_screen/views/add_employee_screen.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/employee_count_widget.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/employees_details_list_widget.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/service_centre_details.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({
    super.key,
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
            const ServiceCentreDetails(),
            SliverToBoxAdapter(
              child: SizedBox(
                height: screenSize.height * 0.01,
              ),
            ),
            const EmployeeCountWidget(),
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
            const EmployeesDetailsListWidget(),
          ],
        ),
      ),
    );
  }
}
