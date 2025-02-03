// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:evcareserviceapp/common_utils/constants.dart';

class StoreOpenStatus extends StatelessWidget {
  const StoreOpenStatus({
    super.key,
  });

  String _getServiceCentreStatus() {
    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);

    // Check if today is Sunday
    if (now.weekday == DateTime.sunday) {
      return "Closed (Sunday)";
    }

    // Check if current time is within opening and closing times
    if (_isTimeBetween(
      currentTime,
      Constants.openingTime,
      Constants.closingTime,
    )) {
      return "Open";
    } else {
      return "Closed";
    }
  }

  bool _isTimeBetween(
    TimeOfDay currentTime,
    TimeOfDay startTime,
    TimeOfDay endTime,
  ) {
    final currentMinutes = currentTime.hour * 60 + currentTime.minute;
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;

    return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
  }

  @override
  Widget build(BuildContext context) {
    final status = _getServiceCentreStatus();
    return Text(
      status,
      style: TextStyle(
        color: status == 'Open' ? Colors.green : Colors.red,
        fontSize: 18,
      ),
    );
  }
}
