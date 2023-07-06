import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/authentication_provider.dart';
import 'package:amanah/widgets/Authentication/passwordField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.role});
  final String role;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneNumController.text = "62";
  }

  String _errorMessage = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    void _register(String email, String password, String name,
        String phoneNumber, String roles) async {
      print("test");
      setState(() {
        isLoading = true;
      });

      // Perform any async operation here (e.g., network request)
      try {
        await authenticationProvider.register(
            email, password, name, phoneNumber, roles, context);
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
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "Registrasi",
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            Positioned(
              bottom: -30,
              right: -50,
              child: Opacity(
                opacity: 0.15,
                child: SizedBox(
                    height: 200,
                    width: 300,
                    child: SvgPicture.asset(
                      "assets/images/Logo/LogoAmanaBiru.svg",
                      fit: BoxFit.fill,
                    )),
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
            ),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 9,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Daftar Sebagai " + widget.role,
                              style: titleTextStyle.copyWith(
                                  fontSize: 24, color: Color(0xff474747)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Lengkapi data berikut untuk mendaftar",
                              style: bodyTextStyle.copyWith(
                                  fontSize: 16, color: Color(0xff474747)),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Kolom tidak boleh kosong';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: Icon(Icons.email_outlined),
                                labelText: 'Email',
                                border: UnderlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            //nama lengkap
                            TextFormField(
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Kolom tidak boleh kosong';
                                }
                                if (!RegExp(r"^[A-Za-z\s'-]+$")
                                    .hasMatch(value)) {
                                  return 'Tidak boleh terdapat angka';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: Icon(Icons.person_outline),
                                labelText: 'Nama Lengkap',
                                border: UnderlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            //nomor handphone
                            TextFormField(
                              controller: _phoneNumController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Kolom tidak boleh kosong';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: Icon(Icons.phone_android_outlined),
                                labelText: 'Nomor Handphone (62)',
                                border: UnderlineInputBorder(),
                              ),
                            ),

                            SizedBox(height: 16.0),

                            //Password TextField
                            PasswordField(
                              controller: _passwordController,
                              useValidator: true,
                            ),
                            SizedBox(height: 16.0),
                            Center(
                              child: Text(
                                _errorMessage,
                                style: errorTextStyle,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 40),
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: accentColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    minimumSize: Size.fromHeight(40)),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // login logic here
                                    String email = _emailController.text;
                                    String password = _passwordController.text;
                                    String phoneNumber =
                                        _phoneNumController.text;
                                    String name = _nameController.text;
                                    _register(email, password, name,
                                        phoneNumber, widget.role.toLowerCase());
                                  }
                                },
                                child: Text(
                                  'Daftar',
                                  style: buttonTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
          ],
        ),
      ),
    );
  }
}
