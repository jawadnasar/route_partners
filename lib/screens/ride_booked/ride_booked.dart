import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/bindings/bindings.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/screens/dashboard/bottom_bar.dart';
import 'package:route_partners/screens/dashboard/bottom_navigation_bar.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';

class RideBookedSuccessfully extends StatelessWidget {
  const RideBookedSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                Assets.completed,
                height: Get.height * 0.2,
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: MyText(
                  textAlign: TextAlign.center,
                  text: 'Your Ride is Booked Successfully Enjoy your Ride',
                  size: 30,
                  color: Colors.white,
                  weight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: MyText(
                  textAlign: TextAlign.center,
                  text: 'Go to my Rides to View the Status of your ride',
                  size: 15,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              MyButton(
                  bgColor: Colors.white,
                  textColor: kPrimaryColor,
                  weight: FontWeight.w900,
                  buttonText: 'OKAY',
                  onTap: () {
                    Get.offAll(() => const DashBoard(),
                        binding: HomeBindings());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
