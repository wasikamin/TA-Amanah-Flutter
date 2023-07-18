import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPerformance extends StatelessWidget {
  const UserPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<UserProfileProvider>(
        builder: (context, userProfileProvider, _) {
      return Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Performa Pembayaran",
              style: titleTextStyle.copyWith(fontSize: 16),
            ),
          ),
          userProfileProvider.performance.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: height * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            userProfileProvider.performance['repayment']
                                    ["earlier"]
                                .toString(),
                            style: bodyTextStyle.copyWith(
                                fontSize: 14, color: accentColor),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text("Lebih Cepat",
                              style: bodyTextStyle.copyWith(
                                  fontSize: 12, color: accentColor)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            userProfileProvider.performance['repayment']
                                    ["onTime"]
                                .toString(),
                            style: bodyTextStyle.copyWith(
                                fontSize: 14, color: accentColor),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text(
                            "Tepat Waktu",
                            style: bodyTextStyle.copyWith(
                                fontSize: 12, color: accentColor),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            userProfileProvider.performance['repayment']["late"]
                                .toString(),
                            style: bodyTextStyle.copyWith(
                                fontSize: 14, color: accentColor),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text("Terlambat",
                              style: bodyTextStyle.copyWith(
                                  fontSize: 12, color: accentColor)),
                        ],
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          SizedBox(
            height: height * 0.01,
          ),
        ],
      );
    });
  }
}
