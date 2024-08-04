import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';

class Interests extends StatelessWidget {
  Interests({super.key});

  final _autController = Get.find<AuthController>();

  final List<String> interests = [
    'Bakeries',
    'Schools',
    'Greenery',
    'Low Traffic',
    'General stores',
    'Libraries',
    'Art',
    'Universities',
    'Gyms',
    'No Speed Breakser'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
        init: _autController,
        builder: (controller) => GridView.builder(
          padding: const EdgeInsets.all(10.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 4,
          ),
          itemCount: interests.length,
          itemBuilder: (context, index) {
            final item = interests[index];
            final isSelected = controller.selectedInterests.contains(item);

            return GestureDetector(
              onTap: () {
                if (isSelected) {
                  controller.selectedInterests.remove(item);
                } else {
                  controller.selectedInterests.add(item);
                }
                controller.update();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? kPrimaryColor : Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: MyText(
                  text: item,
                  color: isSelected == true ? Colors.white : kBlackColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
