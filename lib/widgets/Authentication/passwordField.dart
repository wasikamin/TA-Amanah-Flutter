import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final bool useValidator;
  PasswordField(
      {required this.controller, super.key, this.useValidator = true});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: (value) {
        if (widget.useValidator == false) {
          return null;
        }
        if (value!.isEmpty) {
          return 'Kolom tidak boleh kosong';
        }
        // Check if the password is at least 8 characters long
        if (value.length < 8) {
          return 'Password harus berisi setidaknya 8 karakter';
        }

        // Check if the password contains at least one uppercase letter
        if (!RegExp(r'[A-Z]').hasMatch(value)) {
          return 'Password harus memiliki huruf kapital';
        }

        // Check if the password contains at least one lowercase letter
        if (!RegExp(r'[a-z]').hasMatch(value)) {
          return 'Password harus memiliki huruf kecil';
        }

        // Check if the password contains at least one special character (one of @$!%*?&)
        if (!RegExp(r'[@$!%*?&]').hasMatch(value)) {
          return 'Password harus memiliki spesial karekter';
        }

        // Check if the password can contain digits
        if (!RegExp(r'\d').hasMatch(value)) {
          return 'Password harus memiliki angka';
        }

        return null;
      },
      //show password button
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Icon(Icons.lock_outline_rounded),
        labelText: 'Password',
        border: UnderlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
