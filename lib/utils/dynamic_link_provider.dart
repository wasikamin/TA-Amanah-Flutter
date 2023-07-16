import 'package:amanah/screens/Authentication/change_password_screen.dart';
import 'package:amanah/screens/Authentication/login_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DynamicLinkProvider {
  static FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  // Future <String> createLink(String refCode) async {
  //   final String url = "https://com.example.amanah?ref=$refCode";

  //   final DynamicLinkParameters parameters = DynamicLinkParameters(
  //       androidParameters: const AndroidParameters(
  //           packageName: "com.example.amanah", minimumVersion: 0),
  //       link: Uri.parse(url),
  //       uriPrefix: "https://amanahlending.page.link");

  //   final FirebaseDynamicLinks link = await FirebaseDynamicLinks.instance;

  //   final refLink = await link.buildShortLink(parameters);
  //   return refLink.shortUrl.toString();
  // }

  // //init dynamic link
  // void initDynamicLink()async{
  //   final instansceLink = await FirebaseDynamicLinks.instance.getInitialLink();

  //   if(instansceLink !=null){
  //     final Uri refLink = instansceLink.link;

  //
  //   }
  // }

  static Future<void> initDynamicLinks(BuildContext context) async {
    try {
      dynamicLinks.onLink.listen((event) {
        var uid = event.link.queryParameters['uid'];
        var token = event.link.queryParameters['token'];
        var type = event.link.queryParameters['type'];
        print('dynamic link: ${event.link}');
        print('userId: ' + uid.toString());
        print('token: ' + token.toString());
        print('type: ' + type.toString());
        var email = event.link.queryParameters['email'];

        if (type != 'forgetpassword') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ChangePasswordScreen(email: email!, token: token!)));
        }
      }, onError: (error) {
        print('error ${error.message}');
      });
    } catch (e) {
      print(e);
    }
  }
}
