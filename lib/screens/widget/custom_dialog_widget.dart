// import 'package:bike_gps/core/constants/app_colors.dart';
// import 'package:bike_gps/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_sizes.dart';

class CustomDialog extends StatelessWidget {
  final Widget child;
  // final double height
  const CustomDialog({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: AppSizes.HORIZONTAL,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: child,
        ),
      ],
    );
  }
}
