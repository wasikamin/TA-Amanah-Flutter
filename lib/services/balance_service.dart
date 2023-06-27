import 'dart:convert';

import 'package:amanah/models/availableBank.dart';
import 'package:amanah/models/bank.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BalanceService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  Future<dynamic> deposit(int amount) async {
    try {
      final _baseUrl = dotenv.env['API_BASE_URL'].toString();
      final _depositUrl = '/balance/deposit';
      final token = await _secureStorage.read(key: 'jwtToken');
      final url = Uri.parse('$_baseUrl$_depositUrl');
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: json.encode({"amount": amount}),
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        return responseBody['data'];
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody["message"];
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getAvailableBank() async {
    final baseUrl = dotenv.env['API_BASE_URL'].toString();
    const availableBankUrl = '/balance/banks';
    final token = await _secureStorage.read(key: 'jwtToken');
    final url = Uri.parse('$baseUrl$availableBankUrl');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    if (response.statusCode == 200) {
      final responseBody = await json.decode(response.body);
      var models = AvailableBank.fromJsonList(responseBody['data']);
      return models;
    } else {
      final responseBody = json.decode(response.body);
      throw responseBody["message"];
    }
  }

  Future<dynamic> addBankAccount(String bankCode, int accountNumber) async {
    try {
      final _baseUrl = dotenv.env['API_BASE_URL'].toString();
      final _addBankUrl = '/balance/account';
      final token = await _secureStorage.read(key: 'jwtToken');
      final url = Uri.parse('$_baseUrl$_addBankUrl');
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body:
            json.encode({"bankCode": bankCode, "accountNumber": accountNumber}),
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        return responseBody['data'];
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody["message"];
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getBankAccount() async {
    try {
      final _baseUrl = dotenv.env['API_BASE_URL'].toString();
      final token = await _secureStorage.read(key: 'jwtToken');
      const String _getBankAccountUrl = "/balance/account";
      final url = Uri.parse('$_baseUrl$_getBankAccountUrl');
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
        var models = Bank.fromJsonList(responseBody['data']);
        // print(models);
        return models;
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody["message"];
      }
    } catch (e) {
      print("test");
      print(e);
    }
  }

  Future<dynamic> withdraw(
      int accountNumber, String bankCode, int amount) async {
    try {
      final _baseUrl = dotenv.env['API_BASE_URL'].toString();
      final _depositUrl = '/balance/withdraw';
      final token = await _secureStorage.read(key: 'jwtToken');
      final url = Uri.parse('$_baseUrl$_depositUrl');
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: json.encode({
          "accountNumber": accountNumber,
          "bankCode": bankCode,
          "amount": amount
        }),
      );
      if (response.statusCode == 200) {
        print(response.body);
        final responseBody = json.decode(response.body);
        return responseBody['data'];
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody["message"];
      }
    } catch (e) {
      print(e);
    }
  }
}
