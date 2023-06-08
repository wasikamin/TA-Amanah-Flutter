import 'package:amanah/screens/Authentication/login_screen.dart';
import 'package:amanah/screens/Authentication/otp_screen.dart';
import 'package:amanah/screens/Authentication/verify_screen.dart';
import 'package:amanah/screens/Borrower/Home/borrower_homepage_screen.dart';
import 'package:amanah/screens/Lenders/home/homepage_screen.dart';
import 'dart:async';
import 'package:amanah/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthenticationProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _userId = "";
  String _email = "";
  String _message = "";
  String _role = "";
  String get role => _role;
  String get email => _email;
  String get userId => _userId;
  String get message => _message;
  bool get isLoggedIn => _isLoggedIn;
  final AuthenticationService _authenticationService = AuthenticationService();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  //constructor
  AuthenticationProvider() {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final token = await _secureStorage.read(key: 'jwtToken');
    if (token != null) {
      final jwtExpired = await checkJwt(token);
      if (!jwtExpired) {
        print(_role);
        _isLoggedIn = true;
      } else {
        _isLoggedIn = false;
      }
    }

    notifyListeners();
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      // print(password);
      // print(email);
      var id = await _authenticationService.login(email, password);

      _userId = id;
      notifyListeners();

      if (_userId != "") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(),
          ),
        );
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> register(String email, String password, String name,
      String phoneNumber, String roles, BuildContext context) async {
    try {
      // print(password);
      // print(email);
      var statusCode = await _authenticationService.register(
          name: name,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          roles: roles);

      if (statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyScreen(),
          ),
        );
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> sendOtp(String Otp, String email, BuildContext context) async {
    try {
      await _authenticationService.sendOtp(Otp, email);
      final token = await _secureStorage.read(key: 'jwtToken');
      checkJwt(token);
      print(token);
      if (_role == "lender") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        ).then((value) =>
            Navigator.of(context).popUntil((route) => route.isFirst));
      } else if (_role == "borrower") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BorrowerHomePage(),
          ),
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> resendOtp(String email) async {
    try {
      _authenticationService.resendOtp(email);
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout(BuildContext context) async {
    // Perform logout logic and update _isLoggedIn accordingly
    // ...
    await _secureStorage.delete(key: 'userId');
    await _secureStorage.delete(key: 'email');
    await _secureStorage.delete(key: 'jwtToken');
    _userId = "";
    _email = "";
    _isLoggedIn = false;
    notifyListeners();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  Future<bool> checkJwt(jwtToken) async {
    bool hasExpired = JwtDecoder.isExpired(jwtToken);
    //check expired date jwt
    if (!hasExpired) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
      _role = decodedToken['roles'];
      notifyListeners();
      return false;
    }
    return true;

    //fungsi refresh jwt
  }
}
