// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/controllers/bottom_bar_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/screens/car_upload_screens/car_ads.dart';
import 'package:route_partners/screens/chat_screens/my_chats.dart';
import 'package:route_partners/screens/dashboard/bottom_bar.dart';
import 'package:route_partners/screens/my_rides/my_rides.dart';
import 'package:route_partners/screens/profile_screen/profile_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    var bottomBarCont = Get.put<BottomBarController>(BottomBarController());
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: GetBuilder<BottomBarController>(
        builder: (cont) {
          return BottomNavigationBar(
            selectedItemColor: kTertiaryColor,
            unselectedItemColor: kBlackColor,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: bottomBarCont.selectedIndex,
            onTap: (value) {
              bottomBarCont.updateSelectedIndex(value);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.car_crash,
                  color: bottomBarCont.selectedIndex == 0
                      ? kPrimaryColor
                      : kGreyColor,
                ),
                label: 'Carpool',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                  color: bottomBarCont.selectedIndex == 1
                      ? kPrimaryColor
                      : kGreyColor,
                ),
                label: 'Rides',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.message,
                  color: bottomBarCont.selectedIndex == 2
                      ? kPrimaryColor
                      : kGreyColor,
                ),
                label: 'CHATS',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.ads_click,
                  color: bottomBarCont.selectedIndex == 3
                      ? kPrimaryColor
                      : kGreyColor,
                ),
                label: 'My Cars',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_4,
                  color: bottomBarCont.selectedIndex == 4
                      ? kPrimaryColor
                      : kGreyColor,
                ),
                label: 'PROFILE',
              ),
            ],
          );
        },
      ),
      body: GetBuilder<BottomBarController>(
        builder: (cont) {
          return IndexedStack(
            index: bottomBarCont.selectedIndex,
            children: [
              HomePage(),
              MyRides(),
              MyChats(
                currentUserId: authController.userModel.value?.userId ?? "",
              ),
              MyAds(),
              ProfileScreen()
            ],
          );
        },
      ),
    );
  }
}
