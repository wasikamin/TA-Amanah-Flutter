import 'dart:convert';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TransactionHistoryService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  Future<dynamic> getWithdrawHistory() async {
    try {
      final baseUrl = dotenv.env['API_BASE_URL'].toString();
      const getWithdrawHistoryUrl =
          '/balance/transaction/history?type=Withdraw';
      final token = await _secureStorage.read(key: 'jwtToken');
      final url = Uri.parse('$baseUrl$getWithdrawHistoryUrl');
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
      rethrow;
    }
  }

  Future<dynamic> getDepositHistory() async {
    try {
      final baseUrl = dotenv.env['API_BASE_URL'].toString();
      const getWithdrawHistoryUrl = '/balance/transaction/history?type=Deposit';
      final token = await _secureStorage.read(key: 'jwtToken');
      final url = Uri.parse('$baseUrl$getWithdrawHistoryUrl');
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
      rethrow;
    }
  }
}
