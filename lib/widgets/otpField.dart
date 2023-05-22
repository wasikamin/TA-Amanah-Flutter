import 'package:flutter/material.dart';

class OtpField extends StatefulWidget {
  final int otpLength;
  final Function(String) onOTPEntered;

  OtpField({required this.otpLength, required this.onOTPEntered});

  @override
  _OtpFieldState createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  List<FocusNode> _focusNodes = [];
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.otpLength; i++) {
      _focusNodes.add(FocusNode());
      _controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.otpLength; i++) {
      _focusNodes[i].dispose();
      _controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.otpLength, (index) {
        return Flexible(
          child: Container(
            margin: EdgeInsets.all(5),
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              maxLength: 1,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  if (index < widget.otpLength - 1) {
                    FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                } else {
                  if (index > 0) {
                    FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                  }
                }
                String otp = '';
                for (int i = 0; i < widget.otpLength; i++) {
                  otp += _controllers[i].text;
                }
                widget.onOTPEntered(otp);
              },
              decoration: InputDecoration(
                  counterText: '', border: OutlineInputBorder()),
            ),
          ),
        );
      }),
    );
  }
}
