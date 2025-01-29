import 'dart:convert';
import 'dart:io';
import 'package:evcareserviceapp/screens/service_center_screens/feedback_list_screen/models/feedback_model.dart';
import 'package:http/http.dart' as http;

import 'package:evcareserviceapp/common_utils/urls.dart';

Future<List<FeedbackModel>> getUserFeedbacks({
  required int serviceCentreId,
}) async {
  try {
    Map<String, dynamic> params = {
      "id": serviceCentreId.toString(),
    };

    final url =
        Uri.parse(Urls.getFeedbackListUrl).replace(queryParameters: params);

    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (resp.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(utf8.decode(resp.bodyBytes));
      final response =
          decoded.map((item) => FeedbackModel.fromJson(item)).toList();

      return response;
    } else {
      final Map<String, dynamic> errorResponse =
          jsonDecode(utf8.decode(resp.bodyBytes));
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
