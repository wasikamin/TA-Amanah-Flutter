import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationService {
  static const String _baseUrl = 'https://ta-backend-api.as.r.appspot.com/api';
  static const String _sendOtpEndpoint = '/authentication/login?action=login';
  static const String _loginEndpoint = '/authentication/login?action=email-otp';

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

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

      return responseBody['data']['userId'];
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> sendOtp(String Otp, String email) async {
    final url = Uri.parse('$_baseUrl $_sendOtpEndpoint');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'otp': Otp,
      },
    );

    if (response.statusCode == 200) {
      // OTP sent successfully
      final responseBody = json.decode(response.body);
      final token = responseBody['data']['accessToken'] as String;
      await _secureStorage.write(key: 'jwt_token', value: token);
    } else {
      throw Exception('Failed to send OTP');
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'jwt_token');
    // Perform logout logic here
  }
}
