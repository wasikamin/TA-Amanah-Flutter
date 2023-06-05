import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/screens/Authentication/login_screen.dart';
import 'package:amanah/widgets/Authentication/RoleScreen/logoBlue.dart';
import 'package:amanah/widgets/Authentication/RoleScreen/roleSelect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundWhite,
        child: Stack(children: [
          Positioned(
            bottom: -30,
            right: -50,
            child: Opacity(
              opacity: 0.2,
              child: SizedBox(
                  height: 200,
                  width: 300,
                  child: SvgPicture.asset(
                    "assets/images/Logo/LogoAmanaBiru.svg",
                    fit: BoxFit.fill,
                  )),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 50,
            child: Text(
              "© AMANAH Fintech Syariah 2023, ALL RIGHT RESERVED",
              style: bodyTextStyle.copyWith(fontSize: 10),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                children: [
                  Flexible(
                      flex: 1,
                      child: Container(
                        child: const Center(
                          child: LogoBlue(),
                        ),
                      )),
                  Flexible(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            "Pilih Jenis Akunmu",
                            style: titleTextStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Pilih salah satu jenis akun",
                            style: subTitleTextStyle.copyWith(
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          const RoleSelect(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sudah memiliki akun? ",
                                style: subTitleTextStyle.copyWith(
                                    fontWeight: FontWeight.w700),
                              ),
                              TextButton(
                                  style: textButton,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  child: Text(
                                    "Login di Sini!",
                                    style: textButtonTextStyle.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ))
                            ],
                          )
                        ],
                      )),
                  Flexible(flex: 1, child: Container()),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
