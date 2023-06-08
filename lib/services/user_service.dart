import 'dart:convert';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:amanah/providers/kyc_provider.dart';

class UserService {
  // static const String _checkBalanceUrl = '/balance';
  KycProvider kycProvider = KycProvider();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

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

  Future<void> kycUser() async {
    final _baseUrl = dotenv.env['API_BASE_URL'].toString();
    final _kycUrl = "/borrowers/request/verification";
    final token = await _secureStorage.read(key: 'jwtToken');
    final url = Uri.parse('$_baseUrl$_kycUrl');
    var request = http.MultipartRequest('PUT', url);
    request.headers['authorization'] = 'Bearer $token';
    request.fields.addAll({
      'personal.fullName': kycProvider.fullName,
      'personal.gender': kycProvider.gender,
      'personal.birthDate': kycProvider.birthDate,
      'personal.work.name': kycProvider.work,
      'personal.work.salary': kycProvider.salary,
      'relativesContact.firstRelative.name': kycProvider.relativeContactName1,
      'relativesContact.firstRelative.relation':
          kycProvider.relativeContactRelation1,
      'relativesContact.firstRelative.phoneNumber':
          kycProvider.relativeContactPhone1,
      'relativesContact.secondRelative.name': kycProvider.relativeContactName2,
      'relativesContact.secondRelative.relation':
          kycProvider.relativeContactRelation2,
      'relativesContact.secondRelative.phoneNumber':
          kycProvider.relativeContactPhone2,
    });
    request.files.add(
        await http.MultipartFile.fromPath('idCardImage', kycProvider.ktpImage));
    request.files.add(
        await http.MultipartFile.fromPath('faceImage', kycProvider.faceImage));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
