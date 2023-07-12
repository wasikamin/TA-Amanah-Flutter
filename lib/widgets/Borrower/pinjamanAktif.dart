import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:amanah/screens/Bank/pilih_bank_screen.dart';
import 'package:amanah/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PinjamanAktif extends StatefulWidget {
  const PinjamanAktif({super.key});

  @override
  State<PinjamanAktif> createState() => _PinjamanAktifState();
}

class _PinjamanAktifState extends State<PinjamanAktif> {
  final userService = UserService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkDisbursement();
  }

  checkDisbursement() async {
    Provider.of<UserProvider>(context, listen: false).getDisbursement();
  }

  @override
  Widget build(BuildContext context) {
    String formatCurrency(int? amount) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
      return formatCurrency.format(amount);
    }

    final screenHeight = MediaQuery.of(context).size.height;
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.active.isNotEmpty && userProvider.loading == false) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Pinjaman aktif: ${formatCurrency(userProvider.active["amount"])}",
                  style: bodyTextStyle.copyWith(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.bold)),
              const vSpace(height: 10),
              Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: LinearProgressIndicator(
                    minHeight: screenHeight * 0.015,
                    value: userProvider.active["totalFund"] /
                        userProvider.active["amount"],
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
                Positioned(
                  left: 10,
                  child: Text(
                      "${(userProvider.active["totalFund"] / userProvider.active["amount"] * 100).toStringAsFixed(0)}%",
                      style: bodyTextStyle.copyWith(
                          fontSize: 9,
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                )
              ]),
              const vSpace(height: 10),
              Row(
                children: [
                  Text(
                      "Belum terisi: ${formatCurrency(userProvider.active["amount"] - userProvider.active["totalFund"])}",
                      style: bodyTextStyle.copyWith(
                        fontSize: 12,
                        color: primaryColor,
                      )),
                  const Spacer(),
                  if (userProvider.disbursement.isNotEmpty &&
                      userProvider.disbursement["status"] != "pending")
                    TextButton(
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.only(right: 10),
                          minimumSize: const Size(50, 10),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PilihBankScreen()));
                        },
                        child: Text("Cairkan",
                            style: bodyTextStyle.copyWith(
                                fontSize: 14,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.bold)))
                  else if (userProvider.disbursement.isNotEmpty &&
                      userProvider.disbursement["status"] == "pending")
                    Text("Pending",
                        style: bodyTextStyle.copyWith(
                            fontSize: 14,
                            color: Colors.yellow[700],
                            fontWeight: FontWeight.bold))
                ],
              ),
            ],
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
