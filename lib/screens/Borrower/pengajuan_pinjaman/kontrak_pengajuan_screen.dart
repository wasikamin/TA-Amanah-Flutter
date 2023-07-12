// import 'dart:async';
// import 'dart:io';

import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/pengajuan_loan_provider.dart';
import 'package:amanah/providers/user_profile_provider.dart';
import 'package:amanah/screens/Borrower/Home/borrower_homepage_screen.dart';
import 'package:amanah/services/loan_service.dart';
import 'package:amanah/utils/pdfController.dart';
import 'package:amanah/widgets/sweat_alert.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class KontrakPengajuan extends StatelessWidget {
  KontrakPengajuan({super.key});
  final PdfController pdfController = PdfController();
  final LoanService loanService = LoanService();

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final String text =
        "Pihak Peminjam dan Pihak Pemberi Pinjaman, yang selanjutnya disebut sebagai'Pihak-pihak' dengan ini sepakat untuk mengatur perjanjian pinjaman peer-to-peer (P2P) lending syariah berikut ini:";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Kontrak Pinjaman'),
      ),
      body: Consumer<PengajuanLoanProvider>(
        builder: (context, pengajuanLoanProvider, _) {
          var styleFrom = ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          );
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.02),
                child: ListView(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.03),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Pihak Peminjam",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(userProfileProvider.name),
                            Text(userProfileProvider.phoneNumber),
                            Text(userProfileProvider.email),
                            const vSpace(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                "Perjanjian Pinjaman Amanah Peer-to-Peer Lending Syariah",
                                style: titleTextStyle.copyWith(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            vSpace(height: height * 0.02),
                            Text(
                              text,
                              textAlign: TextAlign.justify,
                            ),
                            const vSpace(
                              height: 15,
                            ),
                            const Center(
                              child: Text("A. Pendahuluan"),
                            ),
                            const vSpace(
                              height: 15,
                            ),
                            const ContractList(
                              left: "1. ",
                              right:
                                  "Pihak Pemberi Pinjaman adalah individu entitas yang menyediakan layanan pinjaman kepada individu atau entitas lain yang membutuhkan pembiayaan",
                            ),
                            const ContractList(
                              left: "2. ",
                              right:
                                  "Pihak Peminjam adalah individu atau entitas yang ingin meminjam dana melalui platform P2P lending syariah yang disediakan oleh Pihak Pemberi Pinjaman.",
                            ),
                            const ContractList(
                              left: "3. ",
                              right:
                                  "Pihak-pihak sepakat untuk menjalankan perjanjian pinjaman ini sesuai dengan prinsip-prinsip syariah.",
                            ),
                            const vSpace(
                              height: 10,
                            ),
                            const Divider(
                              color: Colors.black,
                              height: 25,
                              thickness: 1,
                              indent: 10,
                              endIndent: 10,
                            ),
                            const vSpace(
                              height: 10,
                            ),
                            const Center(
                              child: Text("B. Jumlah Pinjaman"),
                            ),
                            const vSpace(
                              height: 15,
                            ),
                            const ContractList(
                                left: "1. ",
                                right:
                                    "Pihak Peminjam setuju untuk menerima jumlah pinjaman tersebut dan bertanggung jawab untuk mengembalikan jumlah tersebut beserta dengan imbal hasil yang telah disepakati atau ditentukan oleh peminjam."),
                            ContractList(
                                left: "2. ",
                                right:
                                    "disepakati atau ditentukan oleh peminjam. 2. Total jumlah pinjaman yang akan diterima oleh Pihak Peminjam adalah sebesar ${pengajuanLoanProvider.amount} [dan kata-kata] (IDR)"),
                            const vSpace(
                              height: 15,
                            ),
                            const Center(
                              child: Text("C. Jangka Waktu Pinjaman"),
                            ),
                            const vSpace(
                              height: 15,
                            ),
                            ContractList(
                                left: "1. ",
                                right:
                                    "Pinjaman ini memiliki jangka waktu ${pengajuanLoanProvider.tenor} bulan dimulai dari tanggal terpenuhinya jumlah pinjaman."),
                            const ContractList(
                                left: "2. ",
                                right:
                                    "Pihak Peminjam harus mengembalikan seluruh jumlah pinjaman beserta imbal hasil yang telah disepakati pada tanggal jatuh tempo yang telah ditentukan."),
                            const Divider(
                              color: Colors.black,
                              height: 25,
                              thickness: 1,
                              indent: 10,
                              endIndent: 10,
                            ),
                            const vSpace(
                              height: 10,
                            ),
                            const Center(
                              child: Text("D. Imbal Hasil"),
                            ),
                            const vSpace(
                              height: 15,
                            ),
                            const ContractList(
                                left: "1. ",
                                right:
                                    "Total imbal hasil merupakan angka yang telah disepakati atau ditentukan sendiri oleh Pihak Peminjam pada saat pengajuan pinjaman."),
                            ContractList(
                                left: "2. ",
                                right:
                                    "Total imbal hasil yang akan diterima oleh Pihak Pemberi Pinjaman adalah sebesar Rp. ${pengajuanLoanProvider.yieldReturn} [dan kata-kata] (IDR)."),
                            const vSpace(
                              height: 15,
                            ),
                            const Center(
                              child: Text("E. Pembayaran"),
                            ),
                            const vSpace(
                              height: 10,
                            ),
                            const ContractList(
                                left: "1. ",
                                right:
                                    "Pihak Peminjam setuju untuk melakukan pembayaran Pelunasan Langsung pinjaman beserta imbal hasil pada tanggal jatuh tempo yang telah ditentukan."),
                            const ContractList(
                                left: "2. ",
                                right:
                                    "Pembayaran harus dilakukan dalam mata uang Indonesia (IDR) ke Virtual Account yang telah ditentukan"),
                            const ContractList(
                                left: "3. ",
                                right:
                                    "Pihak Peminjam bertanggung jawab atas semua biaya transfer atau potongan bank yang terkait dengan pembayaran pinjaman ini."),
                            const Divider(
                              color: Colors.black,
                              height: 25,
                              thickness: 1,
                              indent: 10,
                              endIndent: 10,
                            ),
                            const vSpace(
                              height: 10,
                            ),
                            const Center(
                              child: Text("F. Keabsahan dan Kepastian Hukum"),
                            ),
                            const vSpace(
                              height: 15,
                            ),
                            const ContractList(
                                left: "1. ",
                                right:
                                    "Perjanjian ini merupakan kesepakatan yang sah antara Pihak Peminjam dan Pihak Pemberi Pinjaman dan tunduk pada hukum yang berlaku di Republik Indonesia."),
                            const ContractList(
                                left: "2. ",
                                right:
                                    "Jika ada perselisihan antara Pihak-pihak terkait perjanjian ini, perselisihan tersebut akan diselesaikan melalui negosiasi yang baik antara Pihak-pihak terlebih dahulu"),
                            const vSpace(
                              height: 15,
                            ),
                            const Text(
                              "Dengan menandatangani perjanjian ini, Pihak Peminjam menyatakan bahwa mereka telah membaca, memahami, dan setuju untuk mematuhi semua ketentuan dan kondisi yang ditetapkan dalam perjanjian ini.",
                              textAlign: TextAlign.justify,
                            ),
                            vSpace(height: height * 0.02),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Penerima Pinjaman",
                                    textAlign: TextAlign.justify,
                                    style: bodyTextStyle.copyWith(fontSize: 12),
                                  ),
                                  vSpace(height: height * 0.03),
                                  Text(userProfileProvider.name,
                                      style:
                                          bodyTextStyle.copyWith(fontSize: 12)),
                                ],
                              ),
                            ),
                            const vSpace(
                              height: 30,
                            ),
                            SizedBox(
                              height: height * 0.06,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: styleFrom,
                                onPressed: () async {
                                  try {
                                    pengajuanLoanProvider.setLoading(true);
                                    await loanService
                                        .postLoan(pengajuanLoanProvider)
                                        .then((value) async {
                                      pengajuanLoanProvider.setLoading(false);
                                      return successAlert(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BorrowerHomePage()),
                                          "Berhasil Mengajukan Pinjaman",
                                          "Silahkan Menunggu Pinjaman Anda Terdanai");
                                    });
                                    // print("Berhasil");
                                  } catch (e) {
                                    pengajuanLoanProvider.setLoading(false);
                                    failedAlert(
                                        context,
                                        "Pengajuan Pinjaman Gagal",
                                        "Terdapat Kesalahan Dalam Pengajuan Pinjaman");
                                    print(e);
                                  }
                                },
                                child: const Text("Setuju"),
                              ),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
              if (pengajuanLoanProvider.loading == true)
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white60,
                  child: Center(
                      child: Image.asset(
                    "assets/images/Logo/amanah.gif",
                    width: 100,
                    height: 100,
                  )),
                )
            ],
          );
        },
      ),
    );
  }
}

class ContractList extends StatelessWidget {
  const ContractList({super.key, required this.left, required this.right});
  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(left),
        Expanded(
          child: Text(
            right,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
