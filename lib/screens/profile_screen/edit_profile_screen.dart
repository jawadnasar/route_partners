import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/utils/snackbars.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _authController.firstController.text =
        _authController.userModel.value?.firstName ?? '';
    _authController.lastController.text =
        _authController.userModel.value?.lastName ?? '';
    _authController.emailController.text =
        _authController.userModel.value?.email ?? '';
    _authController.phoneNumberController.text =
        _authController.userModel.value?.phoneNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
          title: 'Profile',
          bgColor: kPrimaryColor,
          titleColor: Colors.white,
          leadingIconColor: Colors.white,
          elevation: 0),
      body: SingleChildScrollView(
        child: Column(
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
            // Center(
            //   child: MyButton(
            //       radius: 5,
            //       buttonText: 'Change Photo',
            //       bgColor: kPrimaryColor,
            //       textColor: Colors.white,
            //       width: Get.width * 0.4,
            //       onTap: () {}),
            // ),
            Padding(
              padding: const EdgeInsets.all(15.0).copyWith(bottom: 5),
              child: MyTextField(
                hintText: 'Enter first name',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                underLineBorderColor: Colors.white,
                labelText: 'First Name',
                radius: 10,
                filled: true,
                controller: _authController.firstController,
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
                controller: _authController.lastController,
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
                readonly: true,
                controller: _authController.emailController,
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
                controller: _authController.phoneNumberController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Obx(
                () => MyButton(
                  radius: 5,
                  bgColor: kPrimaryColor,
                  textColor: Colors.white,
                  showLoading: _authController.isEditLoading.value,
                  onTap: () async {
                    final customSnackbars = CustomSnackBars.instance;
                    if (_authController.firstController.text.isEmpty) {
                      customSnackbars.showFailureSnackbar(
                          title: 'Missing', message: 'First name is required');
                    } else if (_authController
                        .phoneNumberController.text.isEmpty) {
                      customSnackbars.showFailureSnackbar(
                          title: 'Missing',
                          message: 'Phone number is required');
                    } else {
                      final isEdited = await _authController.editUserInfo(
                          _authController.firstController.text,
                          _authController.lastController.text,
                          _authController.phoneNumberController.text);
                      if (isEdited) {
                        Get.back();
                      } else {
                        CustomSnackBars.instance.showFailureSnackbar(
                            title: 'Error', message: 'Error Editing User Info');
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
