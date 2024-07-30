import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/controllers/find_ride_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_fonts.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/utils/snackbars.dart';
import 'package:route_partners/model/ride_request_model.dart';
import 'package:route_partners/screens/dashboard/bottom_bar.dart';
import 'package:route_partners/screens/google_maps_screen/google_map_route_customer_screen.dart';
import 'package:route_partners/screens/ride_booked/ride_booked.dart';
import 'package:route_partners/screens/widget/common_image_view_widget.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class RideDetails extends StatelessWidget {
  RideRequestModel request;
  double distance;
  RideDetails({required this.request, required this.distance, super.key});
  final _findRideController = Get.find<FindRideController>();
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(centerTitle: false, title: 'Ride Details'),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          tripInfo(),
          const SizedBox(
            height: 10,
          ),
          driverDetailsAndCoPassengers(),
          // const Spacer(),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Obx(
          //           () => MyButton(
          //               buttonText: 'Book',
          //               showLoading: _findRideController.isBookLoading.value
          //                   ? true
          //                   : false,
          //               bgColor: kPrimaryColor,
          //               textColor: Colors.white,
          //               radius: 5,
          //               width: Get.width * 0.4,
          //               onTap: () async {
          //                 _findRideController.bookRide(request.requestId ?? '');
          //                 Get.to(() => const RideBookedSuccessfully());
          //               }),
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showSelectSeatsBottomSheet(request.availableSeats ?? 0);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => MyText(
                          text: _findRideController.numberOfSeats.value == 0
                              ? 'Select Seats'
                              : '${_findRideController.numberOfSeats.value} selected',
                          color: kTextColor4,
                          weight: FontWeight.w400,
                          size: 12,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
                Obx(
                  () => MyButton(
                      buttonText: 'Book',
                      showLoading: _findRideController.isBookLoading.value
                          ? true
                          : false,
                      bgColor: kPrimaryColor,
                      textColor: Colors.white,
                      radius: 5,
                      width: Get.width * 0.4,
                      onTap: () async {
                        if (_findRideController.numberOfSeats.value == 0) {
                          CustomSnackBars.instance.showFailureSnackbar(
                              title: 'Select Seats',
                              message: 'Select number of seats to continue');
                        } else {
                          _findRideController.bookRide(
                              requestId: request.requestId ?? '',
                              userId:
                                  _authController.userModel.value?.userId ?? '',
                              selectedSeats:
                                  _findRideController.numberOfSeats.value,
                              userName:
                                  _authController.userModel.value?.firstName ??
                                      '',
                              phoneNumber: _authController
                                      .userModel.value?.phoneNumber ??
                                  '');
                          Get.to(() => const RideBookedSuccessfully());
                        }
                      }),
                )
              ],
            ),
            MyText(
              text: 'Select a Seat',
              weight: FontWeight.w900,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }

  // void _launchDialer(String phoneNumber) async {
  //   log(phoneNumber);
  //   final url = 'tel:$phoneNumber';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  Container driverDetailsAndCoPassengers() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: Get.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(Assets.covidFree),
              const SizedBox(
                width: 10,
              ),
              MyText(
                text: 'Follow Covid 19 Safety Measures',
                size: 12,
                color: kPrimaryColor,
                weight: FontWeight.w700,
              )
            ],
          ),
          const Divider(
            color: kDarkGreyColor,
          ),
          ListTile(
            visualDensity: VisualDensity.comfortable,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              child: CommonImageView(
                fit: BoxFit.contain,
                radius: 20,
                imagePath: Assets.boyIcon,
              ),
            ),
            title: MyText(
              text: request.ownerName ?? 'Driver',
              size: 12,
              weight: FontWeight.w900,
              color: kTextColor,
            ),
            // subtitle: Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     MyText(
            //       text: '4.5',
            //       color: kGreyColor8,
            //       weight: FontWeight.w900,
            //       size: 12,
            //     ),
            //     const SizedBox(
            //       width: 5,
            //     ),
            //     const Icon(
            //       Icons.star,
            //       color: Colors.yellow,
            //       size: 15,
            //     ),
            //     const SizedBox(
            //       width: 5,
            //     ),
            //     MyText(
            //       text: '27 ratings',
            //       color: kGreyColor8,
            //       weight: FontWeight.w900,
            //       size: 12,
            //     ),
            //   ],
            // ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: kGreyColor8,
              size: 12,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(Assets.carpool),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: Get.width * 0.3,
                child: MyText(
                  text: request.vehicleName ?? '',
                  color: kGreyColor8,
                  size: 12,
                ),
              ),
              const Spacer(),
              // TextButton(
              //     onPressed: () => _launchDialer(
              //         request.ownerPhoneNumber ?? '+923209343053'),
              //     child: MyText(
              //       text: 'Contact Driver',
              //       color: kPrimaryColor,
              //       size: 12,
              //       weight: FontWeight.w600,
              //     ))
            ],
          ),
          const Divider(
            color: kDarkGreyColor,
          ),
          // MyText(
          //   text: 'Co-Passengers',
          //   color: kBlackColor,
          //   weight: FontWeight.bold,
          // ),
          // ListView.builder(
          //     itemCount: 2,
          //     shrinkWrap: true,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         contentPadding: EdgeInsets.zero,
          //         leading: const CircleAvatar(
          //           radius: 25,
          //           backgroundImage: AssetImage(Assets.boyIcon),
          //         ),
          //         title: MyText(
          //           text: 'Sher Ali ktk',
          //           color: kGreyColor8,
          //           size: 12,
          //         ),
          //         subtitle: MyText(
          //           text: 'Gurgoon -> Meerut',
          //           color: kGreyColor8,
          //           size: 12,
          //         ),
          //         trailing: const Icon(
          //           Icons.arrow_forward_ios,
          //           size: 15,
          //         ),
          //       );
          //     })
        ],
      ),
    );
  }

  Container tripInfo() {
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: 'Trip Info',
            color: kTextColor4,
            weight: FontWeight.w900,
            size: 12,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                size: 15,
              ),
              const SizedBox(
                width: 10,
              ),
              MyText(
                text: DateFormat('EEEE, d MMMM y, h:mm a')
                    .format(request.rideDate!),
                color: kGreyColor4,
                weight: FontWeight.w500,
                fontFamily: AppFonts.SYNE,
                size: 12,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // Row(
          //   children: [
          //     const Icon(
          //       Icons.schedule,
          //       size: 15,
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     MyText(
          //         text: '2 hr 45 minutes (Estimated)',
          //         color: kGreyColor4,
          //         weight: FontWeight.w500,
          //         size: 12,
          //         fontFamily: AppFonts.SYNE)
          //   ],
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          Row(
            children: [
              const Icon(
                Icons.route,
                size: 15,
              ),
              const SizedBox(
                width: 10,
              ),
              MyText(
                text: '${distance.toStringAsFixed(2)} km',
                size: 12,
                color: kGreyColor8,
                weight: FontWeight.w500,
              )
            ],
          ),
          const Divider(
            color: kDarkGreyColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const StepperLeadingIcon(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 5, horizontal: Get.width * 0.06),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 20,
                        child: CustomPaint(
                          painter: DashedLineVerticalPainter(),
                        ),
                      ),
                    ),
                  ),
                  const StepperLeadingIcon(),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              locationWidget(request),
            ],
          ),
          const Divider(
            color: kGreyColor8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: 'Seats left',
                size: 12,
                color: kGreyColor8,
              ),
              MyText(
                text: '${request.availableSeats ?? 0}',
                size: 12,
                color: kDarkGreyColor,
                weight: FontWeight.w800,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: 'Price for one seat ',
                color: kGreyColor8,
                size: 12,
              ),
              MyText(
                text: request.pricePerSeat ?? '0',
                color: kDarkGreyColor,
                size: 12,
                weight: FontWeight.w800,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: 'Pay via Cash (Card & Wallet Coming Soon!)',
                color: kGreyColor8,
                size: 12,
              ),
            ],
          )
        ],
      ),
    );
  }

  locationWidget(RideRequestModel request) {
    return InkWell(
      onTap: () {
        Get.to(() => GoogleMapRouteCustomer(
              startLoc: request.pickupLocation!,
              endLoc: request.dropoffLocation!,
              pickupAddress: request.pickupAddress ?? '',
              dropoffAddress: request.dropOfAddress ?? '',
              pricePerSeat: request.pricePerSeat ?? '50',
              rideDate: request.rideDate ?? DateTime.now(),
              publishedDate: request.publishDate ?? DateTime.now(),
              name: request.ownerName ?? 'Driver',
              vehicleName: request.vehicleName ?? 'Other Car',
              phoneNumber: request.ownerPhoneNumber ?? '+923211010101',
              customers: request.acceptedUsers,
              ownerId: request.ownerId,
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: Get.width * 0.7,
            child: MyText(
              size: 12,
              text: request.pickupAddress ?? '',
              color: kTextColor4,
              weight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: Get.width * 0.7,
            child: MyText(
              size: 12,
              text: request.dropOfAddress ?? '',
              color: kTextColor4,
              weight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class SelectSeat extends StatelessWidget {
  final int availableSeats;
  const SelectSeat({
    super.key,
    required this.availableSeats,
  });

  @override
  Widget build(BuildContext context) {
    final findRideController = Get.find<FindRideController>();

    return Container(
      height: Get.height * 0.6,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        color: kBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 15,
        ),
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: MyText(text: 'Close')),
                const Spacer(),
                Center(
                  child: MyText(
                    text: "Select Seats",
                    size: 18,
                    weight: FontWeight.w700,
                    fontFamily: AppFonts.DM_SANS,
                  ),
                ),
                const Spacer(
                  flex: 2,
                )
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 28,
            ),
            Obx(
              () => Row(
                children: [
                  incOrDecButton(
                    icon: const Center(
                        child: Icon(
                      Icons.remove,
                      color: kPrimaryColor,
                    )),
                    onTap: () {
                      findRideController.decrementSeats();
                    },
                  ),
                  const Spacer(),
                  MyText(
                    text: findRideController.numberOfSeats.toString(),
                    size: 20,
                    color: kBlackColor,
                    weight: FontWeight.w900,
                  ),
                  const Spacer(),
                  incOrDecButton(
                    icon: const Icon(
                      Icons.add,
                      color: kPrimaryColor,
                    ),
                    onTap: () {
                      findRideController.incrementSeats(availableSeats);
                    },
                  ),
                ],
              ),
            ),
            RotatedBox(
                quarterTurns: 5,
                child: Image.asset(
                  Assets.car,
                  height: 100,
                )),
            MyButton(
                radius: 5,
                buttonText: 'Confirm Seats',
                textColor: Colors.white,
                bgColor: kPrimaryColor,
                onTap: () {
                  Get.back();
                })
          ],
        ),
      ),
    );
  }

  incOrDecButton({Widget? icon, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: kPrimaryColor,
        child: CircleAvatar(
            backgroundColor: Colors.white, radius: 18, child: icon),
      ),
    );
  }
}

void showSelectSeatsBottomSheet(int availableSeats) {
  showModalBottomSheet<void>(
    context: Get.context!,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SelectSeat(availableSeats: availableSeats),
      );
    },
  );
}
