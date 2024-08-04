import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/controllers/car_hire_controller.dart';
import 'package:route_partners/controllers/car_upload_controller.dart';
import 'package:route_partners/core/bindings/bindings.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/main.dart';
import 'package:route_partners/model/car_model.dart';
import 'package:route_partners/screens/browse_cars/browse_cars.dart';
import 'package:route_partners/screens/car_details/car_details.dart';
import 'package:route_partners/screens/car_upload_screens/car_info.dart';
import 'package:route_partners/screens/search_screen/search_car_for_rent.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class MyAds extends StatefulWidget {
  const MyAds({super.key});

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> with TickerProviderStateMixin {
  late TabController? _controller;
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  final _carUploadController =
      Get.put<CarUploadController>(CarUploadController());
  final _carHireController = Get.find<CarHireController>();
  final _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    // var saveorDelete =
    //     Get.put<SaveOrDeleteController>(SaveOrDeleteController());
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          elevation: 0,
          backgroundColor: kBackgroundColor,
          title: const Text(
            'MyAds',
            style: TextStyle(
              wordSpacing: 0.7,
              fontWeight: FontWeight.w500,
              color: kBlackColor,
              fontSize: 20,
            ),
          ),
        ),
        body: Padding(
          padding: AppSizes.DEFAULT,
          child: Column(
            children: [
              TabBar(
                indicatorWeight: 3,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                labelColor: Colors.black,
                indicatorColor: kPrimaryColor,
                controller: _controller,
                tabs: const [
                  Tab(
                    text: 'Upload a car',
                  ),
                  Tab(text: 'Hire a Car'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: [
                    // First tab
                    StreamBuilder(
                        stream: _carUploadController.getUploadedCars(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            );
                          } else if (!snapshot.hasData) {
                            return const NoSavedAds();
                          } else if (snapshot.data!.docs.isEmpty) {
                            return const NoSavedAds();
                          }
                          _carUploadController.myCarsAds.clear();
                          final docs = snapshot.data?.docs;
                          for (var doc in docs!) {
                            final Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;
                            _carUploadController.myCarsAds
                                .add(CarModel.fromMap(data));
                          }
                          return _carUploadController.myCarsAds.isEmpty
                              ? const NoSavedAds()
                              : Column(
                                  children: [
                                    Expanded(
                                      child: ListView.separated(
                                          separatorBuilder: (context, index) {
                                            return const Padding(
                                                padding: EdgeInsets.all(5));
                                          },
                                          itemCount: _carUploadController
                                              .myCarsAds.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return CarDetailsContainers(
                                              car: _carUploadController
                                                  .myCarsAds[index],
                                            );
                                          }),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: kPrimaryColor,
                                          shape: const CircleBorder(),
                                        ),
                                        onPressed: () {
                                          Get.to(() => const CarInfo(),
                                              binding: CarUploadBindings());
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.add,
                                            color: kWhiteColor2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                        }),

                    /// Second Tab
                    ListView(
                      shrinkWrap: true,
                      children: [
                        StreamBuilder(
                          stream: _carHireController.getMyCars(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              );
                            } else if (!snapshot.hasData) {
                              return const NoSavedHires();
                            } else if (snapshot.data!.docs.isEmpty) {
                              return const NoSavedHires();
                            }
                            CarModel? filteredCar;
                            _carHireController.availableCars.clear();
                            final docs = snapshot.data?.docs;
                            for (var doc in docs!) {
                              final Map<String, dynamic> data =
                                  doc.data() as Map<String, dynamic>;
                              _carHireController.availableCars
                                  .add(CarModel.fromMap(data));
                            }
                            for (var car in _carHireController.availableCars) {
                              if (car.requestedUsers!.isNotEmpty ||
                                  car.acceptedUserId != null) {
                                for (var user in car.requestedUsers!) {
                                  if (user.id ==
                                      _authController.userModel.value?.userId) {
                                    filteredCar = car;
                                    break;
                                  }
                                }
                                if (filteredCar == null) {
                                  if (car.acceptedUserId ==
                                      _authController.userModel.value?.userId) {
                                    log(car.acceptedUserId.toString());
                                    filteredCar = car;
                                  }
                                }
                              }
                            }
                            return filteredCar == null
                                ? const Center(child: NoSavedHires())
                                : CarHireDetailsContainers(
                                    car: filteredCar,
                                  );
                          },
                        ),
                      ],
                    )

                    // ListView.separated(
                    //     separatorBuilder: (context, index) => SizedBox(
                    //           height: Get.height * 0.025,
                    //         ),
                    //     itemCount: 4,
                    //     shrinkWrap: true,
                    //     itemBuilder: (context, index) {
                    //       // final ads =
                    //       //     CarUploadController.i.pendingCars[index];
                    //       return const CarDetailsContainer(
                    //         // cars: ads,
                    //         isSaved: false,
                    //       );
                    //     }),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class NoSavedAds extends StatelessWidget {
  const NoSavedAds({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSizes.DEFAULT,
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image.asset(Images.noactiveAds),
          const SizedBox(
            height: 20,
          ),
          Text(
            'No Saved Ads',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'You haven’t Saved anything yet. Would you like to sell something?',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: MyButton(
                width: Get.width * 0.8,
                bgColor: kPrimaryColor,
                textColor: Colors.white,
                textSize: 20,
                buttonText: 'Upload a car for hiring',
                onTap: () {
                  Get.to(() => const CarInfo(), binding: CarUploadBindings());
                }),
          ),
        ],
      )),
    );
  }
}

class NoSavedHires extends StatelessWidget {
  const NoSavedHires({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSizes.DEFAULT,
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image.asset(Images.noactiveAds),
          const SizedBox(
            height: 20,
          ),
          Text(
            'No car hired',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'You haven’t hired anything yet. Would you like to rent something?',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: MyButton(
                width: Get.width * 0.8,
                bgColor: kPrimaryColor,
                textColor: Colors.white,
                textSize: 20,
                buttonText: 'Browse cars for rent',
                onTap: () {
                  Get.to(() => FoundCarsForRent());
                }),
          ),
        ],
      )),
    );
  }
}

class CarDetailsContainers extends StatelessWidget {
  final CarModel car;
  const CarDetailsContainers({
    required this.car,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CarDetails(
              car: car,
              isOwner: true,
            ));
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: kGreyColor8)),
            height: Get.height * 0.2,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    child: Container(
                      decoration: BoxDecoration(
                          image: car.carImages!.isEmpty
                              ? const DecorationImage(
                                  image: NetworkImage(
                                    dummyCarImage,
                                  ),
                                  fit: BoxFit.cover)
                              : DecorationImage(
                                  image: NetworkImage(
                                    car.carImages?[0] ?? dummyCarImage,
                                  ),
                                  fit: BoxFit.cover)),
                    ),
                  ),
                ),
                Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  car.carModel ?? 'My Car',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Row(
                              children: [
                                Text(
                                  'PKR ${car.pricePerHour ?? '0'} /hr',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontSize: 15),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                Text(
                                  car.modelYear ?? '2000',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                DividerCustom(
                                  color: kGreyColor,
                                  height: Get.height * 0.03,
                                  width: 1,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Text(
                                  car.registeredArea ?? 'ISL',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                DividerCustom(
                                  color: kDarkGreyColor,
                                  height: Get.height * 0.03,
                                  width: 1,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Text(
                                  car.exteriorColor ?? 'White',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kPrimaryColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: MyText(
                textAlign: TextAlign.center,
                text: car.status.toString(),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarHireDetailsContainers extends StatelessWidget {
  final CarModel car;
  const CarHireDetailsContainers({
    required this.car,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CarDetails(
              car: car,
              isOwner: false,
            ));
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: kGreyColor8)),
            height: Get.height * 0.2,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    child: Container(
                      decoration: BoxDecoration(
                          image: car.carImages!.isEmpty
                              ? const DecorationImage(
                                  image: NetworkImage(
                                    dummyCarImage,
                                  ),
                                  fit: BoxFit.cover)
                              : DecorationImage(
                                  image: NetworkImage(
                                    car.carImages?[0] ?? dummyCarImage,
                                  ),
                                  fit: BoxFit.cover)),
                    ),
                  ),
                ),
                Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  car.carModel ?? 'My Car',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Row(
                              children: [
                                Text(
                                  'PKR ${car.pricePerHour ?? '0'} /hr',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontSize: 15),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                Text(
                                  car.modelYear ?? '2000',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                DividerCustom(
                                  color: kGreyColor,
                                  height: Get.height * 0.03,
                                  width: 1,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Text(
                                  car.registeredArea ?? 'ISL',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                DividerCustom(
                                  color: kDarkGreyColor,
                                  height: Get.height * 0.03,
                                  width: 1,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Text(
                                  car.exteriorColor ?? 'White',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kPrimaryColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: MyText(
                textAlign: TextAlign.center,
                text: car.status == 'Published'
                    ? 'Requested'
                    : car.status.toString(),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DividerCustom extends StatelessWidget {
  final double? width;
  final Color? color;
  final double? height;
  const DividerCustom({
    this.color = kBlackColor,
    this.height = 0.05,
    super.key,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Get.height * 0.05,
      width: 1,
      color: color ?? kBlackColor,
      child: const Text(''),
    );
  }
}

// class CarDetailsContainer extends StatelessWidget {
//   final bool? isSaved;
//   // final FeatureCars? cars;
//   const CarDetailsContainer({
//     super.key,
//     // this.cars,
//     this.isSaved,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Get.to(() => const CarDetails());
//       },
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: kGreyColor2)),
//         height: Get.height * 0.24,
//         child: Row(
//           children: [
//             const Expanded(
//               flex: 5,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     bottomLeft: Radius.circular(15)),
//                 child: Stack(
//                   children: [
//                     // cars?.picture!.isEmpty == false
//                     //     ? Container(
//                     //         decoration: const BoxDecoration(
//                     //             image: DecorationImage(
//                     //                 image: AssetImage(
//                     //                   Images.bmw,
//                     //                 ),
//                     //                 fit: BoxFit.cover)),
//                     //       )
//                     //     : const SizedBox.shrink(),
//                     // FittedBox(
//                     //   child: LocationContainer(
//                     //       width: Get.width * 0.25, text: '${cars?.city}'),
//                     // )
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//                 flex: 9,
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Expanded(
//                         flex: 8,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             // Text(
//                             //   '${cars?.title}',
//                             //   style: Theme.of(context)
//                             //       .textTheme
//                             //       .titleLarge
//                             //       ?.copyWith(fontSize: 13),
//                             // ),
//                             // PopupMenuWidget(
//                             //   isSaved: isSaved,
//                             //   hashid: cars!.hashId!,
//                             //   icon: Icons.more_vert,
//                             // )
//                           ],
//                         ),
//                       ),
//                       const Expanded(
//                         flex: 6,
//                         child: Row(
//                           children: [
//                             // Text(
//                             //   'PKR ${priceToLacsConverter(cars?.price)} Lacs',
//                             //   style: Theme.of(context)
//                             //       .textTheme
//                             //       .titleLarge
//                             //       ?.copyWith(fontSize: 15),
//                             // )
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         flex: 4,
//                         child: Row(
//                           children: [
//                             // Text(
//                             //   '${cars?.modelYear}',
//                             //   style: Theme.of(context).textTheme.titleMedium,
//                             // ),
//                             // SizedBox(
//                             //   width: Get.width * 0.03,
//                             // ),
//                             // DividerCustom(
//                             //   color: ColorManager.kdarkGrey,
//                             //   height: Get.height * 0.03,
//                             //   width: 1,
//                             // ),
//                             SizedBox(
//                               width: Get.width * 0.03,
//                             ),
//                             // Text(
//                             //   '${kmToKsConverter(cars!.carMileage!)} Km',
//                             //   style: Theme.of(context).textTheme.titleMedium,
//                             // ),
//                             SizedBox(
//                               width: Get.width * 0.03,
//                             ),
//                             // DividerCustom(
//                             //   color: ColorManager.kdarkGrey,
//                             //   height: Get.height * 0.03,
//                             //   width: 1,
//                             // ),
//                             SizedBox(
//                               width: Get.width * 0.03,
//                             ),
//                             Text(
//                               'Engine Type',
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       isSaved == false
//                           ? Expanded(
//                               flex: 5,
//                               child: MyButton(
//                                 height: 50,
//                                 width: Get.width * 0.35,
//                                 onTap: () {},
//                                 // primaryIcon: true,
//                                 // icon: Image.asset(Images.feature),
//                               ),
//                             )
//                           : const SizedBox.shrink(),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                     ],
//                   ),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PopupMenuWidget extends StatelessWidget {
//   final bool? isSaved;
//   final String? hashid;
//   final IconData? icon;
//   const PopupMenuWidget({
//     super.key,
//     this.icon,
//     this.hashid,
//     this.isSaved,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//         onOpened: () {},
//         icon: Icon(
//           icon,
//           size: 15,
//           color: kBlackColor,
//         ),
//         itemBuilder: (context) {
//           return [
//             PopupMenuItem(
//               onTap: () {
//                 // CarUploadRepo().editCar(hashid!);
//                 log(hashid.toString());
//               },
//               value: 'Edit',
//               child: Row(
//                 children: [
//                   const Icon(Icons.mode_edit_outlined),
//                   const Spacer(),
//                   Text(
//                     'Edit',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.copyWith(color: kBlackColor, fontSize: 15),
//                   ),
//                 ],
//               ),
//             ),
//             isSaved == false
//                 ? PopupMenuItem(
//                     onTap: () {
//                       // CarUploadRepo.deleteCar(hashid!);
//                     },
//                     value: 'Delete',
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         const Icon(Icons.delete_outline),
//                         const Spacer(),
//                         Text(
//                           'Delete',
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleLarge
//                               ?.copyWith(color: kBlackColor, fontSize: 15),
//                         ),
//                       ],
//                     ),
//                   )
//                 : PopupMenuItem(
//                     onTap: () {
//                       // CarUploadRepo.re(hashid!);
//                     },
//                     value: 'Unsave AD',
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         const Icon(Icons.delete_outline),
//                         const Spacer(),
//                         Text(
//                           'Unsave AD',
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleLarge
//                               ?.copyWith(color: kBlackColor, fontSize: 15),
//                         ),
//                       ],
//                     ),
//                   ),
//             PopupMenuItem(
//               value: 'Share',
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   const Icon(Icons.share),
//                   const Spacer(),
//                   Text(
//                     'Share',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.copyWith(color: kBlackColor, fontSize: 15),
//                   ),
//                 ],
//               ),
//             ),
//           ];
//         });
//   }
// }

