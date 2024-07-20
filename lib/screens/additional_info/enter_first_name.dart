import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';

class EnterFirstAndLastName extends StatelessWidget {
  final _authController = Get.find<AuthController>();

  EnterFirstAndLastName({super.key});

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
              
              labelText: 'What\'s your name?',
              hintText: 'Enter your first name',
              controller: _authController.firstController,
            ),
            MyTextField(
              hintText: 'Enter your last name',
              controller: _authController.lastController,
            )
          ],
        ),
      ),
    );
  }
}
