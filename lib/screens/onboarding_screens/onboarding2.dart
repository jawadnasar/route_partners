// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_fonts.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/widget/common_image_view_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';


class Onboarding2 extends StatelessWidget {
  const Onboarding2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        
      ),
      child: Padding(
        padding: AppSizes.DEFAULT,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonImageView(
              imagePath: Assets.onboarding,
              height: Get.height * 0.3,
            ),
            MyText(
              text: "OFFER A RIDE",
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
              text: "Driving somewhere? Publish your ride and choose who goes with you and enjoy the least expensive ride you have ever made ",
              size: 12,
              color: kGreyColor3,
              textAlign: TextAlign.center,
              lineHeight: 1.5,
              paddingTop: 10,
              paddingLeft: 44,
              paddingRight: 44,
            ),
          ],
        ),
      ),
    );
  }
}
