import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:evcareserviceapp/screens/service_center_screens/assign_employee_screen/models/employee_model.dart';
import 'package:evcareserviceapp/screens/service_center_screens/assign_employee_screen/services/get_employees.dart';
import 'package:flutter/material.dart';

class AssignEmployeeScreen extends StatefulWidget {
  const AssignEmployeeScreen({super.key});

  @override
  State<AssignEmployeeScreen> createState() => _AssignEmployeeScreenState();
}

class _AssignEmployeeScreenState extends State<AssignEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedEmployeeIndex;
  List<EmployeeModel> _employees = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    try {
      final employees = await getEmployees(serviceCenterId: 2);
      setState(() {
        _employees = employees;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
        _isLoading = false;
      });
    }
  }

  void assignEmployee() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with submission
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Assign Employee'),
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : _errorMessage != null
              ? Center(
                  child: Column(
                    children: [
                      Image.asset("assets/images/error_image.png"),
                      Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                )
              : _employees.isEmpty
                  ? Center(
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
                    )
                  : Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            DropdownButtonFormField<int>(
                              value: _selectedEmployeeIndex,
                              onChanged: (value) {
                                setState(() {
                                  _selectedEmployeeIndex = value;
                                });
                              },
                              items: _employees.asMap().entries.map(
                                (entry) {
                                  final index = entry.key;
                                  final employee = entry.value;
                                  return DropdownMenuItem<int>(
                                    value: index,
                                    child: Text(
                                      employee.name,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  );
                                },
                              ).toList(),
                              dropdownColor: Colors.green,
                              decoration: const InputDecoration(
                                labelText: 'Select Employee',
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              ),
                              validator: (value) => value == null
                                  ? 'Please select an employee'
                                  : null,
                            ),
                            const SizedBox(height: 20),
                            PaddedElevatedButton(
                              onPressed: assignEmployee,
                              buttonText: 'Submit',
                            ),
                          ],
                        ),
                      ),
                    ),
    );
  }
}
