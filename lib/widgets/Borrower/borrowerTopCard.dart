import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/authentication_provider.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:amanah/screens/Borrower/pengajuan_pinjaman/ajukan_pinjaman_screen.dart';
import 'package:amanah/screens/Verification/personal_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BorrowerTopCard extends StatelessWidget {
  const BorrowerTopCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Consumer2<AuthenticationProvider, UserProvider>(
        builder: (context, authenticationProvider, userProvider, _) {
      return Container(
        height: screenHeight * 0.25,
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Limit Tersedia", style: bodyTextStyle.copyWith(fontSize: 24)),
            Text("Rp. 11.000.000", style: bodyTextStyle.copyWith(fontSize: 24)),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            Text("Maksimal Limit: Rp. 11.000.000"),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            if (authenticationProvider.kyced == "not verified" &&
                userProvider.loading == false)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonalInformationScreen()));
                },
                child: Text(
                  "Verifikasi Data",
                  style: buttonTextStyle,
                ),
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              ),
            if (authenticationProvider.kyced == "pending" &&
                userProvider.loading == false)
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child:
                    Text("Status Verifikasi: ${authenticationProvider.kyced}",
                        style: bodyTextStyle.copyWith(
                          fontSize: 16,
                          color: primaryColor,
                        )),
              ),
            if (userProvider.active.isNotEmpty && userProvider.loading == false)
              ElevatedButton(
                onPressed: () {
                  return;
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.grey),
                    ),
                    backgroundColor: Colors.grey),
                child: Text(
                  "Terdapat Pinjaman Aktif",
                  style: buttonTextStyle,
                ),
              ),
            if (userProvider.loading == true) const CircularProgressIndicator(),
            if (authenticationProvider.kyced == "verified" &&
                userProvider.active.isEmpty &&
                userProvider.loading == false)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AjukanPinjamanScreen()));
                },
                child: Text(
                  "Ajukan Pinjaman",
                  style: buttonTextStyle,
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: primaryColor),
                    ),
                    backgroundColor: primaryColor),
              ),
          ],
        ),
      );
    });
  }
}
