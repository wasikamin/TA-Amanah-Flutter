import 'package:amanah/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PilihBankScreen extends StatelessWidget {
  const PilihBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final banks = ["BCA", "BNI", "BRI", "Mandiri", "CIMB Niaga"];

    return Scaffold(
      backgroundColor: const Color(0xfff2f7fa),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          "Pilh Bank",
          style: bodyTextStyle.copyWith(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.05),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: ExpansionTile(
                leading: Image.asset(
                  "assets/images/Logo/Bank/${banks[index]}.png",
                  width: 50,
                  height: 50,
                ),
                title: Text(banks[index]),
                children: [
                  ListTile(
                    title: Text("Nomer VA"),
                    subtitle: Text("1234567890"),
                    trailing: Text(
                      "Tekan untuk salin",
                      style: bodyTextStyle.copyWith(
                          fontSize: 12, color: Colors.grey),
                    ),
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: "1234567890"));
                    },
                  )
                ],
              ),
            );
          },
          itemCount: banks.length,
        ),
      ),
    );
  }
}
