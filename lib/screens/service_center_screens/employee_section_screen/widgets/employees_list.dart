// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/common_widgets/employee_container.dart';
import 'package:evcareserviceapp/screens/service_center_screens/employee_section_screen/models/employee_model.dart';
import 'package:evcareserviceapp/screens/service_center_screens/employee_section_screen/services/get_employee_details_list.dart';
import 'package:flutter/material.dart';

class EmployeesList extends StatefulWidget {
  const EmployeesList({
    super.key,
  });

  @override
  State<EmployeesList> createState() => _EmployeesListState();
}

class _EmployeesListState extends State<EmployeesList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return FutureBuilder<List<EmployeeModel>>(
      future: getEmployeeDetailsList(),
      builder: (context, snapshot) {
        // Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        }

        // Error State
        if (snapshot.hasError) {
          return Center(
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
          );
        }

        // Empty Response data array
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              children: [
                Image.asset("assets/images/empty.png"),
                const Text(
                  "No employees found",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          );
        }

        // Success State
        List<EmployeeModel> employees = snapshot.data!;
        return ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: screenSize.height * 0.025,
          ),
          itemBuilder: (context, index) {
            return EmployeeContainer(
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
  }
}
