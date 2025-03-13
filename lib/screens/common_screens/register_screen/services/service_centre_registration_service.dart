import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:evcareserviceapp/common_models/common_response_model.dart';
import 'package:evcareserviceapp/common_utils/urls.dart';
import 'package:evcareserviceapp/screens/common_screens/register_screen/models/location.dart';

Future<CommonResponseModel> registerServiceCentre({
  required String userName,
  required String serviceCentreName,
  required String address,
  required String email,
  required String phoneNumber,
  required String password,
  required Location location,
  required File image,
}) async {
  try {
    // Create a multipart request
    var request = http.MultipartRequest("POST", Uri.parse(Urls.registerUrl));

    // Add text fields
    request.fields['username'] = userName;
    request.fields['name'] = serviceCentreName;
    request.fields['address'] = address;
    request.fields['email'] = email;
    request.fields['phone'] = phoneNumber;
    request.fields['password'] = password;
    request.fields['latitude'] = location.latitude.toString();
    request.fields['longitude'] = location.longitude.toString();

    // Add the image file
    var imageStream = http.ByteStream(image.openRead());
    var imageLength = await image.length();
    var multiPartFile = http.MultipartFile(
      'image',
      imageStream,
      imageLength,
      filename: image.path.split("/").last,
    );
    request.files.add(multiPartFile);

    // Send request
    final resp = await request.send();

    // Convert the response stream to a string
    final responseBody = await resp.stream.bytesToString();

    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(responseBody);
      final CommonResponseModel response =
          CommonResponseModel.fromJson(decoded);
      return response;
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(responseBody);
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
