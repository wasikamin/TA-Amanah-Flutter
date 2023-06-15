import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RiwayatBerjalan extends StatefulWidget {
  const RiwayatBerjalan({super.key});

  @override
  State<RiwayatBerjalan> createState() => _RiwayatBerjalanState();
}

class _RiwayatBerjalanState extends State<RiwayatBerjalan> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoan();
  }

  checkLoan() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (Provider.of<UserProvider>(context, listen: false).tagihan == null) {
        await Provider.of<UserProvider>(context, listen: false).checkPinjaman();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.active?.isEmpty == true) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (userProvider.active?.isNotEmpty == true) {
        return Center(
          child: Text("Ada Pinjaman Aktif"),
        );
      }
      return Center(
        child: RefreshIndicator(
          onRefresh: () async {
            await Provider.of<UserProvider>(context, listen: false)
                .checkPinjaman();
          },
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: height * 0.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: width * 0.5,
                        child: Image.asset(
                            "assets/images/Illustration/Empty.png")),
                    vSpace(
                      height: height * 0.03,
                    ),
                    Text(
                      "Belum Ada Pinjaman Aktif",
                      style: bodyTextStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
