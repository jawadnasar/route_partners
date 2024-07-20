import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/controllers/general_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/core/utils/validators.dart';
import 'package:route_partners/screens/additional_info/landing_page.dart';
import 'package:route_partners/screens/authentication_screens/login_screen.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class PhoneAuthAndSocial extends StatelessWidget {
  final _generalController = Get.find<GeneralController>();
  final _authController = Get.find<AuthController>();
  PhoneAuthAndSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      appBar: simpleAppBar(
        title: 'Sign up',
        onLeadingTap: () {
          log('message');
          Get.back();
        },
      ),
      body: SafeArea(
        minimum: AppSizes.DEFAULT,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: logoWidget()),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Country/Region',
              style: TextStyle(color: kGreyColor3),
            ),
            CountryCodePicker(
              onChanged: (value) {
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                _generalController.dialCode.value = value.code!;
              },
              initialSelection: 'PK',
              favorite: const ['+92', 'PK'],
              // optional. Shows only country name and flag
              showCountryOnly: false,
              // optional. Shows only country name and flag when popup is closed.
              showOnlyCountryWhenClosed: false,
              // optional. aligns the flag and the Text left
              alignLeft: false,
            ),
            Form(
              key: _authController.singupFormKey,
              child: MyTextField(
                hintText: 'Enter your phone Number',
                controller: _authController.phoneNumberController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (value) {
                  return ValidationService.instance.phoneNumberValidator(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              radius: 5,
              bgColor: kPrimaryColor,
              textColor: kWhiteColor2,
              weight: FontWeight.w900,
              onTap: () {
                if (_authController.singupFormKey.currentState!.validate()) {
                  Get.to(() => const Landing());
                }
              },
              width: Get.width,
            ),
            // const SizedBox(
            //   height: 30,
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Container(
            //         height: 1,
            //         color: kGreyColor3,
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     MyText(
            //       text: 'OR',
            //       color: kGreyColor3,
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     Expanded(
            //       child: Container(
            //         height: 1,
            //         color: kGreyColor3,
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 30,
            // ),
            // socialLoginWidget(
            //     image: Assets.facebook,
            //     color: kPrimaryColor,
            //     text: 'SIGN UP WITH FACEBOOK'),
            // const SizedBox(
            //   height: 10,
            // ),
            // _authController.isGoogleLoading.value
            //     ? const Center(
            //         child: CircularProgressIndicator(
            //           color: kPrimaryColor,
            //         ),
            //       )
            //     : GestureDetector(
            //         onTap: () async {
            //           await _authController.googleLogin();
            //           if (_authController.isAuth.value) {
            //             Get.offAll(() => const BottomBar());
            //           }
            //         },
            //         child: Container(
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                 width: 1.5,
            //                 color: kGreyColor3,
            //               ),
            //               borderRadius: BorderRadius.circular(5)),
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 15, vertical: 10),
            //           width: Get.width,
            //           child: Row(
            //             children: [
            //               SvgPicture.asset(Assets.googleSignIn),
            //               SizedBox(
            //                 width: Get.width * 0.2,
            //               ),
            //               Expanded(
            //                 child: MyText(
            //                   text: 'SIGN UP WITH GOOGLE',
            //                   weight: FontWeight.w900,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),

            // const SizedBox(
            //   height: 10,
            // ),
            // socialLoginWidget(image: Assets.apple, text: 'SIGN UP WITH APPLE')
          ],
        ),
      ),
    );
  }

  // socialLoginWidget(
  //     {String? image, Color? color, String? text, VoidCallback? onTap}) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       decoration: BoxDecoration(
  //           border: Border.all(
  //             width: 1.5,
  //             color: kGreyColor3,
  //           ),
  //           borderRadius: BorderRadius.circular(5)),
  //       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //       width: Get.width,
  //       child: Row(
  //         children: [
  //           SvgPicture.asset(image ?? ''),
  //           SizedBox(
  //             width: Get.width * 0.2,
  //           ),
  //           Expanded(
  //             child: MyText(
  //               text: '$text',
  //               weight: FontWeight.w900,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
