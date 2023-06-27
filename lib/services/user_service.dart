import 'dart:convert';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String _checkBalanceUrl = '/balance';
  static const String _getLoanUrl = "/borrowers/loan";

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<dynamic> getBalance() async {
    try {
      final token = await _secureStorage.read(key: 'jwtToken');
      var _baseUrl = dotenv.env['API_BASE_URL'].toString();
      final url = Uri.parse('$_baseUrl$_checkBalanceUrl');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        // print(responseBody);
        return responseBody['data']['balance'];
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody["message"];
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getProfit() async {
    try {
      final token = await _secureStorage.read(key: 'jwtToken');
      const String getProfitUrl = "/lenders/profit";
      var _baseUrl = dotenv.env['API_BASE_URL'].toString();
      final url = Uri.parse('$_baseUrl$getProfitUrl');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        // print(responseBody);
        return responseBody['data'];
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody["message"];
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getLoan() async {
    try {
      final _baseUrl = dotenv.env['API_BASE_URL'].toString();
      final token = await _secureStorage.read(key: 'jwtToken');
      final url = Uri.parse('$_baseUrl$_getLoanUrl');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        return responseBody['data'];
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody["message"];
      }
    } catch (e) {
      throw (e);
    }
  }
}
