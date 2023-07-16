import "package:amanah/constants/app_theme.dart";
import "package:amanah/models/loan.dart";
import "package:amanah/services/loan_service.dart";
import "package:amanah/widgets/CustomAppBar.dart";
import "package:amanah/widgets/Lender/Pendanaan/InformasiPerforma.dart";
import "package:amanah/widgets/Lender/Pendanaan/InformasiPinjaman.dart";
import "package:amanah/widgets/Lender/Pendanaan/TopCard.dart";
import "package:amanah/widgets/Lender/Pendanaan/topDetailPendanaan.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:intl/intl.dart";

class DetailPortofolioScreen extends StatefulWidget {
  const DetailPortofolioScreen({super.key, required this.loanId});

  final String loanId;

  @override
  State<DetailPortofolioScreen> createState() => _DetailPortofolioScreenState();
}

class _DetailPortofolioScreenState extends State<DetailPortofolioScreen> {
  Loan? loan;
  final loanService = LoanService();
  String formattedDate = "";
  int value = 0;
  @override
  initState() {
    super.initState();
    getLoan();
  }

  getLoan() async {
    await loanService.getLoanbyId(widget.loanId).then((value) {
      setState(() {
        loan = value;
        final parsedDate = DateTime.parse(loan!.createdDate);
        formattedDate = DateFormat.yMMMMd().format(parsedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(title: "Detail Pinjaman"),
      body: loan == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    bottom: 0,
                    right: -70,
                    child: Opacity(
                      opacity: 0.2,
                      child: SizedBox(
                          height: height * 0.3,
                          width: height * 0.4,
                          child: SvgPicture.asset(
                            "assets/images/Logo/LogoAmanaBiru.svg",
                            fit: BoxFit.fill,
                          )),
                    )),
                Container(
                  padding: EdgeInsets.only(
                      left: width * 0.05,
                      right: width * 0.05,
                      top: height * 0.02),
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                        child: TopDetailPendanaan(
                            width: width,
                            loan: loan,
                            loanService: loanService,
                            height: height),
                      ),
                      vSpace(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TopCard(
                                  title: "Risiko Pinjaman",
                                  content: loan!.risk)),
                          Expanded(
                              child: TopCard(
                                  title: "Tanggal Pengajuan",
                                  content: formattedDate)),
                          Expanded(
                              child: TopCard(
                                  title: "Persentase Imbal Hasil",
                                  content:
                                      "${(loan!.yieldReturn / loan!.amount * 100).toStringAsFixed(1)} %")),
                        ],
                      ),
                      vSpace(
                        height: height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                        child: InformasiPinjaman(loan: loan),
                      ),
                      vSpace(
                        height: height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                        child: InformasiPerforma(loan: loan),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  String formatCurrency(int amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatCurrency.format(amount);
  }
}
