import 'package:flutter/material.dart';

class PurchaseHistoryTileContent extends StatelessWidget {
  const PurchaseHistoryTileContent({
    super.key,
    required this.value,
    required this.item,
    required this.crossAxisAlignment,
  });

  final String value;
  final String item;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          item,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Text(
          _truncateString(value, 20), // Adjust the max length as needed
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
          overflow:
              TextOverflow.ellipsis, // Ensures overflow is visually handled
        ),
      ],
    );
  }

  /// Helper method to truncate a string and add ellipsis if it exceeds maxLength
  String _truncateString(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }
}
