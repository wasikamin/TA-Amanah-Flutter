import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/models/loan.dart';
import 'package:amanah/providers/loan_provider.dart';
import 'package:amanah/providers/user_provider.dart';
// import 'package:amanah/providers/loan_provider.dart';
import 'package:amanah/widgets/Lender/Pendanaan/filterBottomSheet.dart';
import 'package:amanah/widgets/Lender/Pendanaan/auto_lend.dart';
import 'package:amanah/widgets/Lender/Pendanaan/loanList.dart';
import 'package:amanah/widgets/Lender/Pendanaan/status_auto_lend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

class ListPendanaanScreen extends StatefulWidget {
  ListPendanaanScreen({super.key});

  @override
  State<ListPendanaanScreen> createState() => _ListPendanaanScreenState();
}

class _ListPendanaanScreenState extends State<ListPendanaanScreen> {
  List<Loan> loan = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAutoLend();
  }

  checkAutoLend() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.checkAutoLend();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final loanProvider = Provider.of<LoanProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xfff2f7fa),
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "List Pendanaan",
              style: bodyTextStyle.copyWith(fontSize: 20),
            ),
            vSpace(
              height: height * 0.01,
            ),
            Text("Total 2 tersedia, 3 penuh, 1 selesai",
                style: bodyTextStyle.copyWith(fontSize: 11)),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: width * 0.05, right: width * 0.05, top: height * 0.02),
        child: RefreshIndicator(
          onRefresh: () async {
            await loanProvider.getLoan();
            await userProvider.checkAutoLend();
          },
          child: ListView(children: [
            Row(
              children: [
                Container(
                  height: height * 0.05,
                  width: width * 0.3,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          context: context,
                          builder: (context) {
                            return FilterBottomSheet(height: height);
                          });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.filter_alt_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(width: width * 0.02),
                        Text(
                          "Filter",
                          style: bodyTextStyle.copyWith(
                              fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return AutoLend(height: height);
                        });
                  },
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.35,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.work_history_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(width: width * 0.02),
                        Text(
                          "Auto Lend",
                          style: bodyTextStyle.copyWith(
                              fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            const StatusAutoLend(),
            vSpace(height: height * 0.02),
            LoanList(),
            SizedBox(height: height * 0.02),
          ]),
        ),
      ),
    );
  }
}
