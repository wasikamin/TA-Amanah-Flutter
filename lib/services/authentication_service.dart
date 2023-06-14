import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthenticationService {
  String _baseUrl = "";
  static const String _sendOtpEndpoint = '/authentication/login?action=login';
  static const String _loginEndpoint = '/authentication/login?action=email-otp';
  static const String _resendOtpEndpoint = '/authentication/login/otp/resend';
  static const String _refreshTokenEndpoint = '/authentication/token/refresh';

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  //LOGIN
  Future<String> login(String email, String password) async {
    _baseUrl = dotenv.env['API_BASE_URL'].toString();
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

  //Register
  Future<int> register(
      {required String name,
      required String email,
      required String phoneNumber,
      required String roles,
      required String password}) async {
    _baseUrl = dotenv.env['API_BASE_URL'].toString();
    final url = Uri.parse('$_baseUrl/authentication/register');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "name": name,
          "phoneNumber": phoneNumber,
          "roles": roles,
          "password": password
        }));
    print(json.decode(response.body));
    if (response.statusCode == 201) {
      return response.statusCode.toInt();
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
      final refreshToken = responseBody['data']['refreshToken'] as String;
      await _secureStorage.write(key: 'jwtToken', value: token);
      await _secureStorage.write(key: 'refreshToken', value: refreshToken);
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

  Future<void> refreshToken() async {
    // Perform refresh token logic here
    final url = Uri.parse('$_baseUrl$_refreshTokenEndpoint');
    final refreshToken = await _secureStorage.read(key: 'refreshToken');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'refreshToken': refreshToken}));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final jwtToken = responseBody['data']['accessToken'] as String;
      final newRefreshToken = responseBody['data']['refreshToken'] as String;
      await _secureStorage.write(key: 'jwtToken', value: jwtToken);
      await _secureStorage.write(key: 'refreshToken', value: newRefreshToken);
      return responseBody['message'];
    } else {
      throw Exception('Failed to refresh token');
    }
  }
}
