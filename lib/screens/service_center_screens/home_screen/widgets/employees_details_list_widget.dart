import 'package:flutter/material.dart';

import 'package:evcareserviceapp/common_models/employee_details_model.dart';
import 'package:evcareserviceapp/common_widgets/employee_container.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/services/get_present_employees_list.dart';

class EmployeesDetailsListWidget extends StatefulWidget {
  const EmployeesDetailsListWidget({super.key});

  @override
  State<EmployeesDetailsListWidget> createState() =>
      _EmployeesDetailsListWidgetState();
}

class _EmployeesDetailsListWidgetState
    extends State<EmployeesDetailsListWidget> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return FutureBuilder<List<EmployeeDetailsModel>>(
      future: getPresentEmployeesList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(color: Colors.green),
            ),
          );
        }

        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(
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
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  Image.asset("assets/images/no_employees_present_today.png"),
                ],
              ),
            ),
          );
        }

        List<EmployeeDetailsModel> employees = snapshot.data!;

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.005,
              ),
              child: EmployeeContainer(
                employeeName: employees[index].name,
                email: employees[index].email,
                phoneNumber: employees[index].phoneNumber,
              ),
            ),
            childCount: employees.length,
          ),
        );
      },
    );
  }
}
