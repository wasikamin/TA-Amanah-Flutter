import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/pengajuan_loan_provider.dart';
import 'package:amanah/screens/Borrower/pengajuan_pinjaman/kontrak_pengajuan_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KonfirmasiPinjaman extends StatelessWidget {
  const KonfirmasiPinjaman({super.key});

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
        title: Text("Konfirmasi Pinjaman",
            style: bodyTextStyle.copyWith(fontSize: 20)),
        foregroundColor: Colors.black,
      ),
      body: Consumer<PengajuanLoanProvider>(
          builder: (context, pengajuanLoanProvider, _) {
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.02),
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: height * 0.03),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Informasi Pinjaman",
                          style: titleTextStyle.copyWith(fontSize: 16),
                        ),
                        vSpace(height: height * 0.01),
                        CustomRow(
                            leftText: "Jumlah Pinjaman",
                            rightText: pengajuanLoanProvider.amount.toString()),
                        CustomRow(
                            leftText: "Imbal Hasil",
                            rightText:
                                pengajuanLoanProvider.yieldReturn.toString()),
                        CustomRow(
                            leftText: "Tenor",
                            rightText: pengajuanLoanProvider.tenor.toString()),
                        CustomRow(
                            leftText: "Skema Pembayaran",
                            rightText: pengajuanLoanProvider.paymentSchema),
                        CustomRow(
                          leftText: "Kategori",
                          rightText: pengajuanLoanProvider.borrowingCategory,
                        ),
                        CustomRow(
                            leftText: "Tujuan Penggunaan",
                            rightText: pengajuanLoanProvider.purpose),
                        vSpace(height: height * 0.01),
                      ]),
                ),
              ),
              Spacer(),
              Container(
                  margin: EdgeInsets.only(bottom: height * 0.05),
                  width: double.infinity,
                  height: height * 0.07,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => KontrakPengajuan()));
                      },
                      child: Text("Konfirmasi"))),
            ],
          ),
        );
      }),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({super.key, required this.leftText, required this.rightText});
  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            leftText,
            style: bodyTextStyle,
          ),
          Spacer(),
          Text(rightText, style: bodyTextStyle),
        ],
      ),
    );
  }
}
