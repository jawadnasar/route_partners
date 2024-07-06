import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/utils/themes.dart';
import 'package:route_partners/screens/additional_info/landing_page.dart';
import 'package:route_partners/screens/authentication_screens/sign_up_with_phone.dart';
import 'package:route_partners/screens/authentication_screens/verification_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home:  const Landing(),
    );
  }
}




