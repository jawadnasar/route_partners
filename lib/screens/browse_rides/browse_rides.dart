import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/controllers/find_ride_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/constants/firebase_collection_references.dart';
import 'package:route_partners/model/ride_request_model.dart';
import 'package:route_partners/screens/ride_details/ride_details.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class BrowseRides extends StatefulWidget {
  const BrowseRides({super.key});

  @override
  State<BrowseRides> createState() => _BrowseRidesState();
}

class _BrowseRidesState extends State<BrowseRides>
    with TickerProviderStateMixin {
  TabController? controller;
  final _findRideController = Get.find<FindRideController>();
  final _authController = Get.find<AuthController>();
  bool isLoading = true;
  bool delayHandled = false;
  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
          leadingIconColor: kWhiteColor2,
          bgColor: kPrimaryColor,
          titleColor: kWhiteColor2,
          title: 'Rides'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder(
            stream: _findRideController.getRideRequestsStream(),
            builder: (context, snapshot) {
              log('rebuilding');
              if (snapshot.connectionState == ConnectionState.waiting ||
                  isLoading) {
                if (!delayHandled) {
                  delayHandled = true;
                  Future.delayed(const Duration(seconds: 2)).then(
                    (_) {
                      if (mounted) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  );
                }
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        Assets.lottieAnimation,
                        height: 200,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(height: 5),
                      MyText(
                        text: 'Searching nearby rides',
                        color: kGreyColor8,
                      ),
                    ],
                  ),
                );
              } else if (!snapshot.hasData) {
                return Center(child: MyText(text: 'No Available Rides'));
              }
              List<RideRequestModel> requests = [];
              List<RideRequestModel> filteredRequests = [];

              snapshot.data?.docs.forEach(
                (doc) {
                  final Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  requests.add(RideRequestModel.fromMap(data));
                },
              );
              for (var request in requests) {
                RxDouble rideDistance = 0.0.obs;
                rideDistance.value = Geolocator.distanceBetween(
                        request.pickupLocation!.latitude,
                        request.pickupLocation!.longitude,
                        request.dropoffLocation!.latitude,
                        request.dropoffLocation!.longitude) /
                    1000;
                RxDouble distanceToPickup = 0.0.obs;
                distanceToPickup.value = Geolocator.distanceBetween(
                      _authController.userModel.value!.latLng!.latitude,
                      _authController.userModel.value!.latLng!.longitude,
                      request.pickupLocation!.latitude,
                      request.pickupLocation!.longitude,
                    ) /
                    1000;
                request.routeDistance = rideDistance.value;
                request.distanceToPickup = distanceToPickup.value;
                if (request.distanceToPickup! < 5) {
                  filteredRequests.add(request);
                }
                log(distanceToPickup.value.toString());
              }
              return filteredRequests.isEmpty
                  ? Center(child: MyText(text: 'No Available Rides'))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                          labelColor: kPrimaryColor,
                          labelStyle: const TextStyle(color: kPrimaryColor),
                          indicatorWeight: 3.0,
                          dividerColor: kGreyColor8,
                          indicatorPadding: const EdgeInsets.all(0),
                          dividerHeight: 20,
                          isScrollable: true,
                          controller: controller,
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Departure',
                                style: TextStyle(color: kGreyColor8),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Price',
                                style: TextStyle(color: kGreyColor8),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Ratings',
                                style: TextStyle(color: kGreyColor8),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Seat Availability',
                                style: TextStyle(color: kGreyColor8),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Showing results',
                          style: TextStyle(color: kGreyColor8),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          child: ListView.builder(
                              itemCount: filteredRequests.length,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => RideDetails(
                                          request: filteredRequests[index],
                                          distance: filteredRequests[index]
                                                  .routeDistance ??
                                              0.0,
                                        ));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: MyText(
                                                text:
                                                    '${filteredRequests[index].pickupAddress} ➡️ ${filteredRequests[index].dropOfAddress}',
                                                color: kTextColor,
                                                size: 12,
                                                weight: FontWeight.w700,
                                              ),
                                            ),
                                            MyText(
                                              text: filteredRequests[index]
                                                      .pricePerSeat ??
                                                  '0',
                                              color: kTextColor,
                                              size: 12,
                                              weight: FontWeight.w700,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            MyText(
                                              text: DateFormat('d MMMM, h:mm a')
                                                  .format(
                                                      filteredRequests[index]
                                                              .rideDate ??
                                                          DateTime.now()),
                                              size: 12,
                                              color: kGreyColor8,
                                              weight: FontWeight.w900,
                                            ),
                                            MyText(
                                              text:
                                                  '${filteredRequests[index].availableSeats} Seats',
                                              size: 12,
                                              color: kGreyColor8,
                                              weight: FontWeight.w900,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        Row(
                                          children: [
                                            // const FaIcon(
                                            //   FontAwesomeIcons.person,
                                            //   size: 10,
                                            //   color: kGreenColor,
                                            // ),
                                            // const SizedBox(
                                            //   width: 5,
                                            // ),
                                            // MyText(
                                            //   text: '6 km',
                                            //   size: 12,
                                            //   color: kGreyColor8,
                                            // ),
                                            // const SizedBox(
                                            //   width: 5,
                                            // ),
                                            // const Icon(
                                            //   Icons.arrow_forward_ios,
                                            //   size: 10,
                                            //   color: kGreyColor8,
                                            // ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const FaIcon(
                                              FontAwesomeIcons.car,
                                              size: 10,
                                              color: kGreyColor8,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 10,
                                              color: kGreyColor8,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            MyText(
                                              text:
                                                  '${filteredRequests[index].routeDistance?.toStringAsFixed(2) ?? '0'} km',
                                              color: kGreyColor8,
                                              size: 12,
                                            ),

                                            // const SizedBox(
                                            //   width: 5,
                                            // ),
                                            // const FaIcon(
                                            //   FontAwesomeIcons.person,
                                            //   size: 10,
                                            //   color: Colors.yellow,
                                            // ),
                                          ],
                                        ),
                                        const Divider(
                                          color: kGreyColor8,
                                        ),
                                        DriverProfileDetails(
                                          title: filteredRequests[index]
                                                  .ownerName ??
                                              'Driver',
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    );
            }),
      ),
    );
  }
}

class DriverProfileDetails extends StatelessWidget {
  String title;
  DriverProfileDetails({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.comfortable,
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage(Assets.boyIcon),
      ),
      title: MyText(
        text: title,
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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Assets.covidFree),
          const SizedBox(
            width: 10,
          ),
          const FaIcon(FontAwesomeIcons.bolt),
          const SizedBox(
            width: 10,
          ),
          Image.asset(Assets.travelbag)
        ],
      ),
    );
  }
}
