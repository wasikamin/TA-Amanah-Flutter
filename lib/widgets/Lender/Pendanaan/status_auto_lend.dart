import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StatusAutoLend extends StatelessWidget {
  const StatusAutoLend({super.key});

  String formatCurrency(int amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.autoLend.isEmpty) {
        return Container();
      } else {
        List category = userProvider.autoLend["borrowingCategory"];
        return Container(
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
            expandedAlignment: Alignment.topLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            title: Row(
              children: [
                Icon(
                  Icons.timelapse_rounded,
                  color: whiteColor,
                ),
                SizedBox(width: width * 0.02),
                Text(
                  "Auto Lend",
                  style: bodyTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: whiteColor),
                ),
              ],
            ),
            children: [
              RowAutoLend(
                leftText: "Tenor",
                rightText:
                    "${userProvider.autoLend["tenorLength"]["start"]} - ${userProvider.autoLend["tenorLength"]["end"]} Bulan",
              ),
              const vSpace(height: 10),
              RowAutoLend(
                  leftText: "Bunga",
                  rightText:
                      " ${formatCurrency(userProvider.autoLend["yieldRange"]["start"])}  -  ${formatCurrency(userProvider.autoLend["yieldRange"]["end"])}"),
              const vSpace(height: 10),
              RowAutoLend(
                  leftText: "Pendanaan",
                  rightText:
                      formatCurrency(userProvider.autoLend["amountToLend"])),
              const vSpace(height: 10),
              RowAutoLend(leftText: "Kategori", rightText: category.join(", ")),
              const vSpace(height: 10),
            ],
          ),
        );
      }
    });
  }
}

class RowAutoLend extends StatelessWidget {
  const RowAutoLend({
    super.key,
    required this.leftText,
    required this.rightText,
  });
  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(leftText,
            style: bodyTextStyle.copyWith(
                fontSize: 12, fontWeight: FontWeight.bold, color: whiteColor)),
        const Spacer(),
        Text(rightText,
            style: bodyTextStyle.copyWith(
                fontSize: 12, fontWeight: FontWeight.bold, color: whiteColor)),
      ],
    );
  }
}
