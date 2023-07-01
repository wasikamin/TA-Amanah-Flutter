import 'package:amanah/constants/app_theme.dart';
import 'package:flutter/material.dart';

class PortofolioTabScreen extends StatelessWidget {
  const PortofolioTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0,
            centerTitle: true,
            bottom: const TabBar(
              labelColor: Color(0xff0284ac),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xff0284ac),
              tabs: [
                Tab(text: "Berjalan"),
                Tab(text: "Selesai"),
              ],
            ),
            title: Text(
              'Portofolio Pendanaan',
              style: bodyTextStyle.copyWith(fontSize: 16),
            ),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}
