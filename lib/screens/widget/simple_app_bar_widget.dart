// import 'package:bike_gps/core/constants/app_colors.dart';
// import 'package:bike_gps/core/constants/app_fonts.dart';
// import 'package:bike_gps/core/constants/app_images.dart';
// import 'package:bike_gps/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';

AppBar simpleAppBar(
    {String? title = '',
    String? leadingIcon = Assets.imagesArrowBack,
    Color? bgColor,
    titleColor,
    List<Widget>? actions,
    VoidCallback? onLeadingTap,
    double? leadingIconSize = 24,
    bool? haveLeading = true,
    bool? centerTitle,
    Color? color,
    double? elevation = 0.5,
    Color? leadingIconColor,
    }) {
  return AppBar(
    
    elevation: elevation,
    shadowColor: kBorderColor2,
    leadingWidth: 50,
    backgroundColor: bgColor,
    centerTitle: centerTitle ?? true,
    automaticallyImplyLeading: false,
    titleSpacing: 0,
    leading: haveLeading!
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                    onTap: onLeadingTap ?? () => Get.back(),
                    child:  FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      color: leadingIconColor ?? kTextColor,
                    )),
              ),
            ],
          )
        : null,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MyText(
        text: title!,
        size: 12,
        color: titleColor ?? kTextColor4,
        weight: FontWeight.w900,
        fontFamily: GoogleFonts.rubik().fontFamily,

        // fontFamily: AppFonts.NUNITO_SANS,
      ),
    ),
    actions: actions,
  );
}
