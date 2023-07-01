import 'package:amanah/services/transaction_history_service.dart';
import 'package:flutter/foundation.dart';

class TransactionHistoryProvider with ChangeNotifier {
  TransactionHistoryService _transactionHistoryService =
      TransactionHistoryService();
  List<dynamic> _withdrawHistory = [];
  List<dynamic> _depositHistory = [];
  bool _isloading = false;

  List<dynamic> get withdrawHistoryList => _withdrawHistory;
  List<dynamic> get depositHistoryList => _depositHistory;
  bool get isLoading => _isloading;

  void setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  Future<void> fetchHistory() async {
    await Future.delayed(Duration.zero, () async {
      setLoading(true);
    });
    //fetch deposit history
    await _transactionHistoryService.getDepositHistory().then((value) {
      _depositHistory = value;
      notifyListeners();
    }).catchError((e) {
      _isloading = false;
      notifyListeners();
    });

    //fetch withdraw history
    await _transactionHistoryService.getWithdrawHistory().then((value) {
      _withdrawHistory = value;
      _isloading = false;
      notifyListeners();
    }).catchError((e) {
      _isloading = false;
      notifyListeners();
    });
  }

  void clear() {
    _withdrawHistory = [];
    _depositHistory = [];
    _isloading = false;
    notifyListeners();
  }
}
