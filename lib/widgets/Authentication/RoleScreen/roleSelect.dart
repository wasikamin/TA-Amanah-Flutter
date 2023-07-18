import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/screens/Authentication/register_screen.dart';
import 'package:amanah/widgets/Authentication/card.dart';
import 'package:flutter/material.dart';

class RoleSelect extends StatelessWidget {
  const RoleSelect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const RegisterScreen(role: "Lender")));
            },
            child: CustomCard(
                padding: 10,
                child: Container(
                  height: 150,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          "assets/images/Illustration/Lender.png",
                        ),
                      ),
                      Text(
                        "Lender",
                        style: subTitleTextStyle.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Danai Pinjaman untuk dapatkan imbalan dari peminjam",
                        style: thinBodyTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )),
          ),
        ),
        Expanded(
            child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const RegisterScreen(role: "Borrower")));
          },
          child: CustomCard(
              padding: 10,
              child: Container(
                height: 150,
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        "assets/images/Illustration/Borrower.png",
                        height: 150,
                      ),
                    ),
                    Text(
                      "Borrower",
                      style: subTitleTextStyle.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Ajukan Pinjaman Berbasis Syariah",
                      style: thinBodyTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )),
        ))
      ],
    );
  }
}
