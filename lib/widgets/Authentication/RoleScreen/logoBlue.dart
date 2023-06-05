import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoBlue extends StatelessWidget {
  const LogoBlue({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/Logo/LogoAmanaBiru.svg"),
          Text(
            "MANAH",
            style: TextStyle(fontSize: 40, color: Color(0xff19A7CE)),
          )
        ],
      ),
    );
  }
}
