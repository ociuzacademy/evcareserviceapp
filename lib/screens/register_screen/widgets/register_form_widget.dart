// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:evcareserviceapp/screens/login_screen/views/login_screen.dart';
import 'package:evcareserviceapp/screens/register_screen/models/location.dart';
import 'package:evcareserviceapp/screens/register_screen/services/service_center_registration_service.dart';
import 'package:evcareserviceapp/screens/register_screen/widgets/email_text_field.dart';
import 'package:evcareserviceapp/screens/register_screen/widgets/phone_number_text_field.dart';
import 'package:evcareserviceapp/screens/register_screen/widgets/address_text_field.dart';

import 'package:evcareserviceapp/common_widgets/password_text_field.dart';
import 'package:evcareserviceapp/common_widgets/form_text_field.dart';
import 'package:evcareserviceapp/common_widgets/padded_elevated_button.dart';
import 'package:evcareserviceapp/common_widgets/rich_text_widget.dart';

class RegisterFormWidget extends StatefulWidget {
  final String imageUrl;
  final String bottomMessage;
  const RegisterFormWidget({
    super.key,
    required this.imageUrl,
    required this.bottomMessage,
  });

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _serviceCenterNameController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  double? _latitude;
  double? _longitude;
  bool _isRegistering = false;

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _usernameController.dispose();
    _serviceCenterNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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

  Future<void> _registerServiceCenter() async {
    print('Form validated: ${_formKey.currentState!.validate()}');
    print('Latitude: $_latitude, Longitude: $_longitude');
    if (_formKey.currentState!.validate() &&
        _latitude != null &&
        _longitude != null) {
      setState(() {
        _isRegistering = true;
      });
      try {
        final response = await registerServiceCenter(
          userName: _usernameController.text,
          serviceCenterName: _serviceCenterNameController.text,
          address: _addressController.text,
          email: _emailController.text,
          phoneNumber: _phoneNumberController.text,
          password: _passwordController.text,
          location: Location(
            latitude: _latitude ?? 0.0,
            longitude: _longitude ?? 0.0,
          ),
        );
        print('API Response: $response');
        bool status = response.status == "success";
        print('Registration status: $status');

        if (status && mounted) {
          // Use context here because mounted is true
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      } catch (e) {
        print('Registration error: $e');
        if (mounted) {
          // Use context here because mounted is true
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration failed")),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isRegistering = false;
          });
        }
      }
    } else {
      if (mounted) {
        // Use context here because this is synchronous
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all fields and get location'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return _isRegistering
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          )
        : LayoutBuilder(
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
                                  textFieldIcon:
                                      const Icon(Icons.perm_identity),
                                  hintText: 'Enter your username',
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your username';
                                    }
                                    return null;
                                  },
                                  formTextController: _usernameController,
                                ),
                                SizedBox(
                                  height: screenSize.height / 50,
                                ),
                                FormTextField(
                                  textFieldIcon: const Icon(Icons.store),
                                  hintText: 'Enter service center name',
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter ervice center name';
                                    }
                                    return null;
                                  },
                                  formTextController:
                                      _serviceCenterNameController,
                                ),
                                SizedBox(
                                  height: screenSize.height / 50,
                                ),
                                AddressTextField(
                                  hintText: 'Enter address',
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter address';
                                    }
                                    return null;
                                  },
                                  addressTextController: _addressController,
                                ),
                                SizedBox(
                                  height: screenSize.height / 50,
                                ),
                                EmailTextField(
                                  hintText: "Enter your email",
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter email';
                                    }
                                    return null;
                                  },
                                  emailTextController: _emailController,
                                ),
                                SizedBox(
                                  height: screenSize.height / 50,
                                ),
                                PhoneNumberTextField(
                                  hintText: 'Enter your phone number',
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter phone number';
                                    }
                                    return null;
                                  },
                                  phoneNumberTextController:
                                      _phoneNumberController,
                                ),
                                SizedBox(
                                  height: screenSize.height / 50,
                                ),
                                PasswordTextField(
                                  hintText: 'Enter your password',
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    }

                                    if (value.length < 6) {
                                      return 'Password must have at least 6 characters';
                                    }
                                    return null;
                                  },
                                  passwordTextController: _passwordController,
                                ),
                                SizedBox(
                                  height: screenSize.height / 50,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                  formRedirect: const LoginScreen(),
                                ),
                                PaddedElevatedButton(
                                  buttonText: "Register",
                                  onPressed: _registerServiceCenter,
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
