import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/screens/Verification/ktp_camera_screen.dart';
import 'package:flutter/material.dart';

class KtpScreen extends StatelessWidget {
  const KtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //create title widget
        title:
            Text("Ambil Foto KTP", style: bodyTextStyle.copyWith(fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.08, vertical: height * 0.03),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: height * 0.1,
          ),
          Center(child: KtpIcon()),
          vSpace(height: height * 0.05),
          Row(
            children: [
              Text("- "),
              Text(
                "e-KTP harus asli dan berwarna",
                style: bodyTextStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
          vSpace(height: height * 0.01),
          Row(
            children: [
              Text("- "),
              Text(
                "e-KTP berada dalam bingkai",
                style: bodyTextStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
          vSpace(height: height * 0.01),
          Row(
            children: [
              Text("- "),
              Text(
                "Foto tidak boleh blur",
                style: bodyTextStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
          vSpace(height: height * 0.1),
          SizedBox(
            width: double.infinity,
            height: height * 0.06,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () {
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) {
                    return KTPCamera();
                  }));
                },
                child: Text("Selanjutnya")),
          )
        ]),
      )),
    );
  }
}

class KtpIcon extends StatelessWidget {
  const KtpIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Icon(Icons.person, size: 100),
            Expanded(
              child: Column(
                children: [
                  Divider(
                    color: Colors.black,
                    thickness: 3,
                    endIndent: 5,
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 3,
                    endIndent: 5,
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 3,
                    endIndent: 5,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
