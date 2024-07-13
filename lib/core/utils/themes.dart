import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_fonts.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: kBackgroundColor,
  fontFamily: AppFonts.MerriWeather,
  
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
        fontFamily: AppFonts.MerriWeather,
        fontWeight: FontWeight.w400),
    elevation: 0,
    backgroundColor: kBackgroundColor,
  ),
  useMaterial3: false,
  splashColor: kQuaternaryColor.withOpacity(0.10),
  highlightColor: kQuaternaryColor.withOpacity(0.10),
  colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: kPrimaryColor, primary: kTertiaryColor, tertiary: kGreyColor2),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: kQuaternaryColor,
  ),
);
