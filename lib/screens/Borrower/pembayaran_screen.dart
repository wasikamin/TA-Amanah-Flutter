import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/screens/Borrower/pilih_bank_screen.dart';
import 'package:flutter/material.dart';

class PembayaranScreen extends StatelessWidget {
  const PembayaranScreen({super.key});

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
        foregroundColor: Colors.black,
        title: Text(
          "Pembayaran Tagihan",
          style: bodyTextStyle.copyWith(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 1,
              child: Container(
                padding: EdgeInsets.all(width * 0.05),
                width: double.infinity,
                height: height * 0.23,
                child: Column(
                  children: [
                    Text(
                      "Tagihan Bulan Ini",
                      style: bodyTextStyle.copyWith(fontSize: 16),
                    ),
                    const Spacer(),
                    Text(
                      "Rp. 0",
                      style: bodyTextStyle.copyWith(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "Sisa Pembayaran:",
                          style: bodyTextStyle.copyWith(fontSize: 12),
                        ),
                        Spacer(),
                        Text(
                          "Rp. 0",
                          style: bodyTextStyle.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "jatuh Tempo:",
                          style: bodyTextStyle.copyWith(fontSize: 12),
                        ),
                        Spacer(),
                        Text(
                          "-",
                          style: bodyTextStyle.copyWith(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            Container(
                width: double.infinity,
                height: height * 0.07,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PilihBankScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: primaryColor),
                      ),
                      backgroundColor: primaryColor),
                  child: Text(
                    "Pilih Bank",
                    style: buttonTextStyle,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
