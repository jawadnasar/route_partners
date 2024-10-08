import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';

class DateOfBirth extends StatelessWidget {
  final _authController = Get.find<AuthController>();
  DateOfBirth({super.key});

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
              labelText: 'What\'s your date of birth?',
              hintText: '(dd/mm/yyyy)',
              controller: _authController.dateOfBirthController,
            ),
            MyText(
              text: 'Enter the same DOB as your government ID',
              color: kTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
