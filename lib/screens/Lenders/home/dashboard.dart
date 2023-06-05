import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/widgets/Lender/saldo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xfff2f7fa),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            SizedBox(
                height: 20,
                child: Image.asset("assets/images/Logo/LogoAmana2.png")),
            SizedBox(
              width: 10,
            ),
            Text(
              "Amanah",
              style: bodyTextStyle.copyWith(fontSize: 20, color: whiteColor),
            ),
          ],
        ),
      ),

      //body
      body: Stack(
        children: [
          Container(
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
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Card(
                    elevation: 3,
                    child: Container(
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      padding: EdgeInsets.all(14),
                      width: double.infinity,
                      height: screenHeight * 0.27,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 4,
                              right: 10,
                              child: SizedBox(
                                height: 100,
                                child: Image.asset(
                                    "assets/images/Illustration/Wallet.png"),
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Saldo Akun",
                                style: bodyTextStyle.copyWith(fontSize: 24),
                              ),
                              SizedBox(height: 10),
                              Saldo(),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              Text("Keuntungan imbal hasil:"),
                              Text("Rp. 0"),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              Text("Dana yang disalurkan: Rp. 0")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
