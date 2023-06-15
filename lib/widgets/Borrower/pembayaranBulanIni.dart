import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_provider.dart';
// import 'package:amanah/services/user_service.dart';
import 'package:flutter/material.dart';
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
    checkLoan();
  }

  checkLoan() async {
    await Provider.of<UserProvider>(context, listen: false).checkPinjaman();
  }

  Map<dynamic, dynamic> loan = {};
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      return Text(
        "Rp. ${userProvider.tagihan}",
        style: bodyTextStyle.copyWith(fontSize: 22),
      );
    });
  }
}
