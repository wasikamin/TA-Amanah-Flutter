import 'package:amanah/constants/app_theme.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double padding;
  const CustomCard({super.key, required this.child, this.padding = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Card(
        color: secondaryColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: this.padding == 0
              ? EdgeInsets.fromLTRB(32, 30, 32, 10)
              : EdgeInsets.all(padding),
          child: child,
        ),
      ),
    );
  }
}
