import 'package:amanah/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class topBackground extends StatelessWidget {
  const topBackground({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      height: screenHeight * 0.3,
      child: Stack(children: [
        Positioned(
            top: 0,
            right: -50,
            child: Opacity(
              opacity: 0.2,
              child: SizedBox(
                  height: screenHeight * 0.25,
                  width: screenHeight * 0.35,
                  child: SvgPicture.asset(
                    "assets/images/Logo/LogoAmanaBiru.svg",
                    fit: BoxFit.fill,
                  )),
            ))
      ]),
    );
  }
}
