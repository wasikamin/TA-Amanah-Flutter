import 'package:amanah/services/user_service.dart';
import 'package:flutter/material.dart';

class UserProfileProvider with ChangeNotifier {
  final UserService _userService = UserService();
  String _name = "";
  String _phoneNumber = "";
  String _email = "";
  bool _isVerified = false;
  String _loanLimit = "0";
  Map<dynamic, dynamic> performance = {};

  String get name => _name;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  bool get isVerified => _isVerified;
  String get loanLimit => _loanLimit;

  Future<void> getProfile() async {
    Map<dynamic, dynamic> response = await _userService.getProfile();
    _name = response['name'];
    if (response["phoneNumber"].runtimeType == int) {
      _phoneNumber = response["phoneNumber"].toString();
    } else {
      _phoneNumber = response['phoneNumber'];
    }
    _email = response['email'];
    _isVerified = response['verified'];
    if (response['loanLimit'] != null) {
      // print(response['loanLimit']);
      _loanLimit = response['loanLimit'];
    }
    if (response['performance'] != null) {
      performance = response['performance'];
    }
    notifyListeners();
  }
}
