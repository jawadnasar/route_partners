// ignore_for_file: library_private_types_in_public_api, unused_local_variable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/controllers/car_hire_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/model/car_model.dart';
import 'package:route_partners/screens/browse_cars/car_info_container.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

List<String> texts = ['Price', 'Location', 'Year', 'Km Driven'];
double height = MediaQuery.of(Get.context!).size.height;

class FoundCarsForRent extends StatelessWidget {
  final String? screenTitle;

  FoundCarsForRent({super.key, this.screenTitle});
  final _carHireController = Get.find<CarHireController>();
  final _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    final appBar = simpleAppBar(
      title: "Results found",
      color: kBlackColor,
    );

    // final sortAndFilterContainer = Container(
    //   height: 60,
    //   width: Get.width * 0.7,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(50),
    //     color: kBlackColor,
    //   ),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       InkWell(
    //         onTap: () {},
    //         child: Row(
    //           children: [
    //             const Column(
    //               mainAxisSize: MainAxisSize.min,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Icon(
    //                   Icons.keyboard_arrow_up_rounded,
    //                   color: Colors.white,
    //                   size: 15,
    //                 ),
    //                 Icon(
    //                   Icons.keyboard_arrow_down_rounded,
    //                   color: Colors.white,
    //                   size: 15,
    //                 )
    //               ],
    //             ),
    //             const SizedBox(width: 10),
    //             Text(
    //               'Sort By',
    //               style: Theme.of(context)
    //                   .textTheme
    //                   .titleMedium
    //                   ?.copyWith(color: Colors.white),
    //             ),
    //           ],
    //         ),
    //       ),
    //       const DividerCustom(
    //         color: Colors.white,
    //         height: 30,
    //       ),
    //       InkWell(
    //         onTap: () {
    //           Get.to(() => const SearchForCars());
    //         },
    //         child: Row(
    //           children: [
    //             const Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 SizedBox(width: 10),
    //                 Icon(
    //                   Icons.menu_rounded,
    //                   color: Colors.white,
    //                 )
    //               ],
    //             ),
    //             const SizedBox(width: 10),
    //             Text(
    //               'Filter',
    //               style: Theme.of(context)
    //                   .textTheme
    //                   .titleMedium
    //                   ?.copyWith(color: Colors.white),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    // Widget carGrid = Flexible(
    //     child: GridView.builder(
    //   itemCount: 5,
    //   shrinkWrap: true,
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //     crossAxisSpacing: 15,
    //     mainAxisSpacing: 15,
    //     childAspectRatio: 0.7,
    //   ),
    //   itemBuilder: (context, index) {
    //     return const CanInfoContainer();
    //   },
    // ));

    return Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.only(bottom: 50),
        //   child: sortAndFilterContainer,
        // ),
        appBar: appBar,
        body: SafeArea(
          minimum: const EdgeInsets.all(10),
          child: StreamBuilder(
            stream: _carHireController.getAvailableCars(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                );
              } else if (!snapshot.hasData) {
                return Center(
                    child: MyText(text: 'No cars available for rent'));
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child: MyText(text: 'No cars available for rent'));
              }
              List<CarModel> filteredCars = [];
              _carHireController.allAvailableCars.clear();
              final docs = snapshot.data?.docs;
              for (var doc in docs!) {
                final Map<String, dynamic> data =
                    doc.data() as Map<String, dynamic>;
                _carHireController.allAvailableCars.add(CarModel.fromMap(data));
              }
              if (_carHireController.allAvailableCars.isNotEmpty) {
                for (var car in _carHireController.allAvailableCars) {
                  // if (car.requestedUsers!.isEmpty ||
                  //     car.requestedUsers == null) {
                  //   filteredCars.add(car);
                  // } else {
                  //   for (var user in car.requestedUsers!) {
                  //     if (user.id != _authController.userModel.value?.userId) {
                  //       filteredCars.add(car);
                  //     }
                  //   }
                  // }
                  if (car.rejectedUsersIds == null ||
                      car.rejectedUsersIds!.isEmpty) {
                    filteredCars.add(car);
                  } else {
                    if (!car.rejectedUsersIds!
                        .contains(_authController.userModel.value?.userId)) {
                      filteredCars.add(car);
                    }
                  }
                }
              }
              return filteredCars.isEmpty
                  ? Center(child: MyText(text: 'No cars availanle for rent'))
                  : GridView.builder(
                      itemCount: filteredCars.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        return CanInfoContainer(
                          car: filteredCars[index],
                        );
                      },
                    );
            },
          ),
        ));
  }
}
