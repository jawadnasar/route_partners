import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';

class EnterEmail extends StatelessWidget {
  final _authController = Get.find<AuthController>();
  EnterEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: AppSizes.DEFAULT,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextField(
              labelText: 'What\'s your email address?',
              hintText: 'Enter your email',
              controller: _authController.emailController,
            ),
            MyTextField(
              hintText: 'Enter your password',
              controller: _authController.passwordController,
            ),
            MyTextField(
              hintText: 'Confirm password',
              controller: _authController.confirmPasswordController,
            ),
          ],
        ),
      ),
    );
  }
}
