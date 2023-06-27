import 'dart:convert';
import 'dart:async';
import 'package:amanah/models/loan.dart';
import 'package:amanah/providers/pengajuan_loan_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoanService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  //Post New Loan
  Future<dynamic> postLoan(PengajuanLoanProvider pengajuanLoanProvider) async {
    try {
      final _baseUrl = dotenv.env['API_BASE_URL'].toString();

      final token = await _secureStorage.read(key: 'jwtToken');
      final _postLoanUrl = "/borrowers/loan";
      final url = Uri.parse('$_baseUrl$_postLoanUrl');
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: json.encode({
          "borrowingCategory": pengajuanLoanProvider.borrowingCategory,
          "purpose": pengajuanLoanProvider.purpose,
          "amount": pengajuanLoanProvider.amount,
          "tenor": pengajuanLoanProvider.tenor,
          "yieldReturn": pengajuanLoanProvider.yieldReturn,
          "paymentSchema": pengajuanLoanProvider.paymentSchema,
        }),
      );
      if (response.statusCode < 400) {
        final responseBody = json.decode(response.body);
        print(responseBody);
        return responseBody;
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody["message"];
      }
    } catch (e) {
      throw e;
    }
  }

  //Get Available Loan
  Future<dynamic> getAvailableLoan(
      {int tenorMin = 0,
      int tenorMax = 12,
      int yieldMin = 0,
      yieldMax = 1000000000}) async {
    try {
      final _baseUrl = dotenv.env['API_BASE_URL'].toString();
      final _getAvailableLoanUrl =
          "/loans/available?sort=createdDate&order=desc&page=1&limit=10&tenor_min=$tenorMin&tenor_max=$tenorMax&yield_min=$yieldMin&yield_max=$yieldMax";
      final url = Uri.parse('$_baseUrl$_getAvailableLoanUrl');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        // print(responseBody['data']);
        List<dynamic> loanData = responseBody['data'];

        List<Loan> loans = loanData
            .map<Loan>((item) => Loan(
                  loanId: item['loanId'],
                  userId: item['userId'],
                  purpose: item['purpose'],
                  borrowingCategory: item['borrowingCategory'],
                  amount: item['amount'],
                  tenor: item['tenor'],
                  yieldReturn: item['yieldReturn'],
                  status: item['status'],
                  totalFunding: item['totalFunding'],
                  borrowerId: item['borrower']['borrowerId'],
                  name: item['borrower']['name'],
                  email: item['borrower']['email'],
                  paymentSchema: item['paymentSchema'],
                ))
            .toList();
        return loans;
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody["message"];
      }
    } catch (e) {
      print(e);
    }
  }
}
