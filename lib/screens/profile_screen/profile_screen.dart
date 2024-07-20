import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/screens/settings/settings.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
          title: 'Profile',
          bgColor: kPrimaryColor,
          titleColor: Colors.white,
          leadingIconColor: Colors.white,
          actions: [
            IconButton(onPressed: () {
              Get.to(()=> const SettingsScreen());
            }, icon: const Icon(Icons.settings)),
            const SizedBox(
              width: 10,
            )
          ],
          elevation: 0),
      body: SingleChildScrollView(
        child: Column(
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
            Center(
              child: MyButton(
                  radius: 5,
                  buttonText: 'Change Photo',
                  bgColor: kPrimaryColor,
                  textColor: Colors.white,
                  width: Get.width * 0.4,
                  onTap: () {}),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0).copyWith(bottom: 5),
              child: MyTextField(
                hintText: 'Enter first name',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                underLineBorderColor: Colors.white,
                labelText: 'First Name',
                radius: 10,
                filled: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0).copyWith(bottom: 5),
              child: MyTextField(
                hintText: 'Enter last name',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                underLineBorderColor: Colors.white,
                labelText: 'Last Name',
                radius: 10,
                filled: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0).copyWith(bottom: 5),
              child: MyTextField(
                hintText: 'Enter your email',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                underLineBorderColor: Colors.white,
                labelText: 'Email ',
                radius: 10,
                filled: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0).copyWith(bottom: 0),
              child: MyTextField(
                hintText: 'Enter phone number',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                underLineBorderColor: Colors.white,
                labelText: 'Phone Number',
                radius: 10,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: MyButton(
                  radius: 5,
                  bgColor: kPrimaryColor,
                  textColor: Colors.white,
                  onTap: () {}),
            )
          ],
        ),
      ),
    );
  }
}
