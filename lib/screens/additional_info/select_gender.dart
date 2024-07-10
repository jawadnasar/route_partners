import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({super.key});

  @override
  _SelectGenderState createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  final _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: AppSizes.DEFAULT,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              text: 'How would you like to be addressed?',
              color: kTextColor,
            ),
            ListView.builder(
              itemCount: _authController.genders.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Obx(
                  () => RadioListTile<String>(
                    title: MyText(text: _authController.genders[index]),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: _authController.genders[index],
                    groupValue: _authController.selectedGender.value,
                    onChanged: (value) {
                      _authController.selectedGender.value = value.toString();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
