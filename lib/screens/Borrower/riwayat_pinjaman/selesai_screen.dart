import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SelesaiScreen extends StatefulWidget {
  const SelesaiScreen({super.key});

  @override
  State<SelesaiScreen> createState() => _SelesaiScreentState();
}

class _SelesaiScreentState extends State<SelesaiScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.history.isNotEmpty) {
        return RefreshIndicator(
          onRefresh: () async {
            Provider.of<UserProvider>(context, listen: false).checkPinjaman();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
                itemCount: userProvider.history.length,
                itemBuilder: (BuildContext context, int index) {
                  DateTime date =
                      DateTime.parse(userProvider.history[index]["date"]);
                  String formattedDate = DateFormat('dd MMM yyyy').format(date);
                  String formattedAmount = NumberFormat.currency(symbol: 'Rp. ')
                      .format(userProvider.history[index]["amount"]);
                  return Card(
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
                              .format(
                                  userProvider.history[index]["yieldReturn"])),
                        ),
                        ListTile(
                          title: Text('Tenor'),
                          subtitle: Text(
                              userProvider.history[index]["tenor"].toString() +
                                  " bulan"),
                        ),
                        ListTile(
                          title: Text('Kategori'),
                          subtitle: Text(
                              userProvider.history[index]["borrowingCategory"]),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        );
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: width * 0.5,
                child: Image.asset("assets/images/Illustration/Empty.png")),
            vSpace(
              height: height * 0.03,
            ),
            Text(
              "Belum Ada Pinjaman Selesai",
              style: bodyTextStyle.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    });
  }
}
