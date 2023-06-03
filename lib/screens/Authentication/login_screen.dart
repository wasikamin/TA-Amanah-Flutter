import 'package:amanah/providers/authentication__provider.dart';
import 'package:amanah/screens/Authentication/role_screen.dart';
import 'package:amanah/widgets/Authentication/card.dart';
import 'package:amanah/widgets/Authentication/Login/loginLogo.dart';
import 'package:amanah/widgets/Authentication/passwordField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amanah/constants/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context);

    //login function
    void _login(String email, String password) async {
      print("test");
      setState(() {
        isLoading = true;
      });

      // Perform any async operation here (e.g., network request)
      try {
        await authenticationProvider.login(email, password, context);
      } catch (e) {
        print(e.toString());
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
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      children: [
                        const Flexible(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LoginLogo(),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: CustomCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    "Selamat Datang",
                                    style: titleTextStyle.copyWith(
                                        color: accentColor, fontSize: 24),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),

                                //Login Text Field
                                TextFormField(
                                  controller: _emailController,
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
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.mail_outline_rounded),
                                    labelText: 'Email',
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                                SizedBox(height: 16.0),

                                //Password TextField
                                PasswordField(
                                  controller: _passwordController,
                                  useValidator: false,
                                ),

                                //forget password
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(flex: 1, child: Container()),
                                    Flexible(
                                      flex: 1,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero),
                                        onPressed: () {},
                                        child: Text(
                                          "Lupa Password?",
                                          style: thinTextButtonTextStyle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Text(
                                    _errorMessage,
                                    style: errorTextStyle,
                                  ),
                                ),
                                //Login Button
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: accentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        minimumSize: Size.fromHeight(40)),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        // login logic here
                                        String email = _emailController.text;
                                        String password =
                                            _passwordController.text;
                                        _login(email, password);
                                      }
                                    },
                                    child: Text(
                                      'Masuk',
                                      style: buttonTextStyle,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Belum memiliki akun? ",
                                      style: bodyTextStyle,
                                    ),
                                    TextButton(
                                      style: textButton,
                                      onPressed: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RoleScreen()));
                                      },
                                      child: Text(
                                        "Daftar di Sini!",
                                        style: textButtonTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(flex: 1, child: Container()) //end of column
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 50,
                  child: Text(
                    "© AMANAH Fintech Syariah 2023, ALL RIGHT RESERVED",
                    style: bodyTextStyle.copyWith(fontSize: 10),
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
            : SizedBox.shrink(),
      ]),
    );
  }

  // void showErrorMessage(BuildContext context, String message) {
  //   final snackBar = SnackBar(
  //     content: Stack(children: [
  //       Container(
  //         height: 70,
  //         width: 300,
  //         decoration: BoxDecoration(
  //             color: Color.fromARGB(255, 255, 255, 255),
  //             borderRadius: BorderRadius.all(Radius.circular(20))),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               _errorMessage,
  //               style: TextStyle(color: Colors.red),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Positioned(
  //           top: 10,
  //           right: 20,
  //           child: Image.asset(
  //             "assets/images/background/Ellipse top.png",
  //             width: 10,
  //             height: 10,
  //           )),
  //       Positioned(
  //           bottom: 10,
  //           left: 10,
  //           child: Image.asset(
  //             "assets/images/background/Ellipse bottom.png",
  //             width: 20,
  //             height: 20,
  //           ))
  //     ]),
  //     backgroundColor: Colors.transparent,
  //     behavior: SnackBarBehavior.floating,
  //     elevation: 0,
  //   );

  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}
