import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:evcareserviceapp/common_utils/local_storage.dart';
import 'package:evcareserviceapp/common_utils/urls.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/models/employee_profile_model.dart';

Future<EmployeeProfileModel> getEmployeeProfileDetails() async {
  try {
    int employeeId = await LocalStorage.getEmployeeId();
    Map<String, dynamic> params = {
      "id": employeeId.toString(),
    };

    final url = Uri.parse(Urls.getEmplyeeProfileDetailsUrl)
        .replace(queryParameters: params);

    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(resp.body);
      final response = EmployeeProfileModel.fromJson(decoded);

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
