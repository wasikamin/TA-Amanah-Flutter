import 'package:amanah/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class topBackground extends StatelessWidget {
  const topBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      height: screenHeight * 0.3,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: -screenHeight * 0.025,
              right: -50,
              child: Opacity(
                opacity: 0.4,
                child: SizedBox(
                    height: screenHeight * 0.25,
                    width: screenHeight * 0.35,
                    child: SvgPicture.asset(
                      "assets/images/Logo/LogoAmanaBiru.svg",
                      fit: BoxFit.fill,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
