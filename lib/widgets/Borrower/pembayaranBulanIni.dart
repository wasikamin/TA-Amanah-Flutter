import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/authentication_provider.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:amanah/screens/Borrower/pembayaran_pinjaman/pembayaran_screen.dart';
// import 'package:amanah/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PembayaranBulanIni extends StatefulWidget {
  const PembayaranBulanIni({
    super.key,
  });
  @override
  State<PembayaranBulanIni> createState() => _PembayaranBulanIniState();
}

class _PembayaranBulanIniState extends State<PembayaranBulanIni> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkTagihan();
  }

  checkTagihan() async {
    await Provider.of<UserProvider>(context, listen: false).checkTagihan();
  }

  String formatCurrency(int? amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  Map<dynamic, dynamic> loan = {};
  @override
  Widget build(BuildContext context) {
    int tagihan = 0;
    return Consumer2<UserProvider, AuthenticationProvider>(
        builder: (context, userProvider, authenticationProvider, _) {
      userProvider.paymentSchedule
          .where((element) => element["status"] == "unpaid")
          .forEach((element) {
        tagihan = tagihan + element["amount"] as int;
      });
      // print(tagihan);
      return userProvider.loading == true
          ? const CircularProgressIndicator()
          : Row(
              children: [
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
                if (authenticationProvider.kyced == "verified" &&
                    userProvider.tagihan?["currentMonth"] != 0)
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PembayaranScreen(
                                      tagihan: tagihan,
                                    )));
                      },
                      child: Text(
                        "Bayar",
                        style: textButtonTextStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ))
              ],
            );
    });
  }
}
