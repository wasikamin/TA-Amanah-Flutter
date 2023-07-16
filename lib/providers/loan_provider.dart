import 'package:amanah/models/loan.dart';
import 'package:amanah/services/loan_service.dart';
import 'package:flutter/material.dart';

class LoanProvider with ChangeNotifier {
  final LoanService _loanService = LoanService();
  bool loading = true;
  List<Loan> _loan = [];
  List<Loan> _loanRekomendasi = [];

  //getter
  get loan => _loan;
  get loanRekomendasi => _loanRekomendasi;

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

  Future<void> getLoanRekomendasi() async {
    // print("masuk provider");
    await Future.delayed(Duration.zero, () async {
      setLoading();
    });
    List<Loan> loan = await _loanService.getRecommendationLoan();
    _loanRekomendasi = loan;
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
