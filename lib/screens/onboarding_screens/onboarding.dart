// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/additional_info/landing_page.dart';
import 'package:route_partners/screens/authentication_screens/sign_up_with_phone.dart';
import 'package:route_partners/screens/onboarding_screens/onboarding1.dart';
import 'package:route_partners/screens/onboarding_screens/onboarding2.dart';
import 'package:route_partners/screens/onboarding_screens/onboarding3.dart';
import 'package:route_partners/screens/widget/common_image_view_widget.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              log(index.toString());
              setState(() {});
            },
            children: [
              Onboarding1(),
              Onboarding2(),
              Onboarding3(),
              // Onboarding4(),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: AppSizes.DEFAULT,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: CommonImageView(
                      // imagePath: Assets.imagesBack,
                      height: 13,
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: JumpingDotEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      dotColor: kGreyColor3,
                      activeDotColor: kPrimaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyButton(
                    textColor: kWhiteColor2,
                    buttonText: 'Next',
                    radius: 5,
                    width: Get.width * 0.5,
                    bgColor: kPrimaryColor,
                    onTap: () {
                      if (_pageController.page?.toInt() != 2) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      } else {
                        Get.offAll(()=> PhoneAuthAndSocial());
                      }
                    }),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
