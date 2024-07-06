// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/widget/common_image_view_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: AppSizes.DEFAULT,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonImageView(
              imagePath: Assets.onboarding1,
              height: Get.height * 0.3,
              // c: kQuaternaryColor,
            ),
            MyText(
              text: "TRAVEL THROUGH CITIES",
              size: 20,
              textAlign: TextAlign.center,
              lineHeight: 1.5,
              color: kTertiaryColor,
              // fontFamily: AppFonts.,
              weight: FontWeight.w600,
              paddingTop: 15,
              paddingLeft: 44,
              paddingRight: 44,
            ),
            MyText(
              text:
                  "A global people-powered network with a trusted community of drivers and passengers operating across Asia & Europe",
              size: 12,
              textAlign: TextAlign.center,
              lineHeight: 1.5,
              paddingTop: 10,
              paddingLeft: 20,
              color: kGreyColor3,
              paddingRight: 20,
            ),
            SizedBox(
              height: 50,
            ),
            // CommonImageView(
            //   imagePath: 'assets/images/Group1.png',
            //   fit: BoxFit.cover,
            //   height: 300,
            //   width: 300,
            // ),
          ],
        ),
      ),
    );
  }
}
