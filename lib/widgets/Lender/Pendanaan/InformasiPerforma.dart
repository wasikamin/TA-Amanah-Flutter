import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/models/loan.dart';
import 'package:amanah/widgets/Lender/Pendanaan/InformationRow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InformasiPerforma extends StatelessWidget {
  const InformasiPerforma({
    super.key,
    required this.loan,
  });

  final Loan? loan;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    String formatCurrency(int amount) {
      final formatCurrency = new NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
      return formatCurrency.format(amount);
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Performa Penerima Pinjaman",
        style: titleTextStyle.copyWith(fontSize: 16),
      ),
      vSpace(
        height: height * 0.02,
      ),
      Card(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Track Record Peminjam",
                  style: subTitleTextStyle.copyWith(fontSize: 14)),
              InformationRow(
                  left: "Total Dana Dipinjam",
                  right: formatCurrency(loan!.borrowedFund)),
              InformationRow(
                  left: "Total Pinjaman",
                  right: loan!.totalBorrowing.toString() + " Kali"),
              vSpace(height: height * 0.02),
              Text("Performa Pengembalian Dana",
                  style: subTitleTextStyle.copyWith(fontSize: 14)),
              InformationRow(
                  left: "Lebih Cepat",
                  right: loan!.earlier.toString() + " Kali"),
              InformationRow(
                  left: "Tepat Waktu",
                  right: loan!.onTime.toString() + " Kali"),
              InformationRow(
                  left: "Terlambat", right: loan!.late.toString() + " Kali"),
            ],
          ),
        ),
      )
    ]);
  }
}
