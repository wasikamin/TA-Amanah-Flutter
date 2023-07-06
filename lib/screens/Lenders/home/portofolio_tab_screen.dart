import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:amanah/screens/Lenders/Portofolio/portofolio_berjalan_screen.dart';
import 'package:amanah/screens/Lenders/Portofolio/portofolio_selesai_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PortofolioTabScreen extends StatefulWidget {
  const PortofolioTabScreen({super.key});

  @override
  State<PortofolioTabScreen> createState() => _PortofolioTabScreenState();
}

class _PortofolioTabScreenState extends State<PortofolioTabScreen> {
  initState() {
    super.initState();
    getPortofolio();
  }

  getPortofolio() async {
    await Provider.of<UserProvider>(context, listen: false).getPortofolio();
  }

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
          body: Provider.of<UserProvider>(context, listen: true).portofolio ==
                  null
              ? const Center(child: const CircularProgressIndicator())
              : const TabBarView(
                  children: [
                    PortofolioBerjalan(),
                    PortofolioSelesai(),
                  ],
                ),
        ),
      ),
    );
  }
}
