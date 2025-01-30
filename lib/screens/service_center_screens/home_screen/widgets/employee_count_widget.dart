import 'package:evcareserviceapp/screens/service_center_screens/home_screen/models/employee_count_model.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/services/get_employees_count.dart';
import 'package:flutter/material.dart';

class EmployeeCountWidget extends StatelessWidget {
  const EmployeeCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EmployeeCountModel>(
      future: getEmployeesCount(),
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
        if (!snapshot.hasData || snapshot.data == null) {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  Image.asset("assets/images/empty.png"),
                  const Text(
                    "Unable to get data",
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
        EmployeeCountModel employeeCountData = snapshot.data!;
        return SliverToBoxAdapter(
          child: Text(
            "Total number of employees: ${employeeCountData.employeeCount}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
