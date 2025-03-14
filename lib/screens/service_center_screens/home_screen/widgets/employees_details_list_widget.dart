// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:evcareserviceapp/common_models/employee_details_model.dart';
import 'package:evcareserviceapp/common_widgets/employee_container.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/services/get_present_employees_list.dart';

class EmployeesDetailsListWidget extends StatefulWidget {
  const EmployeesDetailsListWidget({
    super.key,
  });

  @override
  State<EmployeesDetailsListWidget> createState() =>
      _EmployeesDetailsListWidgetState();
}

class _EmployeesDetailsListWidgetState
    extends State<EmployeesDetailsListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return FutureBuilder<List<EmployeeDetailsModel>>(
      future: getPresentEmployeesList(),
      builder: (context, snapshot) {
        // Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
          );
        }

        // Error State
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

        // Empty Response data array
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

        // Success State
        List<EmployeeDetailsModel> employees = snapshot.data!;
        return SliverList.list(
          children: [
            const Text(
              "Employees present today",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.separated(
              itemBuilder: (context, index) => EmployeeContainer(
                employeeName: employees[index].name,
                email: employees[index].email,
                phoneNumber: employees[index].phoneNumber,
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: screenSize.height * 0.01,
              ),
              itemCount: employees.length,
            )
          ],
        );
      },
    );
    //
  }
}
