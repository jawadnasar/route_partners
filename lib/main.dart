import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/utils/themes.dart';
import 'package:route_partners/screens/my_rides/my_rides.dart';
import 'package:route_partners/screens/splash.dart';

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
      home:  const MyRides(),
    );
  }
}




