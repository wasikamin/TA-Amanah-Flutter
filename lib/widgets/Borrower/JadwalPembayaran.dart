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
    final userProvider = Provider.of<UserProvider>(context, listen: true);
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
                  style:
                      bodyTextStyle.copyWith(fontSize: 20, color: primaryColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          userProvider.loading == true
              ? const Center(child: CircularProgressIndicator())
              : userProvider.paymentSchedule.isEmpty
                  ? const Center(child: Text("Belum ada tagihan"))
                  : Column(
                      children: userProvider.paymentSchedule.map((schedule) {
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
                                constraints:
                                    BoxConstraints(minWidth: width * 0.3),
                                decoration: BoxDecoration(
                                  color: schedule["status"] == "unpaid"
                                      ? Colors.red[100]
                                      : Colors.green[100],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  formattedDate,
                                  style: bodyTextStyle.copyWith(
                                      fontSize: 14,
                                      color: schedule["status"] == "unpaid"
                                          ? Colors.red[400]
                                          : Colors.green[400]),
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
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(color: Colors.green[100]),
              ),
              Text(
                "Paid",
                style: bodyTextStyle.copyWith(fontSize: 11),
              ),
              const SizedBox(
                width: 50,
              ),
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(color: Colors.red[100]),
              ),
              Text(
                "Unpaid",
                style: bodyTextStyle.copyWith(fontSize: 11),
              )
            ],
          )
        ],
      ),
    );
  }
}
