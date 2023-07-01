import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/models/loan.dart';
import 'package:amanah/services/loan_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopDetailPendanaan extends StatelessWidget {
  const TopDetailPendanaan({
    super.key,
    required this.width,
    required this.loan,
    required this.loanService,
    required this.height,
  });

  final double width;
  final Loan? loan;
  final LoanService loanService;
  final double height;
  String formatCurrency(int amount) {
    final formatCurrency =
        new NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.');
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: width * 0.08,
              backgroundColor: Colors.transparent,
              foregroundColor: primaryColor,
              child: Container(
                  child: Icon(Icons.person, size: 40),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primaryColor, // Warna border
                      width: 2, // Lebar border
                    ),
                  )),
            ),
            SizedBox(width: width * 0.05),
            Text(
              loan!.name,
              style: bodyTextStyle.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () async {
                  try {
                    var url = loan!.contractLink;
                    var filename = 'Kontrak ${loan!.name}.pdf';
                    await loanService.download(url, filename);
                    // print(path);
                  } catch (e) {
                    print(e);
                  }
                },
                icon: Icon(Icons.file_present_rounded),
                label: Text("Kontrak"))
          ],
        ),
        vSpace(height: height * 0.02),
        Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: LinearProgressIndicator(
              minHeight: height * 0.02,
              value: loan!.totalFunding / loan!.amount,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
          Positioned(
            left: 10,
            child: Text(
                "${(loan!.totalFunding / loan!.amount * 100).toStringAsFixed(0)}%",
                style: bodyTextStyle.copyWith(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
          )
        ]),
        vSpace(height: height * 0.02),
        Text(
          "Sisa Pendanaan:",
          style: bodyTextStyle.copyWith(fontSize: 11),
        ),
        vSpace(height: height * 0.005),
        Text(
          formatCurrency(loan!.amount - loan!.totalFunding),
          style:
              bodyTextStyle.copyWith(fontSize: 13, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
