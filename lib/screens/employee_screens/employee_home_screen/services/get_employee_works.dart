import 'dart:convert';
import 'dart:io';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/models/employee_work_model.dart';
import 'package:http/http.dart' as http;

import 'package:evcareserviceapp/common_utils/urls.dart';

Future<List<EmployeeWorkModel>> getEmployeeWorks({
  required int employeeId,
}) async {
  try {
    Map<String, dynamic> params = {
      "employee": employeeId.toString(),
    };

    final url =
        Uri.parse(Urls.getEmployeeWorksUrl).replace(queryParameters: params);

    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (resp.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(resp.body);
      final response =
          decoded.map((item) => EmployeeWorkModel.fromJson(item)).toList();

      return response;
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(resp.body);
      throw Exception(
        '${errorResponse['message'] ?? 'Unknown error'}',
      );
    }
  } on SocketException {
    throw Exception('Server error');
  } on HttpException {
    throw Exception('Something went wrong');
  } on FormatException {
    throw Exception('Bad request');
  } catch (e) {
    throw Exception(e.toString());
  }
}
