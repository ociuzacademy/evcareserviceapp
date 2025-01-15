import 'dart:convert';
import 'dart:io';
import 'package:evcareserviceapp/screens/common_screens/register_screen/models/service_center_register_data_model.dart';
import 'package:http/http.dart' as http;

import 'package:evcareserviceapp/common_utils/urls.dart';
import 'package:evcareserviceapp/screens/common_screens/register_screen/models/location.dart';

Future<ServiceCenterRegisterDataModel> registerServiceCenter({
  required String userName,
  required String serviceCenterName,
  required String address,
  required String email,
  required String phoneNumber,
  required String password,
  required Location location,
}) async {
  try {
    Map<String, dynamic> params = {
      "username": userName,
      "name": serviceCenterName,
      "address": address,
      "email": email,
      "phone": phoneNumber,
      "password": password,
      "latitude": location.latitude,
      "longitude": location.longitude,
    };

    final resp = await http.post(
      Uri.parse(Urls.registerUrl),
      body: jsonEncode(params),
      headers: <String, String>{
        "Content-Type": "application/json; charset=utf-8"
      },
    );

    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(resp.body);
      final ServiceCenterRegisterDataModel response =
          ServiceCenterRegisterDataModel.fromJson(decoded);
      return response;
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(resp.body);
      throw Exception(
        'Failed to register: ${errorResponse['message'] ?? 'Unknown error'}',
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
