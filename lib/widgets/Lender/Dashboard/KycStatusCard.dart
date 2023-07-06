import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/authentication_provider.dart';
import 'package:amanah/screens/Verification/personal_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:provider/provider.dart';

class KycStatusCard extends StatefulWidget {
  const KycStatusCard({
    super.key,
    required this.width,
  });

  final double width;

  @override
  State<KycStatusCard> createState() => _KycStatusCardState();
}

class _KycStatusCardState extends State<KycStatusCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkKyc();
  }

  checkKyc() async {
    await Provider.of<AuthenticationProvider>(context, listen: false)
        .checkKyc();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
        builder: (context, authenticationProvider, _) {
      return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                "Status KYC:",
                style: bodyTextStyle,
              ),
              SizedBox(
                width: widget.width * 0.02,
              ),
              Text(authenticationProvider.kyced.capitalize(),
                  style: bodyTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: authenticationProvider.kyced == "not verified"
                        ? Colors.red
                        : authenticationProvider.kyced == "pending"
                            ? Colors.orange
                            : Colors.green,
                  )),
              const Spacer(),
              authenticationProvider.kyced == "not verified"
                  ? SizedBox(
                      width: widget.width * 0.3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: whiteColor,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side:
                                    BorderSide(color: primaryColor, width: 2)),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PersonalInformationScreen(),
                                ));
                          },
                          child: Row(
                            children: [
                              Text(
                                "Verifikasi",
                                style: buttonTextStyle.copyWith(
                                    color: primaryColor),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: primaryColor,
                                size: 14,
                              ),
                            ],
                          )))
                  : authenticationProvider.kyced == "pending"
                      ? const Icon(Icons.access_time_rounded,
                          color: Colors.orange)
                      : const Icon(Icons.check_rounded, color: Colors.green),
            ],
          ),
        ),
      );
    });
  }
}
