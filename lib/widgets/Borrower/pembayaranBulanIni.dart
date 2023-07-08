import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_provider.dart';
// import 'package:amanah/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class pembayaranBulanIni extends StatefulWidget {
  const pembayaranBulanIni({
    super.key,
  });
  @override
  State<pembayaranBulanIni> createState() => _pembayaranBulanIniState();
}

class _pembayaranBulanIniState extends State<pembayaranBulanIni> {
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
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      // print(userProvider.tagihan?["currentMonth"]);
      return userProvider.loading == true
          ? const CircularProgressIndicator()
          : Text(
              userProvider.tagihan?["currentMonth"] == 0
                  ? formatCurrency(0)
                  : userProvider.tagihan?["currentMonth"] == null
                      ? formatCurrency(0)
                      : formatCurrency(userProvider.tagihan?["currentMonth"]),
              style: bodyTextStyle.copyWith(fontSize: 22),
            );
    });
  }
}
