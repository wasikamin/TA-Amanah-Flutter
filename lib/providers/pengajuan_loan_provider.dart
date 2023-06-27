import 'package:amanah/models/bank.dart';
import 'package:flutter/material.dart';

class PengajuanLoanProvider with ChangeNotifier {
  String _borrowingCategory = "", _purpose = "", _paymentSchema = "";

  Bank? _bank;

  int _tenor = 0, _amount = 0, _yieldReturn = 0;

  get borrowingCategory => _borrowingCategory;
  get purpose => _purpose;
  get paymentSchema => _paymentSchema;
  get tenor => _tenor;
  get amount => _amount;
  get yieldReturn => _yieldReturn;
  get bank => _bank;

  Future<void> setBorrowing(String borrowingCategory, String purpose,
      String paymentScheme, String tenor, int amount, int yieldReturn) async {
    _borrowingCategory = borrowingCategory;
    _purpose = purpose;
    _amount = amount;
    _yieldReturn = yieldReturn;
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

  Future<void> setBank(Bank bank) async {
    _bank = bank;
    notifyListeners();
  }
}
