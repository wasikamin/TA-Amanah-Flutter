import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/screens/profile/informasi_aplikasi_screen.dart';
import 'package:amanah/widgets/UserProfileDetail.dart';
import 'package:amanah/widgets/sweat_alert.dart';
import 'package:amanah/widgets/topBackground.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../providers/authentication_provider.dart';

class LenderProfile extends StatelessWidget {
  const LenderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          const topBackground(),
          Padding(
            padding: EdgeInsets.only(top: height * 0.065, left: width * 0.037),
            child: Row(
              children: [
                SizedBox(
                    height: 20,
                    child: Image.asset("assets/images/Logo/LogoAmana2.png")),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Amanah",
                  style:
                      bodyTextStyle.copyWith(fontSize: 20, color: whiteColor),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: height * 0.05),
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.07, vertical: height * 0.03),
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Card(
                          elevation: 3,
                          child: Container(
                            width: width * 0.85,
                            height: height * 0.23,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      const UserProfileDetail(),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    "Informasi Aplikasi",
                    style: titleTextStyle.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        InkWell(
                          highlightColor: Colors.blue.withOpacity(0.4),
                          splashColor: primaryColor.withOpacity(0.5),
                          onTap: () {},
                          child: ListTile(
                            leading: const Icon(Icons.phone_android_rounded),
                            title: const Text("Versi Aplikasi"),
                            subtitle: Text("Versi Aplikasi saat ini",
                                style: bodyTextStyle.copyWith(
                                    fontSize: 10, color: Colors.grey)),
                            trailing: Text(
                              "1.0.0",
                              style: bodyTextStyle,
                            ),
                          ),
                        ),
                        InkWell(
                          highlightColor: Colors.blue.withOpacity(0.4),
                          splashColor: primaryColor.withOpacity(0.5),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const InformasiAplikasi()));
                          },
                          child: ListTile(
                            leading: const Icon(Icons.info_outline_rounded),
                            title: const Text("Informasi Aplikasi"),
                            subtitle: Text("Informasi mengenai fitur aplikasi",
                                style: bodyTextStyle.copyWith(
                                    fontSize: 10, color: Colors.grey)),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        logoutAlert(context, "Konfirmasi Keluar",
                            "Apakah anda yakin ingin keluar?");
                      },
                      child: const Text(
                        'Keluar',
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
