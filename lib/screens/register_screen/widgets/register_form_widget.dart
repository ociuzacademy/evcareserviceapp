// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/common_widgets/form_text_field.dart';
import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:evcareserviceapp/common_widgets/rich_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RegisterFormWidget extends StatefulWidget {
  final String imageUrl;
  final String bottomMessage;
  final Widget formRedirect;
  final Widget formDestination;
  const RegisterFormWidget({
    super.key,
    required this.imageUrl,
    required this.bottomMessage,
    required this.formRedirect,
    required this.formDestination,
  });

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double? _latitude;
  double? _longitude;

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if the location permissions are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, return
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location Serices disabled")),
        );
      }

      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, return
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location Permission denied")),
          );
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, return
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location Permission denied forever")),
        );
      }
      return;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );

    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Small screen: Display a column
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.imageUrl),
                    radius: 90,
                  ),
                  SizedBox(
                    height: screenSize.height / 50,
                  ),
                  SizedBox(
                    height: 750,
                    width: 300,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          FormTextField(
                            textFieldIcon: const Icon(Icons.perm_identity),
                            hintText: 'Enter your username',
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: screenSize.height / 50,
                          ),
                          FormTextField(
                            textFieldIcon: const Icon(Icons.store),
                            hintText: 'Enter service center name',
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: screenSize.height / 50,
                          ),
                          FormTextField(
                            textFieldIcon: const Icon(Icons.account_box),
                            hintText: 'Enter owner name',
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: screenSize.height / 50,
                          ),
                          FormTextField(
                            textFieldIcon: const Icon(Icons.email),
                            hintText: "Enter your email",
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: screenSize.height / 50,
                          ),
                          FormTextField(
                            textFieldIcon: const Icon(Icons.phone),
                            hintText: 'Enter your phone number',
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: screenSize.height / 50,
                          ),
                          FormTextField(
                            textFieldIcon: const Icon(Icons.password),
                            hintText: 'Enter your password',
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }

                              if (value.length < 6) {
                                return 'Password must have at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: screenSize.height / 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Latitude: ${_latitude ?? 0.0}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Longitude ${_longitude ?? 0.0}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: _getLocation,
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                    Colors.green,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.location_searching,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenSize.height / 50,
                          ),
                          RichTextWidget(
                            bottomMessage: widget.bottomMessage,
                            formRedirect: widget.formRedirect,
                          ),
                          PaddedElevatedButton(
                            buttonText: "Register",
                            onPressed: () {
                              // Validate will return true if the form is valid, or false if
                              // the form is invalid.
                              if (_formKey.currentState!.validate()) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        widget.formDestination,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Large screen: Display a row
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/login_screen.png"),
              ],
            ),
          );
        }
      },
    );
  }
}
