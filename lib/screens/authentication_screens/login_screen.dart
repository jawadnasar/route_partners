import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/controllers/general_controller.dart';
import 'package:route_partners/core/bindings/bindings.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/core/utils/validators.dart';
import 'package:route_partners/screens/authentication_screens/sign_up_with_phone.dart';
import 'package:route_partners/screens/dashboard/bottom_bar.dart';
import 'package:route_partners/screens/dashboard/bottom_navigation_bar.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _generalController = Get.find<GeneralController>();
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      appBar: simpleAppBar(
        title: 'Login',
        onLeadingTap: () {
          log('message');
          Get.back();
        },
      ),
      body: SafeArea(
        minimum: AppSizes.DEFAULT,
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _authController.loginFormKey,
                child: Column(
                  children: [
                    MyTextField(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      controller: _authController.emailController,
                      validator: (value) {
                        return ValidationService.instance.emailValidator(value);
                      },
                    ),
                    Obx(
                      () => MyTextField(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        controller: _authController.passwordController,
                        isObSecure: _authController.isObscure.value,
                        suffixIcon: _authController.isObscure.value
                            ? Assets.passwordHide
                            : Assets.passwordShow,
                        onSuffixTap: () {
                          _authController.isObscure.value =
                              !_authController.isObscure.value;
                        },
                        haveSuffix: true,
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Obx(
                () => _authController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      )
                    : MyButton(
                        buttonText: 'Login',
                        radius: 5,
                        bgColor: kPrimaryColor,
                        textColor: kWhiteColor2,
                        weight: FontWeight.w900,
                        onTap: () async {
                          if (_authController.loginFormKey.currentState!
                              .validate()) {
                            //login
                            await _authController.loginEmailPassword();
                            log(_authController.isAuth.value.toString());
                            if (_authController.isAuth.value) {
                              Get.offAll(() => const DashBoard(),
                                  binding: HomeBindings());
                            }
                          }
                        },
                        width: Get.width,
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    text: 'Don\'t have an account? ',
                  ),
                  MyText(
                    onTap: () {
                      Get.to(() => PhoneAuthAndSocial());
                    },
                    text: 'Signup',
                    color: kPrimaryColor,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: kGreyColor3,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MyText(
                    text: 'OR',
                    color: kGreyColor3,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: kGreyColor3,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(
                () => _authController.isGoogleLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          await _authController.googleLogin();
                          if (_authController.isAuth.value) {
                            Get.offAll(() => const HomePage(),
                                binding: HomeBindings());
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.5,
                                    color: kGreyColor3,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              width: Get.width,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.2,
                                  ),
                                  Expanded(
                                    child: MyText(
                                      text: 'CONTINUE WITH GOOGLE',
                                      weight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 5,
                              child: SvgPicture.asset(Assets.googleSignIn),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
