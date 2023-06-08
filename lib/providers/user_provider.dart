import 'dart:async';
import 'package:amanah/services/user_service.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
  String _balance = "0";
  bool _loading = true;
  String get balance => _balance;
  bool get loading => _loading;
  final UserService _userService = UserService();

  //constructor
  // UserProvider() {
  //   checkSaldo();
  // }

  Future<void> checkSaldo() async {
    var saldo = await _userService.getBalance();
    print(saldo);
    _balance = saldo.toString();
    _loading = false;
    notifyListeners();
  }
}
