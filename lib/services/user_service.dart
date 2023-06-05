import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  // static const String _checkBalanceUrl = '/balance';
  // final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<dynamic> getBalance() async {
    try {
      // final token = await _secureStorage.read(key: 'jwtToken');
      // var _baseUrl = dotenv.env['API_BASE_URL'].toString();
      // final url = Uri.parse('$_baseUrl$_checkBalanceUrl');
      final url = Uri.parse('https://apimocha.com/amanah/balance');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          // "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        print(responseBody);
        return responseBody['data']['balance'];
      } else {
        // final responseBody = json.decode(response.body);
        // throw responseBody["message"];
      }
    } catch (e) {
      print(e);
    }
  }
}
