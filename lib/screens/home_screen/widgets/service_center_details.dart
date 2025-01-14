import 'package:evcareserviceapp/screens/home_screen/widgets/store_open_status.dart';
import 'package:flutter/material.dart';

class ServiceCenterDetails extends StatelessWidget {
  const ServiceCenterDetails({
    super.key,
  });

  final TimeOfDay openingTime = const TimeOfDay(hour: 9, minute: 0); // 9:00 AM
  final TimeOfDay closingTime = const TimeOfDay(hour: 18, minute: 0); // 6:00 PM

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Image.asset("assets/images/service_center.jpeg"),
        SizedBox(
          height: screenSize.height * 0.01,
        ),
        const Text(
          "Pinnacle Vehicles &\nServices Pvt Ltd",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Patturaikkal, Thrissur",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),
        StoreOpenStatus(
          openingTime: openingTime,
          closingTime: closingTime,
        ),
      ],
    );
  }
}
