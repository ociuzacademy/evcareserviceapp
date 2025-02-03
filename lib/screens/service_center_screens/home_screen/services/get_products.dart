import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:evcareserviceapp/common_utils/local_storage.dart';
import 'package:evcareserviceapp/common_utils/urls.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/models/product_model.dart';

Future<List<ProductModel>> getProducts() async {
  try {
    int serviceCentreId = await LocalStorage.getServiceCentreId();
    Map<String, dynamic> params = {
      "service_centre": serviceCentreId.toString(),
    };

    final url = Uri.parse(Urls.getProductsUrl).replace(queryParameters: params);

    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (resp.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(resp.body);
      final response =
          decoded.map((item) => ProductModel.fromJson(item)).toList();

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
