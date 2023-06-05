import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/screens/Authentication/login_screen.dart';
import 'package:amanah/screens/Authentication/role_screen.dart';
// import 'package:amanah/widgets/Authentication/Login/loginLogo.dart';
import 'package:amanah/widgets/Landing/landingCarousel.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDynamicLinks();
  }

  Future initDynamicLinks() async {
    dynamicLinks.onLink.listen((event) {
      // navigator ke halaman forget password
      print('MASUKKKKKKKK');
      var uid = event.link.queryParameters['uid'];
      var token = event.link.queryParameters['token'];
      print('dynmic link: ${event.link}');
      print('userId: ' + uid.toString());
      print('token: ' + token.toString());

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }).onError((error) {
      print('error ${error.message}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Color(0xffFAFAFA)),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: LandingCarousel(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                backgroundColor: primaryColor,
                                minimumSize: Size.fromHeight(
                                    40), // fromHeight use double.infinity as width and 40 is the height
                              ),
                              child: Text("Masuk"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RoleScreen()),
                                );
                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(color: primaryColor),
                                ),
                                minimumSize: Size.fromHeight(40),
                              ),
                              child: Text(
                                "Belum Memiliki Akun?",
                                style: textButtonTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "© AMANAH Fintech Syariah 2023, ALL RIGHT RESERVED",
                style: bodyTextStyle.copyWith(fontSize: 10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
