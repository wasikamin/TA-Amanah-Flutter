import 'package:amanah/constants/app_theme.dart';
import 'package:flutter/material.dart';

class InformationRow extends StatelessWidget {
  const InformationRow({
    super.key,
    required this.left,
    required this.right,
  });

  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            left,
            style: bodyTextStyle.copyWith(fontSize: 12),
            textAlign: TextAlign.start,
          ),
          Spacer(),
          Container(
            constraints: BoxConstraints(maxWidth: 150),
            child: Text(
              right,
              style: bodyTextStyle.copyWith(fontSize: 12),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
