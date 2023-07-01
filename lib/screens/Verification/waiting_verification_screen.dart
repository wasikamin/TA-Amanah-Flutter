import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/authentication_provider.dart';
import 'package:amanah/screens/Borrower/Home/borrower_homepage_screen.dart';
import 'package:amanah/screens/Lenders/home/homepage_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WaitingVerificationScreen extends StatelessWidget {
  const WaitingVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider authProvider =
        Provider.of<AuthenticationProvider>(context);
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.content_paste_search_sharp, size: 100),
            vSpace(height: 20),
            Center(
              child: Text(
                'Datamu Sedang Ditinjau',
                style: titleTextStyle.copyWith(fontSize: 20),
              ),
            ),
            vSpace(height: 20),
            Text(
              "Terima kasih sudah konfirmasi data mu. Mohon tunggu, kami akan infokan ketika peninjauan telah selesai.",
              textAlign: TextAlign.center,
              style: bodyTextStyle.copyWith(fontSize: 16),
            ),
            TextButton(
              child: Text('Kembali ke halaman utama'),
              style: textButton,
              onPressed: () async {
                await authProvider.refreshToken();
                await authProvider.checkKyc();
                print("berhasil");
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => authProvider.role == "lender"
                          ? HomePage()
                          : BorrowerHomePage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
