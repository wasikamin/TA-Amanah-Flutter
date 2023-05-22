import 'package:amanah/providers/authentication__provider.dart';
import 'package:amanah/widgets/passwordField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
            child: Column(
          children: [
            //Login Text Field
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
                labelText: 'Email',
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),

            //Password TextField
            PasswordField(controller: _passwordController),

            //Login Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32))),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // login logic here
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  await authenticationProvider.login(email, password, context);
                }
              },
              child: Text(
                'Masuk',
              ),
            ),

            //end of column
          ],
        )),
      ),
    );
  }
}
