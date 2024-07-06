import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/onboarding_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

import '../widget/my_text_widget.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _SCompleteProfileState();
}

class _SCompleteProfileState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async {
            OnboardingController.instance.onBack();
            return false;
          },
          child: Scaffold(
            appBar: simpleAppBar(
              onLeadingTap: () => OnboardingController.instance.onBack(),
              title: 'FINISH SIGNING UP',
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MyText(
                      paddingLeft: 20,
                      text:
                          'Step ${OnboardingController.instance.currentStep.value + 1} of ${OnboardingController.instance.steps.length}'),
                  Padding(
                    padding: AppSizes.DEFAULT,
                    child: LinearProgressIndicator(
                      minHeight: 5,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: kWhiteColor2,
                      color: const Color(0xFF797979),
                      value: OnboardingController.instance.steps[
                              OnboardingController.instance.currentStep.value]
                          ['progress'],
                    ),
                  ),
                  Expanded(
                    child: OnboardingController.instance.steps[
                            OnboardingController.instance.currentStep.value]
                        ['child'],
                  ),
                ],
              ),
            ),
            floatingActionButton: Padding(
              padding: AppSizes.DEFAULT,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MyButton(
                    bgColor: OnboardingController.instance.currentStep.value ==
                            OnboardingController.instance.steps.length - 1
                        ? kPrimaryColor
                        : kGreyColor3,
                    textColor: kWhiteColor2,
                    buttonText: OnboardingController
                                    .instance.currentStep.value ==
                                OnboardingController.instance.steps.length -
                                    3 ||
                            OnboardingController.instance.currentStep.value ==
                                OnboardingController.instance.steps.length - 2
                        ? 'NEXT'
                        : OnboardingController.instance.currentStep.value ==
                                OnboardingController.instance.steps.length - 1
                            ? 'Accept'
                            : 'Continue',
                    onTap: () => OnboardingController.instance.onContinue(),
                  ),
                  if (OnboardingController.instance.currentStep.value == 4 ||
                      OnboardingController.instance.currentStep.value ==
                          OnboardingController.instance.steps.length - 3 ||
                      OnboardingController.instance.currentStep.value ==
                          OnboardingController.instance.steps.length - 2 ||
                      OnboardingController.instance.currentStep.value == 6)
                    if (OnboardingController.instance.currentStep.value ==
                        OnboardingController.instance.steps.length - 1)
                      MyText(
                        textAlign: TextAlign.center,
                        text: 'Adjust',
                        color: kWhiteColor2,
                        size: 14,
                        weight: FontWeight.w600,
                        onTap: () => OnboardingController.instance.onContinue(),
                        paddingTop: 20,
                      ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
        );
      },
    );
  }
}
