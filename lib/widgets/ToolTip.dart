import 'package:amanah/constants/app_theme.dart';
import 'package:flutter/material.dart';

class CustomToolTip extends StatelessWidget {
  const CustomToolTip({super.key, required this.text, required this.textStyle});
  final TextStyle textStyle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: text,
      padding: const EdgeInsets.all(8.0),
      preferBelow: false,
      textStyle: bodyTextStyle.copyWith(fontSize: 12, color: Colors.white),
      showDuration: const Duration(milliseconds: 50),
      waitDuration: const Duration(microseconds: 50),
      child: Text(
        "${text.substring(0, 8)}...",
        style: textStyle,
      ),
    );
  }
}
