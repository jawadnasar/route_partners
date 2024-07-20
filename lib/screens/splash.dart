import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/utils/snackbars.dart';
import 'package:route_partners/screens/onboarding_screens/onboarding.dart';

class SplashScreen extends StatefulWidget {
  final bool? isHerefromGoogleSIgnin;

  const SplashScreen({super.key, this.isHerefromGoogleSIgnin = false});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then(
      (_) async {
        PermissionStatus status = await Permission.location.request();
        if (status.isGranted) {
          _handleSplashScreen();
        } else {
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Error', message: 'Location is required to continue');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: CircleAvatar(
          backgroundColor: kPrimaryColor,
            radius: 100,
            backgroundImage: AssetImage(
              Assets.imagesLogo,
              
            )),
      ),
    );
  }

  void _handleSplashScreen() {
    Timer(const Duration(seconds: 6), () {
      Get.to(() => const OnboardingScreen());
    });
  }
}
