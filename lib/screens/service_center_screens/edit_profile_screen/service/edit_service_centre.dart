import 'dart:convert';
import 'dart:io';

import 'package:evcareserviceapp/common_utils/local_storage.dart';
import 'package:http/http.dart' as http;

import 'package:evcareserviceapp/common_utils/urls.dart';
import 'package:evcareserviceapp/screens/service_center_screens/edit_profile_screen/model/edit_profile_response_model.dart';

Future<EditProfileResponseModel> editServiceCentre({
  String? userName,
  String? serviceCentreName,
  String? address,
  String? email,
  String? phoneNumber,
  // String? password,
  // Location? location,
  File? image,
}) async {
  try {
    // Create a multipart request
    var request =
        http.MultipartRequest("PATCH", Uri.parse(Urls.editProfileUrl));

    // Add text fields
    int serviceCentreId = await LocalStorage.getServiceCentreId();
    request.fields['id'] = serviceCentreId.toString();
    if (userName != null) request.fields['username'] = userName;
    if (serviceCentreName != null) request.fields['name'] = serviceCentreName;
    if (address != null) request.fields['address'] = address;
    if (email != null) request.fields['email'] = email;
    if (phoneNumber != null) request.fields['phone'] = phoneNumber;
    // if (password != null) request.fields['password'] = password;
    // if (location != null) {
    //   request.fields['latitude'] = location.latitude.toString();
    //   request.fields['longitude'] = location.longitude.toString();
    // }

    // Add the image file
    if (image != null) {
      var imageStream = http.ByteStream(image.openRead());
      var imageLength = await image.length();
      var multiPartFile = http.MultipartFile(
        'image',
        imageStream,
        imageLength,
        filename: image.path.split("/").last,
      );
      request.files.add(multiPartFile);
    }

    // Send request
    final resp = await request.send();

    // Convert the response stream to a string
    final responseBody = await resp.stream.bytesToString();

    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(responseBody);
      final EditProfileResponseModel response =
          EditProfileResponseModel.fromJson(decoded);
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
