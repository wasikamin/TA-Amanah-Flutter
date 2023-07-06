import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/transaction_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DepositHistory extends StatelessWidget {
  const DepositHistory({super.key});
  String formatCurrency(int amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<TransactionHistoryProvider>(
        builder: (context, transactionHistoryProvider, child) {
      var depositHistory = transactionHistoryProvider.depositHistoryList;
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.05),
        child: ListView(
          children: [
            depositHistory.isEmpty
                ? Column(
                    children: [
                      vSpace(
                        height: height * 0.3,
                      ),
                      const Center(
                        child: Text("Tidak ada riwayat Deposit"),
                      ),
                    ],
                  )
                : Column(
                    children: depositHistory.map((history) {
                      return Card(
                          child: ListTile(
                        leading: Icon(
                          history['status'] == "done"
                              ? Icons.check_rounded
                              : Icons.update,
                          color: history['status'] == "done"
                              ? Colors.green
                              : Colors.amber,
                          size: 40,
                        ),
                        title:
                            Text(formatCurrency(int.parse(history["amount"]))),
                        subtitle: Text(
                          history["status"],
                          style: TextStyle(
                              color: history['status'] == "done"
                                  ? Colors.green
                                  : Colors.amber),
                        ),
                        trailing: history['status'] == "done"
                            ? const SizedBox.shrink()
                            : TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Bayar",
                                  style: bodyTextStyle.copyWith(
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                    color: primaryColor,
                                  ),
                                )),
                      ));
                    }).toList(),
                  ),
          ],
        ),
      );
    });
  }
}
