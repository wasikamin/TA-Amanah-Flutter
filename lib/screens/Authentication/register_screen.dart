import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/authentication_provider.dart';
import 'package:amanah/widgets/Authentication/passwordField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  final inputFormater = MaskTextInputFormatter(mask: "(+##)#############");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String _errorMessage = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    final height = MediaQuery.of(context).size.height;
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
        title: const Text(
          "Registrasi",
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
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
          Positioned(
            bottom: 0,
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
              height: height,
              padding: EdgeInsets.only(
                left: 18,
                right: 18,
                bottom: MediaQuery.of(context).viewInsets.bottom + 2,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.07,
                            ),
                            Text(
                              "Daftar Sebagai ${widget.role}",
                              style: titleTextStyle.copyWith(
                                  fontSize: 24, color: const Color(0xff474747)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Lengkapi data berikut untuk mendaftar",
                              style: bodyTextStyle.copyWith(
                                  fontSize: 16, color: const Color(0xff474747)),
                            ),
                            const SizedBox(
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
                              decoration: const InputDecoration(
                                isDense: true,
                                prefixIcon: Icon(Icons.email_outlined),
                                labelText: 'Email',
                                border: UnderlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
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
                              decoration: const InputDecoration(
                                isDense: true,
                                prefixIcon: Icon(Icons.person_outline),
                                labelText: 'Nama Lengkap',
                                border: UnderlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
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
                              inputFormatters: [
                                inputFormater,
                              ],
                              decoration: const InputDecoration(
                                hintText: "(+62) 81234567890",
                                isDense: true,
                                prefixIcon: Icon(Icons.phone_android_outlined),
                                labelText: 'Nomor Handphone (62)',
                                border: UnderlineInputBorder(),
                              ),
                            ),

                            const SizedBox(height: 16.0),

                            //Password TextField
                            PasswordField(
                              controller: _passwordController,
                              useValidator: true,
                            ),
                            const SizedBox(height: 16.0),
                            Text("Password harus:",
                                style: bodyTextStyle.copyWith(
                                    fontSize: 12,
                                    color: const Color(0xff474747))),
                            // Check if the password is at least 8 characters long

                            Row(
                              children: [
                                Icon(
                                    _passwordController.text.length >= 8
                                        ? Icons.check_rounded
                                        : Icons.close_rounded,
                                    color: _passwordController.text.length >= 8
                                        ? Colors.green[500]
                                        : Colors.red[500],
                                    size: 11),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Berisi setidaknya 8 karakter',
                                  style: bodyTextStyle.copyWith(
                                      color:
                                          _passwordController.text.length >= 8
                                              ? Colors.green[500]
                                              : Colors.red[500],
                                      fontSize: 11),
                                ),
                              ],
                            ),

                            // // Check if the password contains at least one uppercase letter
                            if (!RegExp(r'[A-Z]')
                                .hasMatch(_passwordController.text))
                              Row(
                                children: [
                                  Icon(Icons.close_rounded,
                                      color: Colors.red[500], size: 11),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Memiliki huruf kapital',
                                      style: bodyTextStyle.copyWith(
                                          color: Colors.red[500],
                                          fontSize: 11)),
                                ],
                              )
                            else
                              Row(
                                children: [
                                  Icon(Icons.check_rounded,
                                      color: Colors.green[500], size: 11),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Memiliki huruf kapital',
                                      style: bodyTextStyle.copyWith(
                                          color: Colors.green[500],
                                          fontSize: 11)),
                                ],
                              ),

                            // // Check if the password contains at least one lowercase letter
                            if (!RegExp(r'[a-z]')
                                .hasMatch(_passwordController.text))
                              Row(
                                children: [
                                  Icon(Icons.close_rounded,
                                      color: Colors.red[500], size: 11),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Memiliki huruf kecil',
                                      style: bodyTextStyle.copyWith(
                                          color: Colors.red[500],
                                          fontSize: 11)),
                                ],
                              )
                            else
                              Row(
                                children: [
                                  Icon(Icons.check_rounded,
                                      color: Colors.green[500], size: 11),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Memiliki huruf kecil',
                                      style: bodyTextStyle.copyWith(
                                          color: Colors.green[500],
                                          fontSize: 11)),
                                ],
                              ),

                            // // Check if the password contains at least one special character (one of @$!%*?&)
                            if (!RegExp(r'[@$!%*?&]')
                                .hasMatch(_passwordController.text))
                              Row(
                                children: [
                                  Icon(Icons.close_rounded,
                                      color: Colors.red[500], size: 11),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Memiliki spesial karekter',
                                      style: bodyTextStyle.copyWith(
                                          color: Colors.red[500],
                                          fontSize: 11)),
                                ],
                              )
                            else
                              Row(
                                children: [
                                  Icon(Icons.check_rounded,
                                      color: Colors.green[500], size: 11),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Memiliki spesial karekter',
                                      style: bodyTextStyle.copyWith(
                                          color: Colors.green[500],
                                          fontSize: 11)),
                                ],
                              ),

                            // // Check if the password can contain digits
                            if (!RegExp(r'\d')
                                .hasMatch(_passwordController.text))
                              Row(
                                children: [
                                  Icon(Icons.close_rounded,
                                      color: Colors.red[500], size: 11),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Memiliki angka',
                                      style: bodyTextStyle.copyWith(
                                          color: Colors.red[500],
                                          fontSize: 11)),
                                ],
                              )
                            else
                              Row(
                                children: [
                                  Icon(Icons.check_rounded,
                                      color: Colors.green[500], size: 11),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Memiliki angka',
                                      style: bodyTextStyle.copyWith(
                                          color: Colors.green[500],
                                          fontSize: 11)),
                                ],
                              ),

                            const SizedBox(height: 16.0),
                            Center(
                              child: Text(
                                _errorMessage,
                                style: errorTextStyle,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 40),
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: accentColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    minimumSize: const Size.fromHeight(40)),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // login logic here
                                    String email = _emailController.text;
                                    String password = _passwordController.text;

                                    String name = _nameController.text;
                                    String phoneNumber =
                                        inputFormater.getUnmaskedText();
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
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
