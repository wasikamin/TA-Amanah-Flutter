import "package:amanah/constants/app_theme.dart";
import "package:amanah/screens/Bank/pilih_bank_screen.dart";
import "package:amanah/screens/Lenders/Balance/top_up_screen.dart";
import "package:amanah/widgets/Lender/saldo.dart";
import "package:amanah/widgets/Lender/verticalCarousel.dart";
import "package:flutter/material.dart";

class cardSaldo extends StatelessWidget {
  const cardSaldo({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: EdgeInsets.all(14),
        width: double.infinity,
        height: screenHeight * 0.22,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Saldo Akun",
                      style: bodyTextStyle.copyWith(fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    Saldo(),
                  ],
                ),
                Spacer(flex: 1),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TopUpScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: const EdgeInsets.all(2),
                        width: 30,
                        child: Icon(
                          Icons.arrow_upward_outlined,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Text("Top Up"),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.07,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PilihBankScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: const EdgeInsets.all(2),
                        width: 30,
                        child: Icon(
                          Icons.arrow_downward_outlined,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Withdraw"),
                  ],
                ),
                Spacer(flex: 1),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Container(
                width: 200,
                height: screenHeight * 0.07,
                child: VerticalCarousel()),
            // Text("Keuntungan imbal hasil:"),
            // Text("Rp. 0"),
            // SizedBox(
            //   height: screenHeight * 0.03,
            // ),
            // Text("Dana yang disalurkan: Rp. 0")
          ],
        ),
      ),
    );
  }
}
