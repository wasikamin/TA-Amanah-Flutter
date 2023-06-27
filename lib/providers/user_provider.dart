import 'dart:async';
import 'package:amanah/models/bank.dart';
import 'package:amanah/services/balance_service.dart';
import 'package:amanah/services/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserProvider with ChangeNotifier {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  int _balance = 0;
  int? _tagihan;
  Map<dynamic, dynamic>? _active;
  List _history = [];
  bool _loading = true;
  bool _kyc = false;
  List<Bank> _banks = [];
  int _totalYield = 0;
  int _totalFunding = 0;

  List<Bank> get banks => _banks;
  List get history => _history;
  Map<dynamic, dynamic>? get active => _active;
  int get totalYield => _totalYield;
  int get totalFunding => _totalFunding;
  bool get kyc => _kyc;
  int? get tagihan => _tagihan;
  int get balance => _balance;
  bool get loading => _loading;
  final UserService _userService = UserService();
  final _balanceService = BalanceService();

  //constructor
  // UserProvider() {
  //   checkSaldo();
  // }

  Future<void> checkSaldo() async {
    await Future.delayed(Duration.zero, () async {
      _loading = true;
      notifyListeners();
    });
    Map<dynamic, dynamic> profit = await _userService.getProfit();
    _totalYield = profit['totalYield'].round();
    _totalFunding = profit['totalFunding'];
    var saldo = await _userService.getBalance();
    _balance = saldo;
    _loading = false;
    notifyListeners();
  }

  Future<void> checkPinjaman() async {
    Map<dynamic, dynamic> pinjaman = await _userService.getLoan();
    Map<dynamic, dynamic> active = pinjaman['active'];
    // print(pinjaman['active']);

    if (active.isEmpty) {
      _tagihan = 0;
    } else {
      _tagihan = active['amount'];
      _active = active;
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
    _balance = 0;
    _tagihan = null;
    _history = [];
    _loading = true;
    _kyc = false;
    notifyListeners();
  }

  Future<void> getBank() async {
    try {
      _banks = [];
      var response = await _balanceService.getBankAccount();
      for (var element in response) {
        _banks.add(Bank(
          accountNumber: element.accountNumber,
          bankCode: element.bankCode,
          id: element.id,
        ));
      }
      // print(_banks);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
