import 'package:amanah/constants/app_theme.dart';
import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/Logo/LogoAmana2.png"),
          Text(
            "MANAH",
            style: TextStyle(fontSize: 40, color: whiteColor),
          )
        ],
      ),
    );
  }
}
