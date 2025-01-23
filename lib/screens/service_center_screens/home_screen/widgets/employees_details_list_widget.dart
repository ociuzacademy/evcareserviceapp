// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:evcareserviceapp/screens/service_center_screens/home_screen/models/employees_details_model.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/services/get_employees_details.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/present_employee_container.dart';
import 'package:flutter/material.dart';

class EmployeesDetailsListWidget extends StatelessWidget {
  const EmployeesDetailsListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return FutureBuilder<List<EmployeesDetailsModel>>(
      future: getEmployeesDetails(serviceCenterId: 2),
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
                  Image.asset("assets/images/empty.png"),
                  const Text(
                    "No products found",
                    style: TextStyle(
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

        // Success State
        List<EmployeesDetailsModel> employees = snapshot.data!;
        return SliverList.separated(
          itemBuilder: (context, index) {
            return PresentEmployeeContainer(
              employeeName: employees[index].name,
              email: employees[index].email,
              phoneNumber: employees[index].phoneNumber,
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: screenSize.height * 0.01,
            );
          },
          itemCount: employees.length,
        );
      },
    );
    //
  }
}
