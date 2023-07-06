import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    await Provider.of<UserProvider>(context, listen: false).checkPinjaman();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.loading == true) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (userProvider.active.isNotEmpty == true) {
        DateTime date = DateTime.parse(userProvider.active["date"]);
        String formattedDate = DateFormat('dd MMM yyyy').format(date);
        String formattedAmount = NumberFormat.currency(
                symbol: 'Rp. ', decimalDigits: 0, locale: 'id-ID')
            .format(userProvider.active["amount"]);
        return RefreshIndicator(
          onRefresh: () async {
            await Provider.of<UserProvider>(context, listen: false)
                .checkPinjaman();
          },
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: ExpansionTile(
                    title: Text(
                      formattedAmount,
                      style: bodyTextStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(formattedDate,
                        style: bodyTextStyle.copyWith(color: Colors.black54)),
                    children: <Widget>[
                      // Add additional widgets or content for each item here
                      ListTile(
                        title: Text('Imbal Hasil'),
                        subtitle: Text(NumberFormat.currency(symbol: 'Rp. ')
                            .format(userProvider.active["yieldReturn"])),
                      ),
                      ListTile(
                        title: Text('Status'),
                        subtitle: Text(userProvider.active["status"]),
                      ),
                      ListTile(
                        title: Text('Tenor'),
                        subtitle: Text("${userProvider.active["tenor"]} bulan"),
                      ),
                      ListTile(
                        title: Text('Kategori'),
                        subtitle:
                            Text(userProvider.active["borrowingCategory"]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
