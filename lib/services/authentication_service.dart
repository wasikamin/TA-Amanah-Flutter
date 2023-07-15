import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthenticationService {
  static const String _sendOtpEndpoint = '/authentication/login?action=login';
  static const String _loginEndpoint = '/authentication/login?action=email-otp';
  static const String _resendOtpEndpoint = '/authentication/login/otp/resend';
  static const String _refreshTokenEndpoint = '/authentication/token/refresh';
  static const String _getKYCStatus = '/authentication/account/status';

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  //LOGIN
  Future<String> login(String email, String password) async {
    final baseUrl = dotenv.env['API_BASE_URL'].toString();
    final url = Uri.parse('$baseUrl$_loginEndpoint');
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
  Future<dynamic> register(
      {required String name,
      required String email,
      required String phoneNumber,
      required String roles,
      required String password}) async {
    final baseUrl = dotenv.env['API_BASE_URL'].toString();
    final url = Uri.parse('$baseUrl/authentication/register');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "name": name,
          "phoneNumber": phoneNumber,
          "roles": roles,
          "password": password
        }));
    // print(json.decode(response.body));
    if (response.statusCode == 201) {
      // final responseBody = json.decode(response.body);
      return response;
    } else {
      final responseBody = json.decode(response.body);
      throw responseBody["message"];
    }
  }

  //SENDING OTP
  Future<void> sendOtp(String Otp, String email) async {
    final baseUrl = dotenv.env['API_BASE_URL'].toString();
    final url = Uri.parse('$baseUrl$_sendOtpEndpoint');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, 'otp': Otp}));
    print(json.decode(response.body));
    final responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      // OTP sent successfully

      final token = responseBody['data']['accessToken'] as String;
      final refreshToken = responseBody['data']['refreshToken'] as String;
      await _secureStorage.write(key: 'jwtToken', value: token);
      await _secureStorage.write(key: 'refreshToken', value: refreshToken);
    } else {
      throw responseBody['message'];
    }
  }

  Future<void> resendOtp(String email) async {
    final baseUrl = dotenv.env['API_BASE_URL'].toString();
    final url = Uri.parse('$baseUrl$_resendOtpEndpoint');
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

  Future<void> changePassword(String email, token, newPassword) async {
    final baseUrl = dotenv.env['API_BASE_URL'].toString();
    const changePasswordUrl =
        "/authentication/password/reset/change?action=forget-password";
    final url = Uri.parse('$baseUrl$changePasswordUrl');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {'email': email, 'token': token, 'newPassword': newPassword}));
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      // OTP resent successfully
      final responseBody = json.decode(response.body);
      return responseBody['message'];
    } else {
      print('Failed to resend OTP');
    }
  }

  Future<void> forgetPassword(String email) async {
    final baseUrl = dotenv.env['API_BASE_URL'].toString();
    const changePasswordUrl = "/authentication/password/reset/request";
    final url = Uri.parse('$baseUrl$changePasswordUrl');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, 'platform': "mobile"}));
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
    final baseUrl = dotenv.env['API_BASE_URL'].toString();
    final url = Uri.parse('$baseUrl$_refreshTokenEndpoint');
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
      // print(responseBody);
      return responseBody['message'];
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  Future<dynamic> getKYCStatus() async {
    try {
      final baseUrl = dotenv.env['API_BASE_URL'].toString();
      final url = Uri.parse('$baseUrl$_getKYCStatus');
      final token = await _secureStorage.read(key: 'jwtToken');
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "authorization": "bearer $token"
      });
      // print(response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        // print("berhasil");
        return responseBody['data']['kyc'];
      } else {
        // print(response.statusCode.toString());
        throw Exception('Failed to get KYC status');
      }
    } catch (e) {
      throw e;
    }
  }
}
