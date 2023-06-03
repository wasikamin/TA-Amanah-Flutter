import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/widgets/Authentication/passwordField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.role});
  final String role;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _nameController = TextEditingController();
    final _phoneNumController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffB1E8FD),
              Color(0xff3EA8D0),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: -30,
              right: -50,
              child: Opacity(
                opacity: 0.2,
                child: SizedBox(
                    height: 200,
                    width: 300,
                    child: SvgPicture.asset(
                      "assets/images/Logo/LogoAmanaBiru.svg",
                      fit: BoxFit.fill,
                    )),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 50,
              child: Text(
                "© AMANAH Fintech Syariah 2023, ALL RIGHT RESERVED",
                style: bodyTextStyle.copyWith(fontSize: 10),
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
                                if (!RegExp(r'^[^\d\s]+$ ').hasMatch(value)) {
                                  return 'Tidak boleh terdapat angka';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
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
                                if (!RegExp(r'^\+62\d+$').hasMatch(value)) {
                                  return 'Nomer harus dimulai dengan +62';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone_android_outlined),
                                labelText: 'Nomor Handphone',
                                border: UnderlineInputBorder(),
                              ),
                            ),

                            SizedBox(height: 16.0),

                            //Password TextField
                            PasswordField(
                              controller: _passwordController,
                              useValidator: true,
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
                                    String phone = _phoneNumController.text;
                                    String name = _nameController.text;
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
          ],
        ),
      ),
    );
  }
}