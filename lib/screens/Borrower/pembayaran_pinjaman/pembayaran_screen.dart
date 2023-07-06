import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:amanah/screens/web/web_view_screen.dart';
import 'package:amanah/services/user_service.dart';
import 'package:amanah/widgets/Borrower/pembayaranBulanIni.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PembayaranScreen extends StatelessWidget {
  const PembayaranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userService = UserService();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xfff2f7fa),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          "Pembayaran Tagihan",
          style: bodyTextStyle.copyWith(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 1,
              child: Container(
                padding: EdgeInsets.all(width * 0.05),
                width: double.infinity,
                height: height * 0.23,
                child: Column(
                  children: [
                    Text(
                      "Tagihan Bulan Ini",
                      style: bodyTextStyle.copyWith(fontSize: 16),
                    ),
                    const Spacer(),
                    const pembayaranBulanIni(),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "Sisa Pembayaran:",
                          style: bodyTextStyle.copyWith(fontSize: 12),
                        ),
                        Spacer(),
                        Text(
                          "Rp. 0",
                          style: bodyTextStyle.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "jatuh Tempo:",
                          style: bodyTextStyle.copyWith(fontSize: 12),
                        ),
                        Spacer(),
                        Text(
                          "-",
                          style: bodyTextStyle.copyWith(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            SizedBox(
                width: double.infinity,
                height: height * 0.07,
                child: ElevatedButton(
                  onPressed: () async {
                    final paymentLink = await userService.payLoan(userProvider);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewScreen(
                                  url: paymentLink["paymentLink"],
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: primaryColor),
                      ),
                      backgroundColor: primaryColor),
                  child: Text(
                    "Bayar Sekarang",
                    style: buttonTextStyle,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
