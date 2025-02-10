// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/common_utils/local_storage.dart';
import 'package:evcareserviceapp/screens/common_screens/introduction_screen/views/on_boarding_widget.dart';
import 'package:evcareserviceapp/screens/common_screens/login_screen/views/login_screen.dart';
import 'package:evcareserviceapp/screens/employee_screens/employee_home_screen/views/employee_home_screen.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/views/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isFirstLaunch = await LocalStorage.getIntroScreenStatus();
  bool isLoggedIn = await LocalStorage.getLoginStatus();
  String userType = await LocalStorage.getUserType();

  Widget initialScreen;

  if (isFirstLaunch) {
    initialScreen = const OnBoardingWidget();
  } else {
    if (isLoggedIn) {
      if (userType == "service_centre") {
        initialScreen = const HomeScreen();
      } else {
        initialScreen = const EmployeeHomeScreen();
      }
    } else {
      initialScreen = const LoginScreen();
    }
  }

  runApp(MyApp(
    initialScreen: initialScreen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({
    super.key,
    required this.initialScreen,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EV Care Service App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      home: initialScreen,
    );
  }
}
