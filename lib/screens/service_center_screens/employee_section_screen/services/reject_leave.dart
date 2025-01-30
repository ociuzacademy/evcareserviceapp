import 'dart:convert';
import 'dart:io';
import 'package:evcareserviceapp/common_utils/urls.dart';
import 'package:evcareserviceapp/screens/service_center_screens/employee_section_screen/models/leave_action_model.dart';
import 'package:http/http.dart' as http;

Future<LeaveActionModel> rejectLeave({
  required int employeeId,
}) async {
  try {
    Map<String, dynamic> params = {
      "employee": employeeId,
    };

    final resp = await http.post(
      Uri.parse(Urls.rejectLeaveUrl),
      body: jsonEncode(params),
      headers: <String, String>{
        "Content-Type": "application/json; charset=utf-8",
      },
    );

    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(resp.body);
      final LeaveActionModel response = LeaveActionModel.fromJson(decoded);
      return response;
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(resp.body);
      throw Exception(
        'Failed to reject leave: ${errorResponse['message'] ?? 'Unknown error'}',
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
