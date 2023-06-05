import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = Color(0xff0284ac);
Color secondaryColor = Color(0xffebfaff);
Color whiteColor = Color(0xffFAFDFF);
Color accentColor = Color(0xff0297c6);
Color bodyTextColor = Color(0xff000405);
Color backGroundColor = Color(0xffcdf3fe);

TextStyle titleTextStyle = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.bold, color: primaryColor, fontSize: 30);

TextStyle subTitleTextStyle = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w300, color: accentColor, fontSize: 16);

TextStyle bodyTextStyle = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w500, color: bodyTextColor, fontSize: 14);

TextStyle thinBodyTextStyle = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w300, color: bodyTextColor, fontSize: 13);

TextStyle buttonTextStyle = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w500, color: secondaryColor, fontSize: 14);

TextStyle textButtonTextStyle = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w500, color: accentColor, fontSize: 14);

TextStyle thinTextButtonTextStyle = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w400, color: accentColor, fontSize: 14);

TextStyle errorTextStyle = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w500, color: Colors.redAccent, fontSize: 12);

//background

BoxDecoration background = BoxDecoration(color: accentColor);

BoxDecoration backgroundWhite = BoxDecoration(
    // image: DecorationImage(
    //     image: AssetImage("assets/images/background/backgroundWhite.png"),
    // fit: BoxFit.cover)
    color: backGroundColor);

//text button setting
var textButton = TextButton.styleFrom(padding: EdgeInsets.zero);
