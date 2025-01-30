import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:evcareserviceapp/common_models/common_response_model.dart';
import 'package:evcareserviceapp/common_utils/urls.dart';

Future<CommonResponseModel> updateProduct({
  required int productId,
  String? productPrice,
  String? productQuantity,
}) async {
  try {
    if (productPrice == null && productQuantity == null) {
      throw Exception('there are no fields to update');
    }

    Map<String, dynamic> params = {
      "product_id": productId.toString(),
    };

    if (productPrice != null) params['price'] = productPrice;
    if (productQuantity != null) params['quantity'] = productQuantity;

    final resp = await http.patch(
      Uri.parse(Urls.updateProductUrl),
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
