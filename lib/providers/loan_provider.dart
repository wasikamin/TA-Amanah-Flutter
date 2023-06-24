import 'package:amanah/models/loan.dart';
import 'package:amanah/services/loan_service.dart';
import 'package:flutter/material.dart';

class LoanProvider with ChangeNotifier {
  final LoanService _loanService = LoanService();
  bool loading = true;
  List<Loan> _loan = [];

  //getter
  get loan => _loan;

  Future<void> getLoan(
      {int tenorMin = 0,
      int tenorMax = 12,
      int yieldMin = 0,
      yieldMax = 1000000000}) async {
    // print("masuk provider");
    await Future.delayed(Duration.zero, () async {
      setLoading();
    });
    List<Loan> loan = await _loanService.getAvailableLoan(
        tenorMax: tenorMax,
        tenorMin: tenorMin,
        yieldMax: yieldMax,
        yieldMin: yieldMin);
    _loan = loan;
    loading = false;
    notifyListeners();
  }

  setLoading() {
    loading = true;
    notifyListeners();
  }

  deleteLoan() {
    _loan = [];
    notifyListeners();
  }
}
