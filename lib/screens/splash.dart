import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/screens/onboarding_screens/onboarding.dart';

class SplashScreen extends StatelessWidget {
  final bool? isHerefromGoogleSIgnin;

  const SplashScreen({super.key, this.isHerefromGoogleSIgnin = false});

  @override
  Widget build(BuildContext context) {
    _handleSplashScreen();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Image.asset(
          Assets.imagesLogo,
          height: 148,
        ),
      ),
    );
  }

  void _handleSplashScreen() {
    Timer(const Duration(seconds: 6), () {
      Get.to(()=> const OnboardingScreen());
    });
  }
}
