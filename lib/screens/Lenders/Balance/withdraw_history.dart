import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/transaction_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WithdrawHistory extends StatelessWidget {
  const WithdrawHistory({super.key});
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
      var withdrawHistory = transactionHistoryProvider.withdrawHistoryList;
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.05),
        child: ListView(
          children: [
            withdrawHistory.isEmpty
                ? Column(
                    children: [
                      vSpace(
                        height: height * 0.3,
                      ),
                      const Center(
                        child: Text("Tidak ada riwayat Withdraw"),
                      ),
                    ],
                  )
                : Column(
                    children: withdrawHistory.map((history) {
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
                      ));
                    }).toList(),
                  ),
          ],
        ),
      );
    });
  }
}
