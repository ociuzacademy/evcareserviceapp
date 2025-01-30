import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:evcareserviceapp/common_models/common_response_model.dart';
import 'package:evcareserviceapp/common_utils/urls.dart';

Future<CommonResponseModel> assignEmployee({
  required int repairRequestId,
  required int employeeId,
}) async {
  try {
    Map<String, dynamic> params = {
      "id": repairRequestId.toString(),
      "employee": employeeId.toString(),
    };

    final resp = await http.patch(
      Uri.parse(Urls.assignEmployeeUrl),
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
