// import 'package:amanah/providers/authentication_provider.dart';
import 'package:amanah/screens/Authentication/login_screen.dart';
import 'package:amanah/services/authentication_service.dart';
import 'package:amanah/widgets/Authentication/card.dart';
import 'package:amanah/widgets/Authentication/Login/loginLogo.dart';
import 'package:amanah/widgets/Authentication/passwordField.dart';
import 'package:amanah/widgets/sweat_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
import 'package:amanah/constants/app_theme.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen(
      {super.key, required this.email, required this.token});
  final String email;
  final String token;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordsScreenState();
}

class _ChangePasswordsScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  String _errorMessage = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    final authenticationService = AuthenticationService();
    final height = MediaQuery.of(context).size.height;

    //login function
    void gantiPassword() async {
      setState(() {
        isLoading = true;
      });

      // Perform any async operation here (e.g., network request)
      try {
        await authenticationService
            .changePassword(
                widget.email, widget.token, _passwordController.text)
            .then((value) {
          return successAlert(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              "Password Berhasil Diubah",
              "Anda berhasil mengubah password");
        });
      } catch (e) {
        // print(e.toString());
        setState(() {
          _errorMessage = e.toString();
        });
      }

      // After the async operation is completed, update the loading state
      setState(() {
        isLoading = false;
      });
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
                        Expanded(
                          flex: 3,
                          child: CustomCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "Ganti Password",
                                    style: titleTextStyle.copyWith(
                                        color: accentColor, fontSize: 24),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),

                                PasswordField(
                                  controller: _passwordController,
                                  useValidator: true,
                                ),
                                SizedBox(height: height * 0.05),

                                //Password TextField
                                PasswordField(
                                  controller: _passwordConfirmController,
                                  useValidator: false,
                                  label: "Konfirmasi Password",
                                ),
                                SizedBox(height: height * 0.02),
                                Center(
                                  child: Text(
                                    _errorMessage,
                                    style: errorTextStyle,
                                  ),
                                ),
                                SizedBox(height: height * 0.03),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
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
                                        if (_passwordController.text ==
                                            _passwordConfirmController.text) {
                                          gantiPassword();
                                        } else {
                                          setState(() {
                                            _errorMessage =
                                                "Password tidak sama";
                                          });
                                        }
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
