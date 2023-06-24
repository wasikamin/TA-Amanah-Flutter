import 'dart:convert';
import 'dart:async';
import 'package:amanah/models/loan.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoanService {
  Future<dynamic> getAvailableLoan(
      {int tenorMin = 0,
      int tenorMax = 12,
      int yieldMin = 0,
      yieldMax = 1000000000}) async {
    try {
      final _baseUrl = dotenv.env['API_BASE_URL'].toString();
      final _kycUrl =
          "/loans/available?sort=createdDate&order=desc&page=1&limit=10&tenor_min=$tenorMin&tenor_max=$tenorMax&yield_min=$yieldMin&yield_max=$yieldMax";
      final url = Uri.parse('$_baseUrl$_kycUrl');
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
