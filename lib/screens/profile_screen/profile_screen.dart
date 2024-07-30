import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/controllers/onboarding_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/screens/settings/settings.dart';
import 'package:route_partners/screens/authentication_screens/login_screen.dart';
import 'package:route_partners/screens/profile_screen/edit_profile_screen.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
          title: 'Profile',
          bgColor: kPrimaryColor,
          titleColor: Colors.white,
          leadingIconColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => const SettingsScreen());
                },
                icon: const Icon(Icons.settings)),
            const SizedBox(
              width: 10,
            )
          ],
          elevation: 0),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: Get.height * 0.2,
                    width: Get.width,
                    decoration: const BoxDecoration(color: kPrimaryColor),
                    alignment: Alignment.bottomCenter,
                  ),
                  const Positioned(
                    top: 70,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: kBackgroundColor,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(Assets.boyIcon),
                          radius: 70,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.12,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.3),
                child: MyBorderButton(
                  onTap: () {
                    Get.to(() => const EditProfile());
                  },
                  buttonText: 'Edit Profile',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    MyText(
                      text: 'First Name',
                      size: 10,
                      weight: FontWeight.w500,
                      color: kTextColor,
                      paddingBottom: 3,
                    ),
                    ListTile(
                      tileColor: Colors.white60,
                      title: MyText(
                          text: _authController.userModel.value?.firstName ??
                              'Driver'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyText(
                      text: 'Last Name',
                      size: 10,
                      weight: FontWeight.w500,
                      color: kTextColor,
                      paddingBottom: 3,
                    ),
                    ListTile(
                      tileColor: Colors.white60,
                      title: MyText(
                          text:
                              _authController.userModel.value?.lastName ?? ''),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyText(
                      text: 'Email',
                      size: 10,
                      weight: FontWeight.w500,
                      color: kTextColor,
                      paddingBottom: 3,
                    ),
                    ListTile(
                        tileColor: Colors.white60,
                        title: MyText(
                            text:
                                _authController.userModel.value?.email ?? '')),
                    const SizedBox(
                      height: 10,
                    ),
                    MyText(
                      text: 'Phone Number',
                      size: 10,
                      weight: FontWeight.w500,
                      color: kTextColor,
                      paddingBottom: 3,
                    ),
                    ListTile(
                      tileColor: Colors.white60,
                      title: MyText(
                          text: _authController.userModel.value?.phoneNumber ??
                              ''),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              // Center(
              //   child: MyButton(
              //       radius: 5,
              //       buttonText: 'Change Photo',
              //       bgColor: kPrimaryColor,
              //       textColor: Colors.white,
              //       width: Get.width * 0.4,
              //       onTap: () {}),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(15.0).copyWith(bottom: 5),
              //   child: MyTextField(
              //     hintText: 'Enter first name',
              //     contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              //     underLineBorderColor: Colors.white,
              //     labelText: 'First Name',
              //     radius: 10,
              //     filled: true,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(15.0).copyWith(bottom: 5),
              //   child: MyTextField(
              //     hintText: 'Enter last name',
              //     contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              //     underLineBorderColor: Colors.white,
              //     labelText: 'Last Name',
              //     radius: 10,
              //     filled: true,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(15.0).copyWith(bottom: 5),
              //   child: MyTextField(
              //     hintText: 'Enter your email',
              //     contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              //     underLineBorderColor: Colors.white,
              //     labelText: 'Email ',
              //     radius: 10,
              //     filled: true,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(15.0).copyWith(bottom: 0),
              //   child: MyTextField(
              //     hintText: 'Enter phone number',
              //     contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              //     underLineBorderColor: Colors.white,
              //     labelText: 'Phone Number',
              //     radius: 10,
              //     filled: true,
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: MyButton(
              //       radius: 5,
              //       bgColor: kPrimaryColor,
              //       textColor: Colors.white,
              //       onTap: () {}),
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 80),
                child: MyButton(
                  buttonText: 'Logout',
                  radius: 5,
                  bgColor: Colors.white,
                  textColor: Colors.red,
                  onTap: () async {
                    OnboardingController.instance.currentStep.value = 0;
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('route_partners_uid');
                    _authController.resetValues();
                    Get.offAll(() => const LoginScreen());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
