import 'package:flutter/material.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({super.key});

  @override
  _SelectGenderState createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                List<String> genders = ['Mr', 'Ms/Mrs', 'Not specified'];
                return RadioListTile<String>(
                  title: MyText(text: genders[index]),
                  controlAffinity: ListTileControlAffinity.trailing,
                  value: genders[index],
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
