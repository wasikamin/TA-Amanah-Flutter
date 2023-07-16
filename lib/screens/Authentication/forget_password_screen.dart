// import 'package:amanah/providers/authentication_provider.dart';

import 'package:amanah/screens/Authentication/login_screen.dart';
import 'package:amanah/services/authentication_service.dart';
import 'package:amanah/widgets/Authentication/card.dart';
import 'package:amanah/widgets/Authentication/Login/loginLogo.dart';
import 'package:amanah/widgets/sweat_alert.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
import 'package:amanah/constants/app_theme.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ChangePasswordsScreenState();
}

class _ChangePasswordsScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  String _errorMessage = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    final authenticationService = AuthenticationService();
    final height = MediaQuery.of(context).size.height;

    //login function
    void forgetPassword() async {
      setState(() {
        isLoading = true;
      });

      // Perform any async operation here (e.g., network request)
      try {
        await authenticationService
            .forgetPassword(emailController.text)
            .then((value) {
          return Alert(
            context: context,
            type: AlertType.success,
            title: "Berhasil",
            desc: "Silahkan cek email anda untuk mengubah password",
            buttons: [
              DialogButton(
                color: primaryColor,
                child: const Text(
                  "Selanjutnya",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => true,
                  );
                },
              )
            ],
          ).show();
        });
      } catch (e) {
        print(e.toString());
        setState(() {
          _errorMessage = e.toString();
        });
        setState(() {
          isLoading = false;
        });
        failedAlert(context, "Gagal", _errorMessage);
      }
      // After the async operation is completed, update the loading state
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
          decoration: background,
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Positioned(
                  bottom: -20,
                  right: -60,
                  child: Opacity(
                    opacity: 0.5,
                    child: SizedBox(
                        height: 200,
                        width: 300,
                        child: SvgPicture.asset(
                          "assets/images/Logo/LogoAmanaBiru.svg",
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      children: [
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LoginLogo(),
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.35,
                          child: CustomCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "Lupa Password",
                                    style: titleTextStyle.copyWith(
                                        color: accentColor, fontSize: 24),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                //Login Text Field
                                TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Kolom tidak boleh kosong';
                                    }
                                    if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    prefixIcon:
                                        Icon(Icons.mail_outline_rounded),
                                    labelText: 'Email',
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                SizedBox(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: accentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        minimumSize: const Size.fromHeight(40)),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        // login logic here
                                        forgetPassword();
                                      }
                                    },
                                    child: Text(
                                      'Ubah Password',
                                      style: buttonTextStyle,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()) //end of column
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 10,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "© AMANAH Fintech Syariah 2023, ALL RIGHT RESERVED",
                      style: bodyTextStyle.copyWith(fontSize: 10),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        isLoading == true
            ? Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white60,
                child: Center(
                    child: Image.asset(
                  "assets/images/Logo/amanah.gif",
                  width: 100,
                  height: 100,
                )),
              )
            : const SizedBox.shrink(),
      ]),
    );
  }
}
