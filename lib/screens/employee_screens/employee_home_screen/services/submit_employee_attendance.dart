import 'dart:convert';
import 'dart:io';
import 'package:evcareserviceapp/common_utils/local_storage.dart';
import 'package:http/http.dart' as http;

import 'package:evcareserviceapp/common_utils/urls.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/models/employee_attendance_response_model.dart';

Future<EmployeeAttendanceResponseModel> submitEmployeeAttendance() async {
  try {
    int employeeId = await LocalStorage.getEmployeeId();
    Map<String, dynamic> params = {
      "employee": employeeId,
    };

    final resp = await http.post(
      Uri.parse(Urls.submitAttendanceUrl),
      body: jsonEncode(params),
      headers: <String, String>{
        "Content-Type": "application/json; charset=utf-8"
      },
    );

    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(resp.body);
      final EmployeeAttendanceResponseModel response =
          EmployeeAttendanceResponseModel.fromJson(decoded);
      return response;
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(resp.body);
      throw Exception(
        '${errorResponse['message'] ?? 'Unknown error'}',
      );
    }
  } on SocketException {
    throw Exception('No Internet connection');
  } on HttpException {
    throw Exception('Server error');
  } on FormatException {
    throw Exception('Bad response format');
  } catch (e) {
    throw Exception('Unexpected error: ${e.toString()}');
  }
}
