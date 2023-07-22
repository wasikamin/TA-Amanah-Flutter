import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:amanah/screens/Lenders/Portofolio/detail_portofolio.dart';
import 'package:amanah/widgets/Lender/Pendanaan/InformationRow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PortofolioBerjalan extends StatelessWidget {
  const PortofolioBerjalan({super.key});
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
      List<dynamic> funding = userProvider.portofolio!["active"]["funding"];

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
                                        userProvider.portofolio!["active"]
                                            ["summary"]["totalFunding"]),
                                    style: bodyTextStyle.copyWith(
                                        color: whiteColor)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Est. Keuntungan",
                                  style: bodyTextStyle.copyWith(
                                      fontSize: 14, color: whiteColor),
                                ),
                                vSpace(
                                  height: height * 0.03,
                                ),
                                Text(
                                    formatCurrency(
                                        userProvider.portofolio!["active"]
                                            ["summary"]["totalYield"]),
                                    style: bodyTextStyle.copyWith(
                                        color: whiteColor)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            vSpace(height: height * 0.02),
            funding.isEmpty
                ? const Center(
                    child: Text("Tidak ada pendanaan berjalan"),
                  )
                : Column(
                    children: funding.map((fund) {
                      final parsedDate =
                          DateTime.parse(fund["funds"]["createdDate"]);
                      // print(fund);
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
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: primaryColor, // Warna border
                                          width: 2, // Lebar border
                                        ),
                                      ),
                                      child: const Icon(Icons.person),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.05),
                                  Text(
                                    fund["Loan"]["borrower"]["name"],
                                    style: bodyTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
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
                                  left: "Est. Keuntungan",
                                  right: formatCurrency(
                                      fund["funds"]["yieldReturn"].round())),
                              InformationRow(
                                  left: "Tanggal Pinjaman",
                                  right: formattedDate),
                              // InformationRow(
                              //     left: "Est. Pengembalian",
                              //     right: formattedDate),
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
