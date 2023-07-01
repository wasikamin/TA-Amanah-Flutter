import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/screens/Lenders/home/homepage_screen.dart';
import 'package:amanah/services/loan_service.dart';
import 'package:flutter/material.dart';

class PendanaanButton extends StatefulWidget {
  const PendanaanButton({
    super.key,
    required this.amount,
    required this.loanID,
  });
  final int amount;
  final String loanID;
  @override
  State<PendanaanButton> createState() => _PendanaanButtonState();
}

class _PendanaanButtonState extends State<PendanaanButton> {
  final loanService = LoanService();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width,
          height: height * 0.07,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () async {
              try {
                setState(() {
                  isLoading = true;
                });
                await loanService.fundLoand(widget.amount, widget.loanID);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route<dynamic> route) => false);
              } catch (e) {
                print(e);
              } finally {
                setState(() {
                  isLoading = false;
                });
              }
            },
            child: Text("Lakukan Pendanaan"),
          ),
        ),
        Positioned(
            right: 30,
            width: width * 0.03,
            height: width * 0.03,
            child: isLoading == true
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const SizedBox.shrink()),
      ],
    );
  }
}
