import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/utils/permissions/permissions.dart';
import 'package:route_partners/core/utils/snackbars.dart';
import 'package:route_partners/screens/onboarding_screens/onboarding.dart';
import 'package:route_partners/services/google_maps/google_maps.dart';

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
      Get.to(() => const OnboardingScreen());
    });
  }
}
