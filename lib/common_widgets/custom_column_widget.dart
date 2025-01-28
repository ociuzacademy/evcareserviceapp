import 'package:flutter/material.dart';

class CustomColumnWidget extends StatelessWidget {
  final String title;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;
  final TextStyle titleStyle;
  final TextStyle valueStyle;
  final int? truncateLength;

  const CustomColumnWidget({
    super.key,
    required this.title,
    required this.value,
    required this.crossAxisAlignment,
    required this.titleStyle,
    required this.valueStyle,
    this.truncateLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        Text(
          _getDisplayValue(value),
          style: valueStyle,
          overflow: truncateLength != null && value.length > truncateLength!
              ? TextOverflow.ellipsis
              : TextOverflow.visible,
        ),
      ],
    );
  }

  String _getDisplayValue(String text) {
    if (truncateLength != null && text.length > truncateLength!) {
      return '${text.substring(0, truncateLength!)}...';
    }
    return text;
  }
}
