import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:route_partners/core/constants/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: kBackgroundColor,
  fontFamily: GoogleFonts.dmSans().fontFamily,
  appBarTheme:  AppBarTheme(
    titleTextStyle: TextStyle(
      fontFamily: GoogleFonts.dmSans().fontFamily,
      fontWeight: FontWeight.w400
    ),
    elevation: 0,
    backgroundColor: kBackgroundColor,
  ),
  useMaterial3: false,
  splashColor: kQuaternaryColor.withOpacity(0.10),
  highlightColor: kQuaternaryColor.withOpacity(0.10),
  colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: kPrimaryColor, primary: kTertiaryColor, tertiary: kGreyColor2),
  textSelectionTheme: const  TextSelectionThemeData(
    cursorColor: kQuaternaryColor,
  ),
);
