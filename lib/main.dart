import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/bindings/bindings.dart';
import 'package:route_partners/core/utils/themes.dart';
import 'package:route_partners/firebase_options.dart';
import 'package:route_partners/screens/browse_cars/browse_cars.dart';
import 'package:route_partners/screens/search_screen/search_car_for_rent.dart';
import 'package:route_partners/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

const dummyProfileImage =
    'https://firebasestorage.googleapis.com/v0/b/routepartners-9f2d4.appspot.com/o/boy.png?alt=media&token=f1b3a57b-b741-4f49-9638-102285dba0c1';
const dummyCarImage =
    'https://firebasestorage.googleapis.com/v0/b/routepartners-9f2d4.appspot.com/o/images.png?alt=media&token=c36b1eb4-1952-40e4-a8d4-4a3e8d218342';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBindings(),
    );
  }
}
