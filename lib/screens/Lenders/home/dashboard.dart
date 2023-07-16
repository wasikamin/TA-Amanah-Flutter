import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/authentication_provider.dart';
import 'package:amanah/providers/loan_provider.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:amanah/widgets/Lender/Dashboard/KycStatusCard.dart';
import 'package:amanah/widgets/Lender/Dashboard/rekomendasi_pendanaan.dart';
import 'package:amanah/widgets/Lender/cardSaldo.dart';
import 'package:amanah/widgets/topBackground.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
  getLoan() async {
    await Provider.of<LoanProvider>(context, listen: false)
        .getLoanRekomendasi();
  }

  getKyc() async {
    await Provider.of<AuthenticationProvider>(context, listen: false)
        .checkKyc();
  }

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
          getKyc();
          getLoan();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: [
              topBackground(screenHeight: screenHeight),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 20,
                              child: Image.asset(
                                  "assets/images/Logo/LogoAmana2.png")),
                          const SizedBox(
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
                        height: screenHeight * 0.005,
                      ),

                      KycStatusCard(width: width),
                      //space
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Text("Rekomendasi Pendanaan",
                          style: titleTextStyle.copyWith(fontSize: 16)),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      //rekomendasi pendanaan
                      const RekomendasiPendanaan(),
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
