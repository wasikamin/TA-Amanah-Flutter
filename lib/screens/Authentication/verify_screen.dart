import "package:amanah/constants/app_theme.dart";
import "package:flutter/material.dart";

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

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
                "Test@gmail.com",
                style:
                    titleTextStyle.copyWith(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
