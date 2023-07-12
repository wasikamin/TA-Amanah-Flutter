import 'dart:async';
import 'package:amanah/models/bank.dart';
import 'package:amanah/services/balance_service.dart';
import 'package:amanah/services/loan_service.dart';
import 'package:amanah/services/user_service.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

class UserProvider with ChangeNotifier {
  // final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  int _balance = 0;
  Map<dynamic, dynamic>? _tagihan;
  List<dynamic> _paymentSchedule = [];
  Map<dynamic, dynamic> _active = {};
  List _history = [];
  bool _loading = true;
  bool _kyc = false;
  List<Bank> _banks = [];
  int _totalYield = 0;
  int _totalFunding = 0;
  Map<dynamic, dynamic>? _portofolio;
  Map<dynamic, dynamic> disbursement = {};
  Map<dynamic, dynamic> _autoLend = {};

  List<Bank> get banks => _banks;
  List get history => _history;
  Map<dynamic, dynamic> get active => _active;
  int get totalYield => _totalYield;
  int get totalFunding => _totalFunding;
  bool get kyc => _kyc;
  Map<dynamic, dynamic>? get tagihan => _tagihan;
  List<dynamic> get paymentSchedule => _paymentSchedule;
  int get balance => _balance;
  bool get loading => _loading;
  Map<dynamic, dynamic>? get portofolio => _portofolio;
  Map<dynamic, dynamic> get disburse => disbursement;
  Map<dynamic, dynamic> get autoLend => _autoLend;
  final UserService _userService = UserService();
  final _balanceService = BalanceService();
  final _loanservice = LoanService();

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
    await Future.delayed(Duration.zero, () async {
      // print("test");
      _loading = true;
      _active = {};
      _history = [];
      notifyListeners();
    });
    Map<dynamic, dynamic> pinjaman = await _userService.getLoan();
    Map<dynamic, dynamic> active = pinjaman['active'];
    _active = active;
    _history = pinjaman['history'];
    _loading = false;
    notifyListeners();
  }

  // Future<void> checkKyc() async {
  //   final token = await _secureStorage.read(key: 'jwtToken').toString();
  //   Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  //   print(decodedToken);
  //   // _kyc = kyc;
  //   // notifyListeners();
  // }

  Future<void> checkAutoLend() async {
    await Future.delayed(Duration.zero, () async {
      _autoLend = {};
      notifyListeners();
    });
    Map<dynamic, dynamic> response = await _loanservice.getAutoLendStatus();
    _autoLend = response;
    notifyListeners();
  }

  deleteAll() async {
    print("hapus semua");
    _active = {};
    _balance = 0;
    _tagihan = null;
    _history = [];
    _loading = true;
    _kyc = false;
    _banks = [];
    _totalYield = 0;
    _totalFunding = 0;
    _portofolio = null;
    _paymentSchedule = [];
    disbursement = {};
    _autoLend = {};
    notifyListeners();
  }

  Future<void> getBank() async {
    try {
      _banks = [];
      var response = await _balanceService.getBankAccount();
      for (var element in response) {
        _banks.add(Bank(
          bankName: element.bankName,
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

  Future<void> getPortofolio() async {
    try {
      await Future.delayed(Duration.zero, () async {
        _portofolio = null;
        notifyListeners();
      });

      _portofolio = await _loanservice.getPortofolio();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getDisbursement() async {
    try {
      await Future.delayed(Duration.zero, () async {
        disbursement = {};
        notifyListeners();
      });

      disbursement = await _userService.getDisbursement(this);
      // print(disbursement);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  setDisbursement(Map<dynamic, dynamic> data) {
    disbursement = data;
    // print(data);
    notifyListeners();
  }

  Future<void> checkTagihan() async {
    try {
      await Future.delayed(Duration.zero, () async {
        // _tagihan = {};
        // _paymentSchedule = [];
        _loading = true;
        notifyListeners();
      });

      Map<dynamic, dynamic> payment = await _userService.getPaymentSchedule();
      // print(payment['paymentSchedule']);
      _paymentSchedule = payment['paymentSchedule'];
      _tagihan = {
        'currentMonth': payment['currentMonth'],
        'loanId': payment['loanId'],
      };
      _loading = false;
      notifyListeners();
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
