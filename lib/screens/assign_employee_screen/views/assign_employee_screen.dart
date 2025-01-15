import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:flutter/material.dart';

class AssignEmployeeScreen extends StatefulWidget {
  const AssignEmployeeScreen({super.key});

  static List<Map<String, dynamic>> employeeNamesToday = List.generate(
    10,
    (index) {
      return {"id": index, "name": "Employee - ${index + 1}"};
    },
  );

  @override
  State<AssignEmployeeScreen> createState() => _AssignEmployeeScreenState();
}

class _AssignEmployeeScreenState extends State<AssignEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  int _selectedEmployeeIndex = 0;

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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DropdownButtonFormField<Map<String, dynamic>>(
                value: AssignEmployeeScreen
                    .employeeNamesToday[_selectedEmployeeIndex],
                onChanged: (value) {
                  setState(() {
                    _selectedEmployeeIndex =
                        AssignEmployeeScreen.employeeNamesToday.indexOf(value!);
                  });
                },
                items: AssignEmployeeScreen.employeeNamesToday
                    .map<DropdownMenuItem<Map<String, dynamic>>>(
                  (item) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: item,
                      child: Text(
                        item['name'],
                        style: const TextStyle(color: Colors.white),
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
                validator: (value) =>
                    value == null ? 'Please select an employee' : null,
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
