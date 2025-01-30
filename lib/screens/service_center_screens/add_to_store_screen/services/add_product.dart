import 'dart:convert';
import 'dart:io';

import 'package:evcareserviceapp/common_utils/local_storage.dart';
import 'package:evcareserviceapp/common_utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:evcareserviceapp/screens/service_center_screens/add_to_store_screen/models/add_product_response_model.dart';

Future<AddProductResponseModel> addProduct({
  required String productName,
  required String productDescription,
  required String productPrice,
  required String productQuantity,
  required File productImage,
}) async {
  try {
    // Create a multipart request
    var request = http.MultipartRequest("POST", Uri.parse(Urls.addProductUrl));

    // Get service centre ID
    int serviceCentreId = await LocalStorage.getServiceCentreId();
    // Add text fields
    request.fields['name'] = productName;
    request.fields['description'] = productDescription;
    request.fields['price'] = productPrice;
    request.fields['quantity'] = productQuantity;
    request.fields['service_centre'] = serviceCentreId.toString();

    // Add the image file
    var imageStream = http.ByteStream(productImage.openRead());
    var imageLength = await productImage.length();
    var multiPartFile = http.MultipartFile(
      'image',
      imageStream,
      imageLength,
      filename: productImage.path.split("/").last,
    );
    request.files.add(multiPartFile);

    // Send request
    final resp = await request.send();

    // Convert the response stream to a string
    final responseBody = await resp.stream.bytesToString();

    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(responseBody);
      final AddProductResponseModel response =
          AddProductResponseModel.fromJson(decoded);
      return response;
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(responseBody);
      throw Exception(
        'Failed to add products: ${errorResponse['message'] ?? 'Unknown error'}',
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
