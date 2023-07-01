import 'package:amanah/providers/transaction_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WithdrawHistory extends StatelessWidget {
  const WithdrawHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<TransactionHistoryProvider>(
        builder: (context, transactionHistoryProvider, child) {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Text(
            transactionHistoryProvider.withdrawHistoryList.length.toString()),
      );
    });
  }
}
