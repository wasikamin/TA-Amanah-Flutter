import 'package:amanah/providers/transaction_history_provider.dart';
import 'package:amanah/screens/Lenders/Balance/deposit_history.dart';
import 'package:amanah/screens/Lenders/Balance/withdraw_history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHistory();
  }

  void getHistory() async {
    await Provider.of<TransactionHistoryProvider>(context, listen: false)
        .fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xfff2f7fa),
        appBar: AppBar(
          foregroundColor: Colors.black,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text("Riwayat Transaksi"),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.black,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xff0284ac),
                  width: 2,
                ),
              ),
            ),
            tabs: [
              Tab(
                text: "Deposit",
              ),
              Tab(
                text: "Withdraw",
              ),
            ],
          ),
        ),
        body: Provider.of<TransactionHistoryProvider>(context, listen: true)
                    .isLoading ==
                true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : const TabBarView(
                children: [DepositHistory(), WithdrawHistory()],
              ),
      ),
    );
  }
}
