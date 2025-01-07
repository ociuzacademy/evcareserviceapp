import 'package:flutter/material.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final TimeOfDay openingTime = const TimeOfDay(hour: 9, minute: 0); // 9:00 AM
  final TimeOfDay closingTime = const TimeOfDay(hour: 18, minute: 0); // 6:00 PM

  String _getServiceCenterStatus() {
    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);

    // Check if today is Sunday
    if (now.weekday == DateTime.sunday) {
      return "Closed (Sunday)";
    }

    // Check if current time is within opening and closing times
    if (_isTimeBetween(currentTime, openingTime, closingTime)) {
      return "Open";
    } else {
      return "Closed";
    }
  }

  bool _isTimeBetween(
      TimeOfDay currentTime, TimeOfDay startTime, TimeOfDay endTime) {
    final currentMinutes = currentTime.hour * 60 + currentTime.minute;
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;

    return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
  }

  @override
  Widget build(BuildContext context) {
    final status = _getServiceCenterStatus();

    return Column(
      children: [
        Image.asset("assets/images/service_center.jpeg"),
        const SizedBox(
          height: 20.0,
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
        Text(
          status,
          style: TextStyle(
            color: status == 'Open' ? Colors.green : Colors.red,
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
