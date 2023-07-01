import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/widgets/CustomAppBar.dart';
import 'package:amanah/widgets/Lender/Pendanaan/InformationRow.dart';
import 'package:amanah/widgets/Lender/Pendanaan/pendanaanButton.dart';
import 'package:flutter/material.dart';
import 'package:amanah/models/loan.dart';
import 'package:intl/intl.dart';

import 'package:amanah/services/loan_service.dart';

class KonfirmasiPendanaanScreen extends StatelessWidget {
  const KonfirmasiPendanaanScreen(
      {super.key, required this.loan, required this.amount});
  final Loan loan;
  final int amount;

  String formatCurrency(int amount) {
    final formatCurrency = new NumberFormat.currency(
        locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final loanService = LoanService();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(title: "Konfirmasi Pendanaan"),
      body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.02),
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ringkasan Pendanaan",
                        style: titleTextStyle.copyWith(fontSize: 16),
                      ),
                      vSpace(
                        height: height * 0.02,
                      ),
                      InformationRow(
                        left: "Nama Peminjam",
                        right: loan.name,
                      ),
                      InformationRow(
                        left: "Jumlah Pendanaan",
                        right: formatCurrency(amount),
                      ),
                      InformationRow(
                        left: "Tenor",
                        right: "${loan.tenor} Bulan",
                      ),
                      InformationRow(
                        left: "Imbal Hasil",
                        right:
                            "${(loan.yieldReturn / loan.amount * 100).toStringAsFixed(2)}%",
                      ),
                      InformationRow(
                        left: "Skema Pembayaran",
                        right: loan.paymentSchema,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: width,
                height: height * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: primaryColor),
                    ),
                  ),
                  onPressed: () {
                    loanService.download(
                        loan.contractLink, "${loan.name} kontrak.pdf}");
                  },
                  child: Text(
                    "Lihat Kontrak",
                    style: buttonTextStyle.copyWith(color: Colors.black),
                  ),
                ),
              ),
              vSpace(height: height * 0.02),
              PendanaanButton(
                amount: amount,
                loanID: loan.loanId,
              ),
            ],
          )),
    );
  }
}
