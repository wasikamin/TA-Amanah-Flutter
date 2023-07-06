import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/screens/Lenders/home/homepage_screen.dart';
import 'package:amanah/services/balance_service.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

class WithdrawScreen extends StatelessWidget {
  WithdrawScreen(
      {super.key, required this.bankCode, required this.accountNumber});
  final String bankCode;
  final int accountNumber;
  final _balanceservice = BalanceService();
  final _amountController = MoneyMaskedTextController(
      thousandSeparator: '.',
      leftSymbol: 'Rp. ',
      precision: 0,
      decimalSeparator: "");
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xfff2f7fa),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Withdraw",
            style: bodyTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.bold)),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Bank",
                        style: bodyTextStyle.copyWith(fontSize: 16),
                      ),
                      Spacer(),
                      Text(
                        bankCode,
                        style: bodyTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  vSpace(height: height * 0.03),
                  Row(
                    children: [
                      Text(
                        "Nomor Rekening",
                        style: bodyTextStyle.copyWith(fontSize: 16),
                      ),
                      Spacer(),
                      Text(
                        accountNumber.toString(),
                        style: bodyTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  vSpace(height: height * 0.05),
                  TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: "Nominal",
                      hintText: "Masukkan Nominal Withdraw",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: height * 0.05),
              height: height * 0.07,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      if (_amountController.numberValue.toInt() < 50000) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Color.fromARGB(255, 211, 59,
                                59), // Customize the background color
                            duration:
                                Duration(seconds: 2), // Customize the duration
                            behavior: SnackBarBehavior
                                .floating, // Customize the behavior
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Customize the border radius
                            ),
                            content: Text("Minimal Withdraw Rp. 50.000")));
                        return;
                      } else {
                        await _balanceservice.withdraw(accountNumber, bankCode,
                            _amountController.numberValue.toInt());
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text("Withdraw"),
                  style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)))),
            ),
          ],
        ),
      ),
    );
  }
}
