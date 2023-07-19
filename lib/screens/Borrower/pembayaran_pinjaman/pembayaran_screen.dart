import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:amanah/screens/web/web_view_screen.dart';
import 'package:amanah/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PembayaranScreen extends StatelessWidget {
  const PembayaranScreen({super.key, required this.tagihan});
  final int tagihan;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userService = UserService();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    String formatCurrency(int? amount) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
      return formatCurrency.format(amount);
    }

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
                    Text(
                      userProvider.tagihan?["currentMonth"] == 0
                          ? formatCurrency(0)
                          : userProvider.tagihan?["currentMonth"] == null
                              ? formatCurrency(0)
                              : formatCurrency(
                                  userProvider.tagihan?["currentMonth"]),
                      style: bodyTextStyle.copyWith(fontSize: 22),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "Sisa Pembayaran:",
                          style: bodyTextStyle.copyWith(fontSize: 12),
                        ),
                        const Spacer(),
                        Text(
                          formatCurrency(tagihan),
                          style: bodyTextStyle.copyWith(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
                width: double.infinity,
                height: height * 0.07,
                child: ElevatedButton(
                  onPressed: () async {
                    await userService.payLoan(userProvider).then((value) {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebViewScreen(
                                    url: value["paymentLink"],
                                  )));
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
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
