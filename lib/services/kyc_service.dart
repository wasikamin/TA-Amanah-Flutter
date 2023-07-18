import 'dart:io';

import 'package:amanah/providers/kyc_provider.dart';
import 'package:http_parser/http_parser.dart';
// import 'dart:convert';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class KycService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<int> kycBorrower(KycProvider kycProvider) async {
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
      'personal.work.salary': kycProvider.salary.toString(),
      'personal.work.annualIncome': kycProvider.annualIncome.toString(),
      'personal.homeOwnershipType': kycProvider.homeOwnershipType,
      'personal.work.totalMonthlyDebt': kycProvider.totalMonthlyDebt.toString(),
      'personal.idCardNumber': kycProvider.idCardNumber,
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

    request.files.add(http.MultipartFile.fromBytes(
        'idCardImage', await File(kycProvider.ktpImage).readAsBytes(),
        filename: 'ktpImage.webp', contentType: MediaType("image", "webp")));
    request.files.add(await http.MultipartFile.fromPath(
      'faceImage',
      kycProvider.faceImage,
      filename: 'FaceImage.webp',
      contentType: MediaType('image', 'webp'),
    ));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      kycProvider.setLoading(false);
      // print(await response.stream.bytesToString());
      return response.statusCode;
    } else {
      print(await response.stream.bytesToString());
      throw response.statusCode;
    }
  }

  Future<int> kycLender(KycProvider kycProvider) async {
    final _baseUrl = dotenv.env['API_BASE_URL'].toString();
    final _kycUrl = "/lenders/request/verification";
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
      'personal.idCardNumber': kycProvider.idCardNumber,
    });
    request.files.add(http.MultipartFile.fromBytes(
        'idCardImage', await File(kycProvider.ktpImage).readAsBytes(),
        filename: 'ktpImage.webp', contentType: MediaType("image", "webp")));
    request.files.add(await http.MultipartFile.fromPath(
      'faceImage',
      kycProvider.faceImage,
      filename: 'FaceImage.webp',
      contentType: MediaType('image', 'webp'),
    ));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      kycProvider.setLoading(false);
      // print(await response.stream.bytesToString());
      return response.statusCode;
    } else {
      // print(await response.stream.bytesToString());
      return response.statusCode;
    }
  }
}
