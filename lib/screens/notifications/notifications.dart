import 'package:flutter/material.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: simpleAppBar(title: "Notifications"),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                Assets.notifications,
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('No Notifications Found')
          ],
        )));
  }
}
