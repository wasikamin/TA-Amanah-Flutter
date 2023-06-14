import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/authentication_provider.dart';
import 'package:amanah/screens/Borrower/pembayaran_screen.dart';
import 'package:amanah/screens/Verification/personal_information_screen.dart';
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
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xfff2f7fa),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Consumer<AuthenticationProvider>(
          builder: (context, authenticationProvider, _) {
        return RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            await authenticationProvider.checkKyc();
          },
          child: SingleChildScrollView(
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
                          Container(
                            height: screenHeight * 0.25,
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("Limit Tersedia",
                                    style:
                                        bodyTextStyle.copyWith(fontSize: 24)),
                                Text("Rp. 11.000.000",
                                    style:
                                        bodyTextStyle.copyWith(fontSize: 24)),
                                SizedBox(
                                  height: screenHeight * 0.015,
                                ),
                                Text("Maksimal Limit: Rp. 11.000.000"),
                                SizedBox(
                                  height: screenHeight * 0.025,
                                ),
                                if (authenticationProvider.kyced ==
                                    "not verified")
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PersonalInformationScreen()));
                                    },
                                    child: Text(
                                      "Verifikasi Data",
                                      style: buttonTextStyle,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor),
                                  ),
                                if (authenticationProvider.kyced == "pending")
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    child: Text(
                                        "Status Verifikasi: ${authenticationProvider.kyced}",
                                        style: bodyTextStyle.copyWith(
                                          fontSize: 16,
                                          color: primaryColor,
                                        )),
                                  ),
                                if (authenticationProvider.kyced == "verified")
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Ajukan Pinjaman",
                                      style: buttonTextStyle,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 30),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: BorderSide(color: primaryColor),
                                        ),
                                        backgroundColor: primaryColor),
                                  ),
                              ],
                            ),
                          ),
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
                            padding: EdgeInsets.all(16),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              children: [
                                Text("Rp. 0",
                                    style:
                                        bodyTextStyle.copyWith(fontSize: 24)),
                                Spacer(),
                                if (authenticationProvider.kyced == "verified")
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PembayaranScreen()));
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
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.symmetric(vertical: 20),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Wrap(
                                direction: Axis.vertical,
                                children: <Widget>[
                                  // Daftar item dalam list
                                  Row(
                                    children: [
                                      Icon(Icons.schedule_outlined),
                                      SizedBox(width: 10),
                                      Text(
                                        "Jadwal Pembayaran",
                                        style: bodyTextStyle.copyWith(
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Center(
                                      child: Text(
                                          "Belum ada tagihan untuk bulan ini")),
                                ],
                              )),
                          Container(
                            height: 150,
                          )
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
