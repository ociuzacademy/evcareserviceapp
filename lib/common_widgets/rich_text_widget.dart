// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final String bottomMessage;
  final Widget formRedirect;
  const RichTextWidget({
    super.key,
    required this.bottomMessage,
    required this.formRedirect,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(text: bottomMessage, children: [
        TextSpan(
          text: "Click Here",
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => formRedirect,
                ),
              );
            },
          style: const TextStyle(
            color: Colors.green,
          ),
        )
      ]),
    );
  }
}
