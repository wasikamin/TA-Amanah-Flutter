import "package:amanah/constants/app_theme.dart";
import "package:amanah/screens/Authentication/login_screen.dart";
import "package:flutter/material.dart";

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mark_email_unread_outlined,
                size: 70,
                color: primaryColor,
              ),
              Text(
                "Verivikasi Email Mu",
                style: titleTextStyle,
              ),
              Text(
                "verifikasi akun melalui email",
                style: subTitleTextStyle,
              ),
              Text(
                "yang telah kami kirim ke-",
                style: subTitleTextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                email,
                style:
                    titleTextStyle.copyWith(color: Colors.black, fontSize: 20),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    "Kembali ke Login",
                    style: textButtonTextStyle,
                  )),
            ],
          ),
        )),
      ),
    );
  }
}
