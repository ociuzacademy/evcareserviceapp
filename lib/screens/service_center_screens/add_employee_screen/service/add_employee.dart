import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:evcareserviceapp/common_models/common_response_model.dart';
import 'package:evcareserviceapp/common_utils/local_storage.dart';
import 'package:evcareserviceapp/common_utils/urls.dart';

Future<CommonResponseModel> addEmployee({
  required String username,
  required String employeeName,
  required String email,
  required String phoneNumber,
  required String password,
}) async {
  try {
    int serviceCentreId = await LocalStorage.getServiceCentreId();
    Map<String, dynamic> params = {
      "username": username,
      "name": employeeName,
      "email": email,
      "phone_number": phoneNumber,
      "password": password,
      "service_centre": serviceCentreId,
    };

    final resp = await http.post(
      Uri.parse(Urls.addEmployeeUrl),
      body: jsonEncode(params),
      headers: <String, String>{
        "Content-Type": "application/json; charset=utf-8",
      },
    );

    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(resp.body);
      final CommonResponseModel response =
          CommonResponseModel.fromJson(decoded);
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
