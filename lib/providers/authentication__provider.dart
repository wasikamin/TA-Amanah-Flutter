import 'package:flutter/foundation.dart';
import 'package:amanah/models/user.dart';
import 'package:amanah/services/authentication_service.dart';

class AuthenticationProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String email, String password) async {
    // Perform login logic and update _isLoggedIn accordingly
    // ...

    notifyListeners();
  }

  Future<void> logout() async {
    // Perform logout logic and update _isLoggedIn accordingly
    // ...

    notifyListeners();
  }
}
