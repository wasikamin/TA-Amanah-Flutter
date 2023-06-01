import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationService {
  static const String _baseUrl = 'https://ta-backend-api.as.r.appspot.com/api';
  static const String _sendOtpEndpoint = '/authentication/login?action=login';
  static const String _loginEndpoint = '/authentication/login?action=email-otp';
  static const String _resendOtpEndpoint = '/authentication/login/otp/resend';

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  //LOGIN
  Future<String> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl$_loginEndpoint');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, 'password': password}));
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final userId = responseBody['data']['userId'] as String;

      await _secureStorage.write(key: 'userId', value: userId);
      await _secureStorage.write(key: 'email', value: email);

      return responseBody['data']['userId'];
    } else {
      final responseBody = json.decode(response.body);
      throw responseBody["message"];
    }
  }

  //SENDING OTP
  Future<void> sendOtp(String Otp, String email) async {
    final url = Uri.parse('$_baseUrl$_sendOtpEndpoint');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, 'otp': Otp}));
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      // OTP sent successfully
      final responseBody = json.decode(response.body);
      final token = responseBody['data']['accessToken'] as String;
      await _secureStorage.write(key: 'jwtToken', value: token);
    } else {
      print('Failed to send OTP');
    }
  }

  Future<void> resendOtp(String email) async {
    final url = Uri.parse('$_baseUrl$_resendOtpEndpoint');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email}));
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      // OTP resent successfully
      final responseBody = json.decode(response.body);
      return responseBody['message'];
    } else {
      print('Failed to resend OTP');
    }
  }

  // Future<void> logout() async {
  //   await _secureStorage.delete(key: 'jwt_token');
  //   // Perform logout logic here
  // }
}
