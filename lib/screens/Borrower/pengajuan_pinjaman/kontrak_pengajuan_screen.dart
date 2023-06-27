// import 'dart:async';
import 'dart:io';

import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/pengajuan_loan_provider.dart';
import 'package:amanah/screens/Borrower/Home/borrower_homepage_screen.dart';
import 'package:amanah/services/loan_service.dart';
import 'package:amanah/utils/pdfController.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class KontrakPengajuan extends StatelessWidget {
  KontrakPengajuan({super.key});
  final PdfController pdfController = PdfController();
  final LoanService loanService = LoanService();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final String text =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam mollis vulputate condimentum. Maecenas ut ex purus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed dolor mi, lacinia ut mollis ut, vehicula consectetur arcu. Nulla ut justo mauris. Mauris dictum et nunc sed elementum.";
    final String text2 =
        "Quisque ornare nulla et iaculis bibendum. Aenean hendrerit rhoncus nibh, porttitor vehicula lacus mollis sed. Integer at felis feugiat, accumsan orci eget, tristique mauris. Donec auctor vulputate mi, at tincidunt dui rutrum at. Nam sollicitudin arcu arcu, non ornare tellus maximus a. Aenean congue nulla sit amet viverra efficitur.";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text('Kontrak Pinjaman'),
      ),
      body: SafeArea(
        child: Consumer<PengajuanLoanProvider>(
          builder: (context, pengajuanLoanProvider, _) {
            var styleFrom = ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            );
            return Padding(
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
                          Center(
                            child: Text(
                              "Kontrak Pinjaman",
                              style: titleTextStyle.copyWith(fontSize: 20),
                            ),
                          ),
                          vSpace(height: height * 0.02),
                          Text(
                            text,
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            text2,
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                              "tenor Pinjaman: ${pengajuanLoanProvider.tenor} Bulan"),
                          Text("amount: ${pengajuanLoanProvider.amount}"),
                          Text(
                              "yieldReturn: ${pengajuanLoanProvider.yieldReturn}"),
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
                                Text("Mohammad Oscar Alfarisi",
                                    style:
                                        bodyTextStyle.copyWith(fontSize: 12)),
                              ],
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                      height: height * 0.06,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: styleFrom.copyWith(
                          side: MaterialStatePropertyAll(
                            BorderSide(color: primaryColor, width: 1),
                          ),
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.black),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                        onPressed: () async {
                          try {
                            await pdfController.setContract(
                                "Penerima Pinjaman",
                                pengajuanLoanProvider.tenor,
                                pengajuanLoanProvider.amount,
                                pengajuanLoanProvider.yieldReturn);
                            var pdf = await pdfController.generateContract();
                            final output = await getTemporaryDirectory();
                            var filePath = '${output.path}/Kontrak.pdf';
                            var file = await File(filePath);
                            print(file.path);
                            await file.writeAsBytes(pdf);

                            // print(file);
                            if (filePath.isNotEmpty) {
                              await OpenFile.open(filePath);
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text('Unduh File Kontrak'),
                      )),
                  vSpace(height: height * 0.02),
                  SizedBox(
                    height: height * 0.06,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: styleFrom,
                      onPressed: () async {
                        try {
                          await loanService.postLoan(pengajuanLoanProvider);
                          // print("Berhasil");
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BorrowerHomePage()),
                            (Route<dynamic> route) => false,
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text("Setuju"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// class PDFScreen extends StatefulWidget {
//   final String? path;

//   const PDFScreen({Key? key, this.path}) : super(key: key);

//   @override
//   _PDFScreenState createState() => _PDFScreenState();
// }

// class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
//   final Completer<PDFViewController> _controller =
//       Completer<PDFViewController>();
//   int? pages = 0;
//   int? currentPage = 0;
//   bool isReady = false;
//   String errorMessage = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Document"),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.share),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Stack(
//         children: <Widget>[
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             child: PDFView(
//               filePath: widget.path,
//               onRender: (_pages) {
//                 setState(() {
//                   pages = _pages;
//                   isReady = true;
//                 });
//               },
//               onError: (error) {
//                 setState(() {
//                   errorMessage = error.toString();
//                 });
//                 print(error.toString());
//               },
//               onPageError: (page, error) {
//                 setState(() {
//                   errorMessage = '$page: ${error.toString()}';
//                 });
//                 print('$page: ${error.toString()}');
//               },
//               onViewCreated: (PDFViewController pdfViewController) {
//                 _controller.complete(pdfViewController);
//               },
//             ),
//           ),
//           errorMessage.isEmpty
//               ? !isReady
//                   ? const Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : Container()
//               : Center(
//                   child: Text(errorMessage),
//                 )
//         ],
//       ),
//     );
//   }
// }
