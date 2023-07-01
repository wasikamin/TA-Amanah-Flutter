import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/models/loan.dart';
import 'package:amanah/widgets/Lender/Pendanaan/InformationRow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InformasiPinjaman extends StatelessWidget {
  const InformasiPinjaman({
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
        "Informasi Pinjaman",
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
            children: [
              InformationRow(
                  left: "Jumlah Pinjaman", right: formatCurrency(loan!.amount)),
              InformationRow(
                  left: "Imbal Hasil",
                  right: formatCurrency(loan!.yieldReturn)),
              InformationRow(
                  left: "Tenor", right: loan!.tenor.toString() + " Bulan"),
              InformationRow(
                  left: "Skema Pembayaran", right: loan!.paymentSchema),
              InformationRow(left: "Kategori", right: loan!.borrowingCategory),
              InformationRow(left: "Tujuan Pinjaman", right: loan!.purpose),
            ],
          ),
        ),
      )
    ]);
  }
}
