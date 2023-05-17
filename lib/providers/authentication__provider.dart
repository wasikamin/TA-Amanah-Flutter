import 'package:flutter/foundation.dart';

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
