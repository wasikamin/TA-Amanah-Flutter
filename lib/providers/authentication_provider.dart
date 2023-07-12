import 'dart:convert';

import 'package:amanah/providers/user_provider.dart';
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
  bool _loading = false;
  bool _isLoggedIn = false;
  String _userId = "";
  String _email = "";
  String _message = "";
  String _role = "";
  String _kyced = "";
  bool get loading => _loading;
  String get role => _role;
  String get email => _email;
  String get userId => _userId;
  String get message => _message;
  bool get isLoggedIn => _isLoggedIn;
  String get kyced => _kyced;
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
      var response = await _authenticationService.register(
          name: name,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          roles: roles);
      final responseBody = json.decode(response.body);
      print(responseBody);
      // if (responseBody == 201) {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyScreen(
            email: responseBody['data']['email'],
          ),
        ),
      );
      // }
    } catch (error) {
      throw error;
    }
  }

  Future<void> sendOtp(String Otp, String email, BuildContext context) async {
    try {
      _loading = true;
      notifyListeners();
      await _authenticationService.sendOtp(Otp, email);
      final token = await _secureStorage.read(key: 'jwtToken');
      _loading = false;
      notifyListeners();
      checkJwt(token);
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
      // print(error);
      _loading = false;
      _message = error.toString();
      notifyListeners();
      Future.delayed(const Duration(seconds: 5), () {
        // code to be executed after 2 seconds
        _message = "";
        notifyListeners();
      });
    }
  }

  setMessage(String message) {
    _message = message;
    notifyListeners();
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
    _kyced = "";
    _role = "";
    _message = "";
    _isLoggedIn = false;
    await UserProvider().deleteAll();
    notifyListeners();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  Future<bool> checkJwt(jwtToken) async {
    try {
      bool hasExpired = JwtDecoder.isExpired(jwtToken);
      //check expired date jwt
      if (!hasExpired) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
        // print(decodedToken);
        _role = decodedToken['roles'];
        _kyced = decodedToken['verifiedKYC'];
        notifyListeners();
        return false;
      } else {
        _authenticationService.refreshToken();
        final token = await _secureStorage.read(key: 'jwtToken');
        checkJwt(token);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> checkKyc() async {
    try {
      // print("Test");

      String status = await _authenticationService.getKYCStatus();
      // print(status);
      if (status == _kyced) {
        // print("berhasil");
        _kyced == status;
      } else {
        await refreshToken();
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> refreshToken() async {
    try {
      await _authenticationService.refreshToken();
      final token = await _secureStorage.read(key: 'jwtToken');
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
      _kyced = decodedToken['verifiedKYC'];
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
