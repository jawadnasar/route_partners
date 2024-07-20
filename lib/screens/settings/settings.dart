import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_fonts.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/screens/payment_type/payment_type.dart';
import 'package:route_partners/screens/widget/common_image_view_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'Settings'),
      body: Column(
        children: [
          Container(
            height: Get.height * 0.2,
            width: Get.width,
            decoration: const BoxDecoration(
                color: kPrimaryColor,
                image: DecorationImage(image: AssetImage(Assets.imagesLogo))),
            alignment: Alignment.bottomCenter,
          ),
          const SizedBox(height: 10),
          CustomRowWidget(
            icon: const Icon(
              Icons.payment,
              color: kPrimaryColor,
            ),
            firstImagePath: Assets.wallet,
            onTap: () {
              Get.to(() => const PaymentTypeScreen());
            },
            title: 'Payment Type',
          ),
          const SizedBox(height: 10),
          CustomRowWidget(
            icon: const Icon(
              Icons.question_answer,
              color: kPrimaryColor,
            ),
            firstImagePath: Assets.wallet,
            onTap: () {},
            title: 'FAQs',
          ),
          const SizedBox(height: 10),
          CustomRowWidget(
            icon: const Icon(
              Icons.help,
              color: kPrimaryColor,
            ),
            firstImagePath: Assets.wallet,
            onTap: () {},
            title: 'Help & Support',
          ),
          const SizedBox(height: 10),
          CustomRowWidget(
            icon: const Icon(
              Icons.file_copy,
              color: kPrimaryColor,
            ),
            firstImagePath: Assets.wallet,
            onTap: () {},
            title: 'Terms & Conditions',
          ),
          const SizedBox(height: 10),
          CustomRowWidget(
            icon: const FaIcon(
              FontAwesomeIcons.sliders,
              color: kPrimaryColor,
            ),
            firstImagePath: Assets.wallet,
            onTap: () {},
            title: 'Set Preferencess',
          ),
          
        ],
      ),
    );
  }
}

class CustomRowWidget extends StatelessWidget {
  final String? thirdImage;
  final VoidCallback onTap;
  final String firstImagePath;
  final String title;
  final String? secondImagePath;
  final Color? firstImageColor;
  final Widget? icon;

  const CustomRowWidget({
    super.key,
    required this.onTap,
    required this.firstImagePath,
    required this.title,
    this.secondImagePath,
    this.thirdImage,
    this.firstImageColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kPrimaryColor.withOpacity(0.05),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon ??
                  CommonImageView(
                    imagePath: firstImagePath,
                    height: 24,
                    color: kPrimaryColor,
                  ),
              Flexible(
                child: CustomText(
                  text: title,
                  size: 14,
                  weight: FontWeight.w500,
                  paddingLeft: 8,
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              if (thirdImage != null)
                CommonImageView(
                  imagePath: thirdImage!,
                  fit: BoxFit.contain,
                  height: 20,
                  width: 120,
                ),
              // if (secondImagePath != null)
              // CommonImageView(
              //   imagePath: secondImagePath!,
              //   height: 20,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: file_names

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final String text;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextDecoration decoration;
  final FontWeight? weight;
  final TextOverflow? textOverflow;
  final Color? color;
  final FontStyle? fontStyle;
  final VoidCallback? onTap;

  final int? maxLines;
  final double? size;
  final double? lineHeight;
  final double? paddingTop;
  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingBottom;
  final double? letterSpacing;
  final bool? isShadowAvailable;

  // ignore: prefer_const_constructors_in_immutables
  CustomText({
    super.key,
    required this.text,
    this.size = 12,
    this.lineHeight,
    this.maxLines = 100,
    this.decoration = TextDecoration.none,
    this.color,
    this.letterSpacing,
    this.weight = FontWeight.w400,
    this.textAlign,
    this.textOverflow,
    this.fontFamily,
    this.paddingTop = 0,
    this.paddingRight = 0,
    this.paddingLeft = 0,
    this.paddingBottom = 0,
    this.onTap,
    this.fontStyle,
    this.isShadowAvailable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop!,
        left: paddingLeft!,
        right: paddingRight!,
        bottom: paddingBottom!,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            shadows: isShadowAvailable == true
                ? <Shadow>[
                    const Shadow(
                      offset: Offset(0.0, 1.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    const Shadow(
                        offset: Offset(0.0, 1.0),
                        blurRadius: 8.0,
                        color: Colors.black),
                  ]
                : [],
            fontSize: size,
            color: color ?? kSecondaryColor,
            fontWeight: weight,
            decoration: decoration,
            fontFamily: fontFamily ?? AppFonts.MerriWeather,
            height: lineHeight,
            fontStyle: fontStyle,
            letterSpacing: letterSpacing,
          ),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: textOverflow,
        ),
      ),
    );
  }
}
