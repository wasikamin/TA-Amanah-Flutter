import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  bool useValidator = true;
  PasswordField(
      {required this.controller, super.key, required this.useValidator});

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
          return 'Password must be at least 8 characters long';
        }

        // Check if the password contains at least one uppercase letter
        if (!RegExp(r'[A-Z]').hasMatch(value)) {
          return 'Password must contain at least one uppercase letter';
        }

        // Check if the password contains at least one lowercase letter
        if (!RegExp(r'[a-z]').hasMatch(value)) {
          return 'Password must contain at least one lowercase letter';
        }

        // Check if the password contains at least one special character (one of @$!%*?&)
        if (!RegExp(r'[@$!%*?&]').hasMatch(value)) {
          return 'Password must contain at least one special character';
        }

        // Check if the password can contain digits
        if (!RegExp(r'\d').hasMatch(value)) {
          return 'Password can contain digits';
        }

        return null;
      },
      //show password button
      decoration: InputDecoration(
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
