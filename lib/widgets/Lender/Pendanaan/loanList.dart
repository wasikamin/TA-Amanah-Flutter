import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/models/loan.dart';
import 'package:amanah/providers/loan_provider.dart';
import 'package:amanah/screens/Lenders/Pendanaan/detail_pendanaan_screen.dart';
import 'package:amanah/widgets/ToolTip.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LoanList extends StatefulWidget {
  @override
  State<LoanList> createState() => _LoanListState();
}

class _LoanListState extends State<LoanList> {
  String formatCurrency(int amount) {
    final formatCurrency =
        new NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.');
    return formatCurrency.format(amount);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LoanProvider>(context, listen: false).getLoan();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Consumer<LoanProvider>(builder: (context, loanProvider, _) {
      if (loanProvider.loading == true) {
        return Container(
            margin: EdgeInsets.only(top: height * 0.2),
            child: const Center(child: CircularProgressIndicator()));
      }
      if (loanProvider.loan.isEmpty) {
        return Container(
            margin: EdgeInsets.only(top: height * 0.2),
            child: Center(child: Text("Belum ada pendanaan")));
      } else {
        List<Loan> loans = loanProvider.loan;

        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: loans
                .map(
                  (loan) => Container(
                    margin: EdgeInsets.only(bottom: height * 0.02),
                    child: Stack(children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          top: height * 0.06,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(bottom: height * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: width * 0.08,
                                  backgroundColor: Colors.white,
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
                                SizedBox(
                                  height: height * 0.1,
                                  width: width * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        loan.name,
                                        style: bodyTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      vSpace(height: height * 0.005),
                                      Text(
                                        formatCurrency(loan.amount),
                                        style: bodyTextStyle.copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      vSpace(height: height * 0.005),
                                      Text(
                                        "${loan.purpose}",
                                        style: bodyTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            vSpace(height: height * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Imbal Hasil",
                                      style:
                                          bodyTextStyle.copyWith(fontSize: 11),
                                    ),
                                    vSpace(height: height * 0.01),
                                    Text(
                                      formatCurrency(loan.yieldReturn),
                                      style: bodyTextStyle.copyWith(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tenor",
                                      style:
                                          bodyTextStyle.copyWith(fontSize: 11),
                                    ),
                                    vSpace(height: height * 0.01),
                                    Text(
                                      "${loan.tenor} bulan",
                                      style: bodyTextStyle.copyWith(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Skema Pembayaran",
                                      style:
                                          bodyTextStyle.copyWith(fontSize: 11),
                                    ),
                                    vSpace(height: height * 0.01),
                                    Text(
                                      "${loan.paymentSchema}",
                                      style: bodyTextStyle.copyWith(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            vSpace(height: height * 0.03),
                            Stack(children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: LinearProgressIndicator(
                                  minHeight: height * 0.02,
                                  value: loan.totalFunding / loan.amount,
                                  backgroundColor: Colors.grey[300],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.green),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                child: Text(
                                    "${(loan.totalFunding / loan.amount * 100).toStringAsFixed(0)}%",
                                    style: bodyTextStyle.copyWith(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              )
                            ]),
                            vSpace(height: height * 0.01),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Sisa Pendanaan:",
                                      style:
                                          bodyTextStyle.copyWith(fontSize: 11),
                                    ),
                                    vSpace(height: height * 0.005),
                                    Text(
                                      formatCurrency(
                                          loan.amount - loan.totalFunding),
                                      style: bodyTextStyle.copyWith(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailPendanaanScreen(
                                          loanId: loan.loanId,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Lihat Detail",
                                    style: bodyTextStyle.copyWith(
                                        fontSize: 14,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      //label category
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 11),
                          alignment: Alignment.centerLeft,
                          width: width * 0.3,
                          height: height * 0.05,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: loan.borrowingCategory.length > 8
                              ? CustomToolTip(
                                  text: loan.borrowingCategory,
                                  textStyle: bodyTextStyle.copyWith(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  loan.borrowingCategory,
                                  style: bodyTextStyle.copyWith(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ]),
                  ),
                )
                .toList());
      }
    });
  }
}
