import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = Color(0xff0284ac);
Color secondaryColor = Color(0xffebfaff);
Color accentColor = Color(0xff0297c6);
Color bodyTextColor = Color(0xff000405);
Color backGroundColor = Color(0xffcdf3fe);

TextStyle titleTextStyle = GoogleFonts.inter(
    fontWeight: FontWeight.bold, color: primaryColor, fontSize: 30);

TextStyle subTitleTextStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w300, color: accentColor, fontSize: 16);

TextStyle bodyTextStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w500, color: bodyTextColor, fontSize: 14);

TextStyle buttonTextStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w500, color: secondaryColor, fontSize: 14);

TextStyle textButtonTextStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w500, color: accentColor, fontSize: 14);

TextStyle thinTextButtonTextStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w400, color: accentColor, fontSize: 14);

TextStyle errorTextStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w500, color: Colors.redAccent, fontSize: 12);
