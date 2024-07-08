import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: simpleAppBar(
        title: 'VERIFY YOUR NUMBER',
      ),
      body: SafeArea(
        minimum: AppSizes.DEFAULT,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            MyText(
              textAlign: TextAlign.start,
              text:
                  'Enter the 6 digit code we\'ve sent to 0123456789 via sms and verify: ',
              color: kGreyColor3,
              weight: FontWeight.w600,
            ),
            const SizedBox(
              height: 15,
            ),
            Pinput(
              showCursor: true,
              autofocus: true,
              length: 6,

              defaultPinTheme: PinTheme(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kGreyColor2,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  width: Get.width * 0.13,
                  height: 50),
              // focusedPinTheme: AppStyling.focusPinTheme,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              onCompleted: (pin) {
                // setState(() {
                //   otpCode = pin;
                // });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                MyText(
                  text: 'Didn\'t receive my code? ',
                  color: kGreyColor3,
                  weight: FontWeight.w600,
                ),
                MyText(
                  text: 'Send again',
                  color: kPrimaryColor,
                  weight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
                const Spacer(),
                MyText(
                  text: 'Resend Code 00:54',
                  size: 12,
                  color: kGreyColor3,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            MyButton(
                bgColor: kPrimaryColor, textColor: kWhiteColor2, onTap: () {})
          ],
        ),
      ),
    );
  }
}
