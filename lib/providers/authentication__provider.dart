import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:amanah/services/authentication_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _userId = "";
  String get userId => _userId;
  bool get isLoggedIn => _isLoggedIn;
  final AuthenticationService _authenticationService = AuthenticationService();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  //constructor
  AuthenticationProvider() {
    checkAutoLogin();
  }

  Future<void> checkAutoLogin() async {
    final token = await _secureStorage.read(key: 'userId');

    if (token != null) {
      print(token);
      _isLoggedIn = true;
    } else {
      _isLoggedIn = false;
    }

    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      print(password);
      print(email);
      var id = await _authenticationService.login(email, password);
      _userId = id;
      _isLoggedIn = true;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> logout() async {
    // Perform logout logic and update _isLoggedIn accordingly
    // ...

    notifyListeners();
  }
}
