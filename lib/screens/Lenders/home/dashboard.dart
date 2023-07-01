import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/authentication_provider.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:amanah/widgets/Lender/Dashboard/KycStatusCard.dart';
import 'package:amanah/widgets/Lender/cardSaldo.dart';
import 'package:amanah/widgets/topBackground.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xfff2f7fa),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,

      //body
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          //use method checkSaldo() in userProvider
          await Provider.of<UserProvider>(context, listen: false).checkSaldo();
          await Provider.of<AuthenticationProvider>(context, listen: false)
              .checkKyc();
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              topBackground(screenHeight: screenHeight),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 20,
                              child: Image.asset(
                                  "assets/images/Logo/LogoAmana2.png")),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Amanah",
                            style: bodyTextStyle.copyWith(
                                fontSize: 20, color: whiteColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      cardSaldo(screenHeight: screenHeight),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      //card status kyc
                      KycStatusCard(width: width),
                      //space
                      Container(
                        height: screenHeight * 0.5,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
