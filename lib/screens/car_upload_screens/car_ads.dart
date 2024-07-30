import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/car_upload_screens/car_info.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class MyAds extends StatefulWidget {
  const MyAds({super.key});

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> with TickerProviderStateMixin {
  late TabController? _controller;
  List<String> uploadedCars = [];
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

  @override
  Widget build(BuildContext context) {
    // var carUpload = Get.put<CarUploadController>(CarUploadController());
    // var saveorDelete =
    //     Get.put<SaveOrDeleteController>(SaveOrDeleteController());
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: simpleAppBar(
            title: 'My Ads',
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
                child: TabBarView(controller: _controller, children: [
                  uploadedCars.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('You havent Uploaded any cars'),
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
                                    Get.to(() => const CarInfo());
                                  }),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  Center(
                    child: Text('Coming Soon'),
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
                ]),
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
          )
        ],
      )),
    );
  }
}

class CarDetailsContainer extends StatelessWidget {
  final bool? isSaved;
  // final FeatureCars? cars;
  const CarDetailsContainer({
    super.key,
    // this.cars,
    this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => const CarDetails());
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: kGreyColor2)),
        height: Get.height * 0.24,
        child: Row(
          children: [
            const Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                child: Stack(
                  children: [
                    // cars?.picture!.isEmpty == false
                    //     ? Container(
                    //         decoration: const BoxDecoration(
                    //             image: DecorationImage(
                    //                 image: AssetImage(
                    //                   Images.bmw,
                    //                 ),
                    //                 fit: BoxFit.cover)),
                    //       )
                    //     : const SizedBox.shrink(),
                    // FittedBox(
                    //   child: LocationContainer(
                    //       width: Get.width * 0.25, text: '${cars?.city}'),
                    // )
                  ],
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
                      const Expanded(
                        flex: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Text(
                            //   '${cars?.title}',
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .titleLarge
                            //       ?.copyWith(fontSize: 13),
                            // ),
                            // PopupMenuWidget(
                            //   isSaved: isSaved,
                            //   hashid: cars!.hashId!,
                            //   icon: Icons.more_vert,
                            // )
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 6,
                        child: Row(
                          children: [
                            // Text(
                            //   'PKR ${priceToLacsConverter(cars?.price)} Lacs',
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .titleLarge
                            //       ?.copyWith(fontSize: 15),
                            // )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            // Text(
                            //   '${cars?.modelYear}',
                            //   style: Theme.of(context).textTheme.titleMedium,
                            // ),
                            // SizedBox(
                            //   width: Get.width * 0.03,
                            // ),
                            // DividerCustom(
                            //   color: ColorManager.kdarkGrey,
                            //   height: Get.height * 0.03,
                            //   width: 1,
                            // ),
                            SizedBox(
                              width: Get.width * 0.03,
                            ),
                            // Text(
                            //   '${kmToKsConverter(cars!.carMileage!)} Km',
                            //   style: Theme.of(context).textTheme.titleMedium,
                            // ),
                            SizedBox(
                              width: Get.width * 0.03,
                            ),
                            // DividerCustom(
                            //   color: ColorManager.kdarkGrey,
                            //   height: Get.height * 0.03,
                            //   width: 1,
                            // ),
                            SizedBox(
                              width: Get.width * 0.03,
                            ),
                            Text(
                              'Engine Type',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      isSaved == false
                          ? Expanded(
                              flex: 5,
                              child: MyButton(
                                height: 50,
                                width: Get.width * 0.35,
                                onTap: () {},
                                // primaryIcon: true,
                                // icon: Image.asset(Images.feature),
                              ),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class PopupMenuWidget extends StatelessWidget {
  final bool? isSaved;
  final String? hashid;
  final IconData? icon;
  const PopupMenuWidget({
    super.key,
    this.icon,
    this.hashid,
    this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onOpened: () {},
        icon: Icon(
          icon,
          size: 15,
          color: kBlackColor,
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: () {
                // CarUploadRepo().editCar(hashid!);
                log(hashid.toString());
              },
              value: 'Edit',
              child: Row(
                children: [
                  const Icon(Icons.mode_edit_outlined),
                  const Spacer(),
                  Text(
                    'Edit',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: kBlackColor, fontSize: 15),
                  ),
                ],
              ),
            ),
            isSaved == false
                ? PopupMenuItem(
                    onTap: () {
                      // CarUploadRepo.deleteCar(hashid!);
                    },
                    value: 'Delete',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.delete_outline),
                        const Spacer(),
                        Text(
                          'Delete',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: kBlackColor, fontSize: 15),
                        ),
                      ],
                    ),
                  )
                : PopupMenuItem(
                    onTap: () {
                      // CarUploadRepo.re(hashid!);
                    },
                    value: 'Unsave AD',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.delete_outline),
                        const Spacer(),
                        Text(
                          'Unsave AD',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: kBlackColor, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
            PopupMenuItem(
              value: 'Share',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.share),
                  const Spacer(),
                  Text(
                    'Share',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: kBlackColor, fontSize: 15),
                  ),
                ],
              ),
            ),
          ];
        });
  }
}
