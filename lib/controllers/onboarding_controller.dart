import 'package:get/get.dart';
import 'package:route_partners/screens/additional_info/date_of_birth.dart';
import 'package:route_partners/screens/additional_info/enter_email.dart';
import 'package:route_partners/screens/additional_info/enter_first_name.dart';
import 'package:route_partners/screens/additional_info/select_gender.dart';
import 'package:route_partners/screens/onboarding_screens/onboarding1.dart';
import 'package:route_partners/screens/onboarding_screens/onboarding2.dart';
import 'package:route_partners/screens/onboarding_screens/onboarding3.dart';

class OnboardingController extends GetxController {
  static final OnboardingController instance =
      Get.put<OnboardingController>(OnboardingController());

  RxInt currentStep = 0.obs;

  final List<Map<String, dynamic>> steps = [
    {
      'progress': 0.25,
      'child': const EnterFirstAndLastName(),
    },
    {
      'progress': 0.50,
      'child': const EnterEmail(),
    },
    {
      'progress': 0.75,
      'child': const DateOfBirth(),
    },
    {
      'progress': 1.0,
      'child': const SelectGender(),
    },
    // {
    //   'progress': 0.4,
    //   'child': const Step2(),
    // },
    // {
    //   'progress': 0.5,
    //   'child': const Step3(),
    // },
    // {
    //   'progress': 0.6,
    //   'child': const Step4(),
    // },
    // {
    //   'progress': 0.7,
    //   'child': const Step4_5(),
    // },
    // {
    //   'progress': 0.8,
    //   'child': const Step5(),
    // },
    // {
    //   'progress': 0.9,
    //   'child': const Step6(),
    // },
    // {
    //   'progress': 1.0,
    //   'child': const Step7(),
    // },
  ];

  void onContinue() {
    if (currentStep == steps.length - 1) {
      // Get.to(() => const Welcome());
    } else {
      currentStep++;
    }
  }

  void onBack() {
    if (currentStep.value == 0) {
      Get.back();
    } else {
      currentStep--;
    }
  }

  RxInt trainerStep = 0.obs;

  void onNext() {
    if (trainerStep == steps.length - 1) {
      // Get.to(() => const Welcome());
    } else {
      trainerStep++;
    }
  }

  void onPrevious() {
    if (trainerStep.value == 0) {
      Get.back();
    } else {
      trainerStep--;
    }
  }
}
