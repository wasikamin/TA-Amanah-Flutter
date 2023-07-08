import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:amanah/screens/Lenders/Portofolio/detail_portofolio.dart';
import 'package:amanah/widgets/Lender/Pendanaan/InformationRow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PortofolioSelesai extends StatelessWidget {
  const PortofolioSelesai({super.key});
  String formatCurrency(int amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      List<dynamic> funding = userProvider.portofolio!["done"]["funding"];
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 2,
              color: accentColor,
              child: Padding(
                padding: EdgeInsets.all(width * 0.05),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.pie_chart_rounded,
                          color: whiteColor,
                        ),
                        SizedBox(width: width * 0.05),
                        Text(
                          "Total Pendanaan Berjalan",
                          style: bodyTextStyle.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: whiteColor),
                        ),
                      ],
                    ),
                    vSpace(height: height * 0.03),
                    SizedBox(
                      height: height * 0.08,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Total Pendanaan",
                                  style: bodyTextStyle.copyWith(
                                      fontSize: 14, color: whiteColor),
                                ),
                                vSpace(
                                  height: height * 0.03,
                                ),
                                Text(
                                    formatCurrency(
                                        userProvider.portofolio!["done"]
                                            ["summary"]["totalFunding"]),
                                    style: bodyTextStyle.copyWith(
                                        color: whiteColor)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text("Est. Imbal Hasil",
                                    style: bodyTextStyle.copyWith(
                                        fontSize: 14, color: whiteColor)),
                                vSpace(
                                  height: height * 0.03,
                                ),
                                Text(
                                    formatCurrency(userProvider
                                        .portofolio!["done"]["summary"]
                                            ["totalYield"]
                                        .round()),
                                    style: bodyTextStyle.copyWith(
                                        color: whiteColor)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            vSpace(height: height * 0.02),
            funding.isEmpty
                ? Center(
                    child: Text("Tidak ada pendanaan Selesai"),
                  )
                : Column(
                    children: funding.map((fund) {
                      final parsedDate =
                          DateTime.parse(fund["funds"]["repaymentDate"]);
                      String formattedDate =
                          DateFormat.yMMMMd().format(parsedDate);
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(width * 0.05),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: width * 0.04,
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: primaryColor,
                                    child: Container(
                                        child: Icon(Icons.person),
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
                                    fund["Loan"]["borrower"]["name"],
                                    style: bodyTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  TextButton.icon(
                                      onPressed: () async {
                                        Navigator.push(
                                            context,
                                            (MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPortofolioScreen(
                                                        loanId: fund["Loan"]
                                                                ["loan"]
                                                            ["loanId"]))));
                                      },
                                      icon: Icon(
                                        Icons.info_outline_rounded,
                                        color: primaryColor,
                                      ),
                                      label: Text(
                                        "Detail",
                                        style: bodyTextStyle.copyWith(
                                            fontSize: 14,
                                            color: primaryColor,
                                            decoration:
                                                TextDecoration.underline),
                                      ))
                                ],
                              ),
                              InformationRow(
                                  left: "Pendanaanmu",
                                  right:
                                      formatCurrency(fund["funds"]["amount"])),
                              InformationRow(
                                  left: "Imbal Hasil",
                                  right: formatCurrency(
                                      fund["funds"]["yieldReturn"].round())),
                              InformationRow(
                                  left: "Pengembalian", right: formattedDate),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      );
    });
  }
}
