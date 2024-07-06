import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/widget/common_image_view_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const  BoxDecoration(),
      child: Padding(
        padding: AppSizes.DEFAULT,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonImageView(
              radius: 15,
              svgPath: Assets.ride,
              height: Get.height * 0.3,
              // imageColor: kQuaternaryColor,
            ),
            MyText(
              text: "BOOK A RIDE",
              size: 20,
              color: kBlackColor,
              // fontFamily: AppFonts.APOTEK,
              textAlign: TextAlign.center,
              weight: FontWeight.w600,
              paddingTop: 15,
              paddingLeft: 44,
              paddingRight: 44,
            ),
            MyText(
              color: kGreyColor3,
              text:
                  "Going Somewhere? Carpooling is the way to go. Book low cost sharing rides",
              size: 12,
              textAlign: TextAlign.center,
              lineHeight: 1.5,
              paddingTop: 10,
              paddingLeft: 20,
              paddingRight: 20,
            ),
          ],
        ),
      ),
    );
  }
}
