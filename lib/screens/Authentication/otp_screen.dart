import 'package:amanah/widgets/otpField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../../providers/authentication__provider.dart';

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
      //appbar
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Konfirmasi Kode OTP",
          style: TextStyle(color: Color(0xff3C3C3C)),
        ),
        backgroundColor: Color(0xffFEFEFE),
      ),

      //body
      body: Container(
        margin: EdgeInsets.all(16),
        child: Form(
            child: Column(
          children: <Widget>[
            Flexible(flex: 1, child: Container()),
            Flexible(
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      Text("Masukkan Kode OTP"),
                      Text("Kami telah mengirimkan kode konfirmasi ke email"),
                      Text(email),
                      OtpField(
                        otpLength: 5,
                        onOTPEntered: (value) {
                          setState(() {
                            otp = value;
                          });
                        },
                      ),
                      Text(otp),
                      ElevatedButton(
                          onPressed: () async {
                            authenticationProvider.sendOtp(otp, email, context);
                          },
                          child: Text("Kirim OTP")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Belum menerima code?"),
                          TextButton(
                              onPressed: () async {
                                authenticationProvider.resendOtp(email);
                              },
                              child: Text("Kirim ulang!"))
                        ],
                      )
                    ],
                  ),
                )),
            Flexible(flex: 1, child: Container()),
          ],
        )),
      ),
    );
  }
}
