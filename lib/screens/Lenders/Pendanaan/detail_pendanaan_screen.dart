import "package:amanah/constants/app_theme.dart";
import "package:amanah/models/loan.dart";
import "package:amanah/providers/authentication_provider.dart";
import "package:amanah/providers/user_provider.dart";
import "package:amanah/screens/Lenders/Pendanaan/konfirmasi_pendanaan_screen.dart.dart";
import "package:amanah/services/loan_service.dart";
import "package:amanah/widgets/CustomAppBar.dart";
import "package:amanah/widgets/Lender/Pendanaan/InformasiPerforma.dart";
import "package:amanah/widgets/Lender/Pendanaan/InformasiPinjaman.dart";
import "package:amanah/widgets/Lender/Pendanaan/TopCard.dart";
import "package:amanah/widgets/Lender/Pendanaan/jumlahPinjamanSlider.dart";
import "package:amanah/widgets/Lender/Pendanaan/topDetailPendanaan.dart";
import "package:amanah/widgets/Lender/saldo.dart";
import "package:flutter/material.dart";
import "package:flutter_native_splash/cli_commands.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";

class DetailPendanaanScreen extends StatefulWidget {
  const DetailPendanaanScreen({super.key, required this.loanId});

  final String loanId;

  @override
  State<DetailPendanaanScreen> createState() => _DetailPendanaanScreenState();
}

class _DetailPendanaanScreenState extends State<DetailPendanaanScreen> {
  Loan? loan;
  final loanService = LoanService();
  String formattedDate = "";
  int value = 0;
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
      appBar: CustomAppBar(title: "Detail Pinjaman"),
      body: loan == null
          ? Center(
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
                      vSpace(
                        height: height * 0.1,
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.06, vertical: 5),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 4), // changes position of shadow
                            ),
                          ],
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(10)),
                      width: width * 0.88,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status",
                                style: bodyTextStyle.copyWith(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                loan!.status.capitalize(),
                                style: bodyTextStyle.copyWith(
                                    color: Colors.green, fontSize: 16),
                              )
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (Provider.of<AuthenticationProvider>(context,
                                              listen: false)
                                          .kyced ==
                                      "pending" ||
                                  Provider.of<AuthenticationProvider>(context,
                                              listen: false)
                                          .kyced ==
                                      "not verified") {
                                return errorDialog(context);
                              }
                              bottomSheet(context, width, height);
                            },
                            child: Text("Danai"),
                            style: ElevatedButton.styleFrom(
                              primary: loan!.status == 'tersedia'
                                  ? primaryColor
                                  : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
    );
  }

  String formatCurrency(int amount) {
    final formatCurrency = new NumberFormat.currency(
        locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  Future<dynamic> bottomSheet(
      BuildContext context, double width, double height) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
          padding: EdgeInsets.only(
            left: width * 0.05,
            right: width * 0.05,
            top: height * 0.02,
            bottom: MediaQuery.of(context).viewInsets.bottom + height * 0.02,
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pendanaan",
                      style: titleTextStyle.copyWith(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    )
                  ],
                ),
                vSpace(height: height * 0.02),
                Row(
                  children: [
                    Icon(
                      Icons.monetization_on_rounded,
                      color: primaryColor,
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      "Sisa Slot Pendanaan",
                      style: bodyTextStyle.copyWith(color: primaryColor),
                    ),
                  ],
                ),
                vSpace(height: height * 0.01),
                Text(
                  formatCurrency(loan!.amount - loan!.totalFunding),
                  style: bodyTextStyle,
                ),
                vSpace(height: height * 0.01),
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_rounded,
                      color: primaryColor,
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      "Saldo Akun",
                      style: bodyTextStyle.copyWith(color: primaryColor),
                    ),
                  ],
                ),
                vSpace(height: height * 0.01),
                Saldo(),
                vSpace(height: height * 0.02),
                Text(
                  "Atur Nominal Pinjaman",
                  style: titleTextStyle.copyWith(fontSize: 14),
                ),
                vSpace(height: height * 0.01),
                JumlahPinjamanSlider(
                  yield: loan!.yieldReturn / loan!.amount,
                  endValue: Provider.of<UserProvider>(context, listen: false)
                              .balance
                              .toDouble() <
                          loan!.amount.toDouble() -
                              loan!.totalFunding.toDouble()
                      ? Provider.of<UserProvider>(context, listen: false)
                          .balance
                          .toDouble()
                      : loan!.amount.toDouble() - loan!.totalFunding.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      this.value = value;
                    });
                  },
                ),
                vSpace(height: height * 0.02),
                SizedBox(
                  width: double.infinity,
                  height: height * 0.06,
                  child: ElevatedButton(
                      onPressed: () {
                        value % 50000 != 0 || value < 100000
                            ? showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Peringatan"),
                                      content: Text(
                                        "Nominal harus kelipatan Rp. 50.000 dan Minimal Rp.100.000",
                                        style: bodyTextStyle.copyWith(
                                            fontSize: 12),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("OK"),
                                        ),
                                      ],
                                    ))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        KonfirmasiPendanaanScreen(
                                          loan: loan!,
                                          amount: value,
                                        )));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("Danai")),
                )
              ])),
    );
  }

  Future<void> errorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Peringatan"),
        content: const Text("Mohon untuk melakukan KYC"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
