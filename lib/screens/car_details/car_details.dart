import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/car_hire_controller.dart';
import 'package:route_partners/controllers/car_upload_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/core/constants/firebase_collection_references.dart';
import 'package:route_partners/model/user_model.dart';
import 'package:route_partners/screens/widget/confirm_booking_bottom_sheet.dart';
import 'package:route_partners/main.dart';
import 'package:route_partners/model/car_model.dart';

import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/services/firebase/firebase_crud.dart';

class CarDetails extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  final CarModel car;
  final bool isOwner;

  const CarDetails({
    super.key,
    required this.car,
    required this.isOwner,
  });

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails>
    with SingleTickerProviderStateMixin {
  // ignore: unused_field
  late TabController? _controller;
  late PageController _pageController;
  int pageIndex = 0;
  UserModel? acceptedUser;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _controller = TabController(length: 2, vsync: this);
    Future.delayed(Duration.zero).then(
      (_) async {
        if (widget.car.status == 'Accepted' &&
            widget.car.acceptedUserId != null) {
          _carUploadController.isRequestsLoading.value = true;
          final snapshot =
              await FirebaseCRUDService.instance.readSingleDocument(
            collectionReference: usersCollection,
            docId: widget.car.acceptedUserId!,
          );
          if (snapshot != null) {
            acceptedUser =
                UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
          }
          _carUploadController.isRequestsLoading.value = false;
        }
      },
    );
    super.initState();
  }

  final _carHireController = Get.find<CarHireController>();
  final _carUploadController = Get.find<CarUploadController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: 10),
          width: Get.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.isOwner || widget.car.status == 'Accepted'
                  ? Container()
                  : Obx(
                      () => _carHireController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            )
                          : MyButton(
                              bgColor: kPrimaryColor,
                              textColor: Colors.white,
                              onTap: () {
                                showHowtoPlayBottomSheet(widget.car);
                              },
                              height: Get.height * 0.08,
                              width: Get.width * 0.9,
                            ),
                    ),

              const SizedBox(
                height: 10,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       chatButton(context,
              //           onTap: () {}, icon: Icons.sms, text: 'SMS'),
              //       chatButton(context,
              //           onTap: () {}, icon: Icons.message, text: 'Chat'),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 200,
                    width: Get.width,
                    child: widget.car.carImages == null
                        ? Image.network(
                            dummyCarImage,
                            fit: BoxFit.cover,
                          )
                        : PageView.builder(
                            itemCount: widget.car.carImages?.length ?? 0,
                            controller: _pageController,
                            onPageChanged: (value) {
                              setState(() {
                                pageIndex = value;
                              });
                            },
                            itemBuilder: (context, index) {
                              return widget.car.carImages!.isEmpty
                                  ? Image.network(
                                      dummyCarImage,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      widget.car.carImages?[index] ??
                                          dummyCarImage,
                                      fit: BoxFit.cover,
                                    );
                            }),
                  ),
                  SizedBox(
                    height: 200,
                    width: Get.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.arrow_back)),
                                ),
                                if (!widget.isOwner) ...[
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.favorite_outline_rounded,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.02,
                                      ),
                                      const CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.share,
                                            color: kBlackColor,
                                          ))
                                    ],
                                  )
                                ],
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: DotsIndicatorRow(
                            length: widget.car.carImages?.length ?? 0,
                            pageIndex: pageIndex,
                            activeColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                padding: const EdgeInsets.all(10).copyWith(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.car.carModel ?? 'My Car',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 17, color: kBlackColor),
                        ),
                      ],
                    ),
                    // Text(
                    //   '150000',
                    //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    //         fontWeight: FontWeight.bold,
                    //         color: kBlackColor,
                    //         fontSize: 18,
                    //       ),
                    // ),
                    const SizedBox(height: 10),

                    const SizedBox(
                      height: 10,
                    ),
                    // tabBar(context),

                    MyText(
                      text: 'Car Location',
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyText(
                      text: '${widget.car.address}',
                      size: 12,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildMeterContainer(Icons.location_city,
                            widget.car.registeredArea ?? "ISL"),
                        buildMeterContainer(
                            Icons.price_change, widget.car.pricePerHour ?? "0"),
                        buildMeterContainer(Icons.color_lens,
                            widget.car.exteriorColor ?? "White"),
                        buildMeterContainer(
                            Icons.car_repair, widget.car.carModel ?? "My Car"),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    // const SellYourCarContainer(),
                    const SizedBox(
                      height: 15,
                    ),
                    if (!widget.isOwner) ...[
                      MyText(
                        text: 'Contact Information',
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyText(
                        text: "Name : ${widget.car.ownerName ?? 'User'}",
                        size: 15,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          MyText(
                            text:
                                "Contact No : ${widget.car.ownerPhoneNumber ?? '03359305593'}",
                            size: 15,
                          ),
                        ],
                      ),
                    ] else ...[
                      Obx(
                        () => _carUploadController.isRequestsLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              )
                            : widget.car.status == 'Accepted'
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: MyText(
                                        text: 'Car is rented',
                                      )),
                                      const SizedBox(height: 15),
                                      MyText(
                                        text: acceptedUser?.firstName ?? 'User',
                                        size: 16,
                                        color: kBlackColor,
                                      ),
                                      const SizedBox(height: 5),
                                      MyText(
                                        text: acceptedUser?.phoneNumber ?? '',
                                        size: 16,
                                        color: kBlackColor,
                                      ),
                                    ],
                                  )
                                : widget.car.requestedUsers == null ||
                                        widget.car.requestedUsers!.isEmpty
                                    ? Center(
                                        child: MyText(text: 'No requests'),
                                      )
                                    : Padding(
                                        padding: AppSizes.HORIZONTAL,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: widget
                                                  .car.requestedUsers?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              leading: CircleAvatar(
                                                radius: 20,
                                                child: Image.asset(
                                                  Assets.boyIcon,
                                                  width: Get.height * 0.04,
                                                  height: Get.height * 0.08,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              title: MyText(
                                                text: widget
                                                        .car
                                                        .requestedUsers?[index]
                                                        .name ??
                                                    '',
                                                color: kBlackColor,
                                              ),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.dialog(
                                                        AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          title: Center(
                                                            child: MyText(
                                                              text: 'Reject',
                                                              weight: FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                          content: ListView(
                                                              shrinkWrap: true,
                                                              children: [
                                                                MyText(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  text:
                                                                      'Are you sure you want to reject this car request?',
                                                                  color:
                                                                      kPrimaryColor,
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          MyButton(
                                                                        onTap:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                        buttonText:
                                                                            'No',
                                                                        bgColor:
                                                                            Colors.red,
                                                                        textColor:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            5),
                                                                    Expanded(
                                                                      child:
                                                                          MyButton(
                                                                        onTap:
                                                                            () async {
                                                                          Get.back();
                                                                          await _carUploadController.rejectRequest(
                                                                              widget.car.carId!,
                                                                              widget.car.requestedUsers![index].id!);
                                                                        },
                                                                        buttonText:
                                                                            'Yes',
                                                                        textColor:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ]),
                                                        ),
                                                      );
                                                    },
                                                    child: const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.dialog(
                                                        AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          title: Center(
                                                            child: MyText(
                                                              text: 'Accept',
                                                              weight: FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                          content: ListView(
                                                              shrinkWrap: true,
                                                              children: [
                                                                MyText(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  text:
                                                                      'Are you sure you want to accept this car request?',
                                                                  color:
                                                                      kPrimaryColor,
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          MyButton(
                                                                        onTap:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                        buttonText:
                                                                            'No',
                                                                        bgColor:
                                                                            Colors.red,
                                                                        textColor:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            5),
                                                                    Expanded(
                                                                      child:
                                                                          MyButton(
                                                                        onTap:
                                                                            () async {
                                                                          Get.back();
                                                                          await _carUploadController.acceptRequest(
                                                                              widget.car.carId!,
                                                                              widget.car.requestedUsers![index].id!);
                                                                        },
                                                                        buttonText:
                                                                            'Yes',
                                                                        textColor:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ]),
                                                        ),
                                                      );
                                                    },
                                                    child: const Icon(
                                                      Icons.done,
                                                      color: kSecondaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          )),
        ));
  }

  buildMeterContainer(IconData icon, String value) {
    return Container(
      height: Get.height * 0.1,
      width: Get.width * 0.2,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kDarkGreyColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 2,
          ),
          Expanded(flex: 4, child: Icon(icon)),
          const SizedBox(height: 8),
          Flexible(
            flex: 4,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  chatButton(BuildContext context,
      {IconData? icon, String? text, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFEEF2F6))),
        child: Row(
          children: [
            Row(
              children: [
                Icon(icon),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                Text(
                  '$text',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: kBlackColor),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  _buildMeterContainer(String imagePath, String value) {
    return Container(
      height: Get.height * 0.13,
      width: Get.width * 0.2,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kDarkGreyColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 4,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            flex: 4,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildContainer(String icon) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(color: kDarkGreyColor),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Image.asset(icon),
        const SizedBox(width: 5),
      ],
    ),
  );
}

class CarFeaturesWidget extends StatelessWidget {
  final String? text1;
  final String? text2;
  const CarFeaturesWidget({super.key, this.text1, this.text2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$text1'),
          Text(
            '$text2',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: kBlackColor, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class DotsIndicatorRow extends StatelessWidget {
  final int? length;
  final Color? activeColor;
  final Color? inactiveColor;
  // ignore: use_super_parameters
  const DotsIndicatorRow({
    Key? key,
    required this.pageIndex,
    this.activeColor = kBlackColor,
    this.inactiveColor = kDarkGreyColor,
    this.length = 4,
  }) : super(key: key);

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
            length!,
            (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 15, left: 10),
                  child: DotsIndicator(
                    isActive: index == pageIndex,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                  ),
                ))
      ],
    );
  }
}

class DotsIndicator extends StatefulWidget {
  final Color? activeColor;
  final Color? inactiveColor;
  final bool isActive;
  const DotsIndicator({
    required this.isActive,
    Key? key,
    this.activeColor = kBlackColor,
    this.inactiveColor = kDarkGreyColor,
  }) : super(key: key);

  @override
  State<DotsIndicator> createState() => _DotsIndicatorState();
}

class _DotsIndicatorState extends State<DotsIndicator> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 3),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: widget.isActive == true
              ? AnimatedContainer(
                  decoration: BoxDecoration(
                      color: widget.activeColor,
                      borderRadius: BorderRadius.circular(20)),
                  duration: const Duration(milliseconds: 3000),
                  height: 4.5,
                  width: 43,
                )
              : CircleAvatar(
                  radius: 3,
                  backgroundColor: widget.inactiveColor,
                )),
    );
  }
}
