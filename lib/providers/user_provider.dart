import 'dart:async';
import 'package:amanah/services/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserProvider with ChangeNotifier {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  String _balance = "0";
  bool _loading = true;
  bool _kyc = false;

  bool get kyc => _kyc;
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

  Future<void> checkKyc() async {
    final token = await _secureStorage.read(key: 'jwtToken').toString();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    print(decodedToken);
    // _kyc = kyc;
    // notifyListeners();
  }
}
