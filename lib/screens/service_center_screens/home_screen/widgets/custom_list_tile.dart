import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subTitle;
  final Widget? trailing;
  const CustomListTile({
    super.key,
    required this.leading,
    required this.title,
    required this.subTitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align items at the top
      children: [
        SizedBox(
          width: screenSize.width * 0.4, // Use a percentage of screen width
          child: leading,
        ),
        SizedBox(
          width:
              screenSize.width * 0.05, // Use a smaller percentage for spacing
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              SizedBox(
                height: screenSize.height * 0.08,
              ), // Add spacing between title and subtitle
              subTitle,
            ],
          ),
        ),
        if (trailing != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0), // Add some padding
            child: trailing,
          ),
      ],
    );
  }
}
