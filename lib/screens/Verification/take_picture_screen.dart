import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/screens/Verification/selfie_camera_screen.dart';
import 'package:flutter/material.dart';

class SelfieScreen extends StatelessWidget {
  const SelfieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //create title widget
        title: Text("Ambil Foto Selfie",
            style: bodyTextStyle.copyWith(fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.08, vertical: height * 0.03),
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: height * 0.05,
            ),
            Center(child: SelfieIcon()),
            vSpace(height: height * 0.05),
            Row(
              children: [
                Text("- "),
                Flexible(
                  child: Text(
                    "Lepaskan kacamata, penutup kepala, dan masker",
                    style: bodyTextStyle.copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
            vSpace(height: height * 0.01),
            Row(
              children: [
                Text("- "),
                Expanded(
                  child: Text(
                    "Atur pencahayaan agar wajah terlihat tanpa pantulan",
                    style: bodyTextStyle.copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
            vSpace(height: height * 0.01),
            Row(
              children: [
                Text("- "),
                Expanded(
                  child: Text(
                    "Wajah berada di dalam bingkai",
                    style: bodyTextStyle.copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
            vSpace(height: height * 0.1),
            SizedBox(
              width: double.infinity,
              height: height * 0.06,
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  onPressed: () {
                    Navigator.push((context),
                        MaterialPageRoute(builder: (context) {
                      return const SelfieCamera();
                    }));
                  },
                  child: Text("Selanjutnya")),
            )
          ]),
        ),
      )),
    );
  }
}

class SelfieIcon extends StatelessWidget {
  const SelfieIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200, child: Icon(Icons.camera_alt_outlined, size: 100));
  }
}
