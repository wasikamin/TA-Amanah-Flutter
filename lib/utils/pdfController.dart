// import 'dart:html';
import 'dart:typed_data';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

class PdfController {
  String? nama;
  int? tenor, amount, yieldReturn;

  setContract(String nama, int tenor, int amount, int yieldReturn) async {
    this.nama = nama;
    this.tenor = tenor;
    this.amount = amount;
    this.yieldReturn = yieldReturn;
  }

  Future<Uint8List> generateContract() async {
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Header(
                    text:
                        "Perjanjian Pinjaman Amanah Peer-to-Peer Lending Syariah",
                    level: 0,
                    textStyle: pw.TextStyle(
                      font: font,
                      fontSize: 30,
                    ),
                  ),
                  pw.Paragraph(
                    text:
                        "Pihak Peminjam dan Pihak Pemberi Pinjaman, yang selanjutnya disebut sebagai 'Pihak-pihak' dengan ini sepakat untuk mengatur perjanjian pinjaman peer-to-peer(P2P) lending syariah berikut ini:",
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Center(child: pw.Text("A. Pendahuluan")),
                  pw.Text("Jumlah Pinjaman:" + amount.toString(),
                      style: pw.TextStyle(
                          font: font,
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold)),
                  pw.Text("imbal hasil:" + yieldReturn.toString(),
                      style: pw.TextStyle(
                          font: font,
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold)),
                  pw.Text("Tenor:" + tenor.toString(),
                      style: pw.TextStyle(
                          font: font,
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 20),
                  pw.Text(nama ?? "Nama Peminjam",
                      style: pw.TextStyle(
                          font: font,
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold)),
                ]),
          ];
        },
      ),
    );
    return pdf.save();
  }
}
