import "dart:async";
import 'package:provider/provider.dart';
import 'package:amanah/providers/authentication_provider.dart';
import "package:flutter/material.dart";

class resendOtpButton extends StatefulWidget {
  const resendOtpButton({super.key, required this.email});
  final email;

  @override
  State<resendOtpButton> createState() => _resendOtpButtonState();
}

class _resendOtpButtonState extends State<resendOtpButton> {
  int _count = 0;
  Timer? _timer;

  _countdown() async {
    setState(() {
      _count = 60;
    });
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_count == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _count--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    return TextButton(
        onPressed: _count > 0
            ? null
            : () {
                _countdown();
                authenticationProvider.resendOtp(widget.email);
              },
        child: _count == 0 ? Text("Kirim ulang!") : Text("$_count\s"));
  }
}
