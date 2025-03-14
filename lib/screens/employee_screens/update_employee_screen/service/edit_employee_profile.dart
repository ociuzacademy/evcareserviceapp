import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:evcareserviceapp/common_utils/local_storage.dart';
import 'package:evcareserviceapp/common_utils/urls.dart';
import 'package:evcareserviceapp/screens/employee_screens/update_employee_screen/model/edit_employee_profile_response_model.dart';

Future<EditEmployeeProfileResponseModel> editEmployeeProfile({
  String? username,
  String? employeeName,
  String? email,
  String? phoneNumber,
  String? password,
}) async {
  try {
    if (username == null &&
        employeeName == null &&
        email == null &&
        phoneNumber == null &&
        password == null) {
      throw Exception("No new data to edit");
    }

    int employeeId = await LocalStorage.getEmployeeId();
    Map<String, dynamic> params = {
      "id": employeeId.toString(),
    };

    if (username != null) params["username"] = username;
    if (employeeName != null) params["name"] = employeeName;
    if (email != null) params["email"] = email;
    if (phoneNumber != null) params["phone_number"] = phoneNumber;
    if (password != null) params["password"] = password;

    final resp = await http.patch(
      Uri.parse(Urls.editEmplyeeProfileUrl),
      body: jsonEncode(params),
      headers: <String, String>{
        "Content-Type": "application/json; charset=utf-8",
      },
    );

    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(resp.body);
      final EditEmployeeProfileResponseModel response =
          EditEmployeeProfileResponseModel.fromJson(decoded);
      return response;
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(resp.body);
      throw Exception(
        'Failed to add employee: ${errorResponse['message'] ?? 'Unknown error'}',
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
