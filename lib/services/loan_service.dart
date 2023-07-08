import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:amanah/models/loan.dart';
import 'package:amanah/providers/pengajuan_loan_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

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

  //dishbursement
  Future<dynamic> postDisbursement(
      PengajuanLoanProvider pengajuanLoanProvider) async {
    try {
      final baseUrl = dotenv.env['API_BASE_URL'].toString();
      final token = await _secureStorage.read(key: 'jwtToken');
      const postDisbursementUrl = "/borrowers/loan/disbursement";
      final url = Uri.parse('$baseUrl$postDisbursementUrl');
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: json.encode({
          "loanId": pengajuanLoanProvider.loanId,
          "bankId": pengajuanLoanProvider.bank!.id,
        }),
      );
      if (response.statusCode < 400) {
        final responseBody = json.decode(response.body);
        // print(responseBody);
        return responseBody;
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody["message"];
      }
    } catch (e) {
      rethrow;
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
      final token = await _secureStorage.read(key: 'jwtToken');
      final _getAvailableLoanUrl =
          "/loans/available?sort=createdDate&order=desc&page=1&limit=10&tenor_min=$tenorMin&tenor_max=$tenorMax&yield_min=$yieldMin&yield_max=$yieldMax";
      final url = Uri.parse('$_baseUrl$_getAvailableLoanUrl');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
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
                  createdDate: item['createdDate'],
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

  Future<dynamic> getLoanbyId(String id) async {
    try {
      final token = await _secureStorage.read(key: 'jwtToken');
      final baseUrl = dotenv.env['API_BASE_URL'].toString();
      final getLoanUrl = "/loans/available/$id";
      final url = Uri.parse('$baseUrl$getLoanUrl');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final loanData = responseBody['data'];
        // print(responseBody['data']);
        Loan loan = Loan(
          loanId: loanData['loanId'],
          userId: "",
          purpose: loanData['purpose'],
          borrowingCategory: loanData['borrowingCategory'],
          amount: loanData['amount'],
          tenor: loanData['tenor'],
          yieldReturn: loanData['yieldReturn'],
          status: loanData['status'],
          totalFunding: loanData['totalFunding'],
          borrowerId: loanData['borrower']['borrowerId'],
          name: loanData['borrower']['name'],
          email: loanData['borrower']['email'],
          paymentSchema: loanData['paymentSchema'],
          createdDate: loanData['createdDate'],
          contractLink: loanData['contract'],
          risk: loanData['risk'],
          borrowedFund: loanData['borrower']['performance']['borrowingRecord']
              ['borrowedFund'],
          totalBorrowing: loanData['borrower']['performance']['borrowingRecord']
              ['totalBorrowing'],
          earlier: loanData['borrower']['performance']['repayment']['earlier'],
          onTime: loanData['borrower']['performance']['repayment']['onTime'],
          late: loanData['borrower']['performance']['repayment']['late'],
        );

        return loan;
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody["message"];
      }
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + '%');
    }
  }

  Future download(String url, String filename) async {
    final output = await getTemporaryDirectory();
    var savePath = '${output.path}/$filename'; // Use the storage directory path
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    try {
      var response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: Duration(seconds: 100),
        ),
      );
      var file = await File(savePath);
      print(file.path);
      await file.writeAsBytes(response.data);

      if (savePath.isNotEmpty) {
        await OpenFile.open(savePath);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> fundLoand(int amount, String loanId) async {
    try {
      final token = await _secureStorage.read(key: 'jwtToken');
      final baseUrl = dotenv.env['API_BASE_URL'].toString();
      const fundLoanUrl = "/lenders/funding";
      final url = Uri.parse('$baseUrl$fundLoanUrl');
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: json.encode({"amount": amount, "loanId": loanId}),
      );
      if (response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        print(responseBody['data']);
        return responseBody['data'];
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody["message"];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getPortofolio() async {
    try {
      final token = await _secureStorage.read(key: 'jwtToken');
      final baseUrl = dotenv.env['API_BASE_URL'].toString();
      const portofolioUrl = "/lenders/funding";
      final url = Uri.parse('$baseUrl$portofolioUrl');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final loanData = responseBody['data'];
        return loanData;
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody["message"];
      }
    } catch (e) {
      rethrow;
    }
  }
}
