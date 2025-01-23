import 'dart:convert';
import 'dart:io';
import 'package:evcareserviceapp/common_utils/urls.dart';
import 'package:evcareserviceapp/screens/common_screens/repair_request_details_screen/models/repair_request_item_model.dart';
import 'package:http/http.dart' as http;

Future<RepairRequestItemModel> getRepairRequestItem({
  required int repairId,
}) async {
  try {
    Map<String, dynamic> params = {
      "repair": repairId.toString(),
    };

    final url = Uri.parse(Urls.getRepairRequestItemUrl)
        .replace(queryParameters: params);

    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(resp.body);
      final response = RepairRequestItemModel.fromJson(decoded);

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
