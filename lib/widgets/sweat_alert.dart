import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

var alertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  titleStyle: bodyTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
  descStyle: bodyTextStyle.copyWith(fontSize: 12, color: Colors.grey),
  descTextAlign: TextAlign.center,
  animationDuration: const Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  alertAlignment: Alignment.center,
);

void successAlert(
    BuildContext context, MaterialPageRoute route, String title, String desc) {
  Alert(
    context: context,
    type: AlertType.success,
    title: title,
    style: alertStyle,
    desc: desc,
    buttons: [
      DialogButton(
        color: primaryColor,
        child: const Text(
          "Selanjutnya",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            route,
            (Route<dynamic> route) => false,
          );
        },
      )
    ],
  ).show();
  return;
}

void failedAlert(BuildContext context, String title, String desc) {
  Alert(
    style: alertStyle,
    context: context,
    type: AlertType.error,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        color: primaryColor,
        child: const Text(
          "Tutup",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  ).show();
  return;
}

void succesAlertinSamePage(BuildContext context, String title, String desc) {
  Alert(
    context: context,
    type: AlertType.success,
    title: title,
    style: alertStyle,
    desc: desc,
    buttons: [
      DialogButton(
        color: primaryColor,
        child: const Text(
          "Selanjutnya",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  ).show();
  return;
}

void logoutAlert(BuildContext context, String title, String desc) {
  final authenticationProvider =
      Provider.of<AuthenticationProvider>(context, listen: false);
  Alert(
    style: alertStyle,
    context: context,
    type: AlertType.warning,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        color: Colors.grey,
        child: const Text(
          "Batal",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      DialogButton(
        color: Colors.red[400],
        child: const Text(
          "Keluar",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        onPressed: () async {
          await authenticationProvider.logout(context);
        },
      )
    ],
  ).show();
  return;
}
