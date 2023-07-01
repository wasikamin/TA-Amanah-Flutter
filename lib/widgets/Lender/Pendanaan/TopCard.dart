import 'package:amanah/constants/app_theme.dart';
import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {
  const TopCard({
    super.key,
    required this.content,
    required this.title,
  });

  final String content;
  final String title;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        constraints: BoxConstraints(minHeight: height * 0.15),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(
            left: width * 0.05, right: width * 0.05, top: height * 0.02),
        child: Column(
          children: [
            Text(title,
                style: bodyTextStyle.copyWith(
                  fontSize: 11,
                ),
                textAlign: TextAlign.center),
            vSpace(
              height: height * 0.02,
            ),
            Text(content,
                style: bodyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
