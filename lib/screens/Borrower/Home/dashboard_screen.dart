import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/authentication_provider.dart';
import 'package:amanah/providers/user_profile_provider.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:amanah/screens/Borrower/pembayaran_pinjaman/pembayaran_screen.dart';
import 'package:amanah/widgets/Borrower/JadwalPembayaran.dart';
import 'package:amanah/widgets/Borrower/borrowerTopCard.dart';
import 'package:amanah/widgets/Borrower/pembayaranBulanIni.dart';
import 'package:amanah/widgets/Borrower/pinjamanAktif.dart';
import 'package:amanah/widgets/topBackground.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:amanah/providers/user_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoan();
    checkKyc();
    checkProfile();
  }

  checkLoan() async {
    await Provider.of<UserProvider>(context, listen: false).checkPinjaman();
  }

  checkKyc() async {
    await Provider.of<AuthenticationProvider>(context, listen: false)
        .checkKyc();
  }

  checkProfile() async {
    await Provider.of<UserProfileProvider>(context, listen: false).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xfff2f7fa),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body:
          Consumer3<AuthenticationProvider, UserProvider, UserProfileProvider>(
              builder: (context, authenticationProvider, userProvider,
                  userProfileProvider, _) {
        // print(userProvider.active!["totalFund"]);
        return RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            await authenticationProvider.checkKyc();
            await userProvider.checkPinjaman();
            await userProfileProvider.getProfile();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Stack(
              children: [
                topBackground(screenHeight: screenHeight),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          const BorrowerTopCard(),
                          const PinjamanAktif(),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: SizedBox(
                              child: Text(
                                "Pembayaran Bulan Ini",
                                style: titleTextStyle.copyWith(fontSize: 16),
                              ),
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.1,
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              children: [
                                const pembayaranBulanIni(),
                                const Spacer(),
                                if (authenticationProvider.kyced == "verified")
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PembayaranScreen()));
                                      },
                                      child: Text(
                                        "Bayar",
                                        style: textButtonTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ))
                              ],
                            ),
                          ),
                          Container(
                              width: double.infinity,
                              constraints: BoxConstraints(
                                minHeight: 100,
                              ),
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const JadwalPembayaran()),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
