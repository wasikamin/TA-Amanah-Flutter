// import 'package:amanah/models/user.dart';
import 'package:flutter/material.dart';
// import user_provider.dart from providers
import 'package:amanah/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Saldo extends StatefulWidget {
  const Saldo({
    super.key,
  });

  @override
  State<Saldo> createState() => _SaldoState();
}

class _SaldoState extends State<Saldo> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<UserProvider>(context, listen: false).checkSaldo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: Row(
        children: [
          Text(" Rp. "),
          Provider.of<UserProvider>(context).loading == true
              ? SizedBox(
                  height: 10, width: 10, child: CircularProgressIndicator())
              : Text(Provider.of<UserProvider>(context).balance),
        ],
      ),
    );
  }
}
