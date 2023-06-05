import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/screens/Authentication/login_screen.dart';
import 'package:amanah/widgets/Authentication/Otp/otpField.dart';
import 'package:amanah/widgets/Authentication/Otp/resendButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../../providers/authentication_provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  String email = "";
  String otp = '';

  getEmail() async {
    String? email = await _secureStorage.read(key: 'email');
    if (email != null) {
      // Lakukan sesuatu dengan nilai yang didapatkan
      print('Nilai dari secure storage: $email');
      setState(() {
        this.email = email;
      });
    } else {
      // Tidak ada nilai yang tersimpan di secure storage
      print('Tidak ada nilai yang tersimpan di secure storage');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      //appbar
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Konfirmasi Kode OTP",
          style: TextStyle(color: Color(0xff3C3C3C)),
        ),
        backgroundColor: Colors.transparent,
      ),

      //body
      body: Container(
        decoration: BoxDecoration(color: Color(0xffFAFAFA)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              child: Column(
            children: <Widget>[
              Flexible(flex: 1, child: Container()),
              Flexible(
                  flex: 2,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Masukkan Kode OTP",
                          style: bodyTextStyle.copyWith(fontSize: 24),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Kami telah mengirimkan kode konfirmasi ke email",
                          style: bodyTextStyle,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          email,
                          style: subTitleTextStyle.copyWith(
                              fontWeight: FontWeight.w700),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 40),
                          child: OtpField(
                            otpLength: 5,
                            onOTPEntered: (value) {
                              setState(
                                () {
                                  otp = value;
                                },
                              );
                            },
                            onCompleted: () async {
                              await authenticationProvider.sendOtp(
                                  otp, email, context);
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Belum menerima code?"),
                            resendOtpButton(email: email),
                          ],
                        )
                      ],
                    ),
                  )),
              Flexible(flex: 1, child: Container()),
            ],
          )),
        ),
      ),
    );
  }
}
