import 'package:flutter/material.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';

class EnterFirstAndLastName extends StatelessWidget {
  const EnterFirstAndLastName({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppSizes.DEFAULT,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextField(
              labelText: 'What\'s your name?',
              hintText: 'Enter your first name',
            ),
            MyTextField(
              
              hintText: 'Enter your last name',
            )
          ],
        ),
      ),
    );
  }
}
