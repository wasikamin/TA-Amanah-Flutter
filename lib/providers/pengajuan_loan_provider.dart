import 'package:amanah/models/availableBank.dart';
import 'package:amanah/models/bank.dart';
import 'package:flutter/material.dart';

class PengajuanLoanProvider with ChangeNotifier {
  String _borrowingCategory = "", _purpose = "", _paymentSchema = "";

  Bank? _bank;
  String _loanId = "", _productLink = "";
  int _tenor = 0, _amount = 0, _yieldReturn = 0;
  bool _loading = false;
  String _account = "";

  AvailableBank? _availableBank;

  get borrowingCategory => _borrowingCategory;
  get purpose => _purpose;
  get paymentSchema => _paymentSchema;
  get tenor => _tenor;
  get amount => _amount;
  get yieldReturn => _yieldReturn;
  get bank => _bank;
  get loanId => _loanId;
  get loading => _loading;
  get productLink => _productLink;
  get account => _account;
  get availableBank => _availableBank;

  Future<void> setBorrowing(
      String borrowingCategory,
      String purpose,
      String paymentScheme,
      String tenor,
      int amount,
      int yieldReturn,
      String productLink) async {
    _borrowingCategory = borrowingCategory;
    _purpose = purpose;
    _amount = amount;
    _yieldReturn = yieldReturn;
    _productLink = productLink;
    switch (tenor) {
      case '3 Bulan':
        _tenor = 3;
        break;
      case '6 Bulan':
        _tenor = 6;
        break;
      case '12 Bulan':
        _tenor = 12;
        break;
      default:
        _tenor = 0;
        break;
    }
    switch (paymentScheme) {
      case 'Lunas':
        _paymentSchema = 'Pelunasan Langsung';
        break;
      case 'Cicilan':
        _paymentSchema = 'Pelunasan Cicilan';
        break;
    }

    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> setDisbursementData(
      AvailableBank bank, dynamic loanId, account) async {
    _availableBank = bank;
    _loanId = loanId;
    _account = account;

    notifyListeners();
  }
}
