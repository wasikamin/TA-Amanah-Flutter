import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/screens/Borrower/riwayat_pinjaman/berjalan_screen.dart';
import 'package:amanah/screens/Borrower/riwayat_pinjaman/selesai_screen.dart';
import 'package:flutter/material.dart';

class RiwayatPinjamanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Riwayat Pinjaman",
            style: bodyTextStyle.copyWith(fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
          bottom: TabBar(
              labelColor: Colors.black,
              labelStyle: bodyTextStyle.copyWith(fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.black38,
              unselectedLabelStyle: bodyTextStyle,
              tabs: [
                Tab(
                  text: "Berjalan",
                ),
                Tab(
                  text: "Selesai",
                )
              ]),
        ),
        body: TabBarView(children: [
          RiwayatBerjalan(),
          SelesaiScreen(),
        ]),
      ),
    );
  }
}
