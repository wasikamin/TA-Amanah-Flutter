import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class JadwalPembayaran extends StatelessWidget {
  const JadwalPembayaran({
    super.key,
  });

  String formatCurrency(int amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      return Container(
        padding: EdgeInsets.all(width * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Daftar item dalam list
            SizedBox(
              width: width,
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    color: primaryColor,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Jadwal Pembayaran",
                    style: bodyTextStyle.copyWith(
                        fontSize: 20, color: primaryColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            userProvider.loading == true
                ? Center(child: CircularProgressIndicator())
                : userProvider.paymentSchedule == null
                    ? Center(child: Text("Belum ada tagihan"))
                    : Column(
                        children: userProvider.paymentSchedule!.map((schedule) {
                          DateTime date = DateTime.parse(schedule["date"]);
                          String formattedDate =
                              DateFormat('dd MMM yyyy').format(date);
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    formattedDate,
                                    style: bodyTextStyle.copyWith(
                                        fontSize: 14, color: Colors.red[400]),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  formatCurrency(schedule["amount"]),
                                  style: bodyTextStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
          ],
        ),
      );
    });
  }
}
