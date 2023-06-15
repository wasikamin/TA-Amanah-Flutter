import 'dart:async';
import 'package:amanah/models/bank.dart';
import 'package:amanah/services/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserProvider with ChangeNotifier {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  String _balance = "0";
  int? _tagihan;
  Map<dynamic, dynamic>? _active;
  List _history = [];
  bool _loading = true;
  bool _kyc = false;
  List<Bank> _banks = [];

  List<Bank> get banks => _banks;
  List get history => _history;
  Map<dynamic, dynamic>? get active => _active;
  bool get kyc => _kyc;
  int? get tagihan => _tagihan;
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

  Future<void> checkPinjaman() async {
    Map<dynamic, dynamic> pinjaman = await _userService.getLoan();
    Map<dynamic, dynamic> active = pinjaman['active'];
    print(pinjaman);

    if (active.isEmpty) {
      _tagihan = 0;
    } else {
      _tagihan = active['amount'];
    }
    _history = pinjaman['history'];
    notifyListeners();
  }

  Future<void> checkKyc() async {
    final token = await _secureStorage.read(key: 'jwtToken').toString();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    print(decodedToken);
    // _kyc = kyc;
    // notifyListeners();
  }

  deleteAll() async {
    print("hapus semua");
    _active = null;
    _balance = "0";
    _tagihan = null;
    _history = [];
    _loading = true;
    _kyc = false;
    notifyListeners();
  }

  Future<void> getBank() async {
    await _userService.getBankAccount();
    _banks = banks;
    notifyListeners();
  }
}
