import 'dart:async';
import 'dart:developer' as pr;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/controllers/chat_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/model/ride_request_model.dart';
import 'package:route_partners/screens/chat_screens/chat_screen.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMapRouteCustomer extends StatefulWidget {
  const GoogleMapRouteCustomer(
      {required this.startLoc,
      required this.endLoc,
      // required this.request,
      required this.pickupAddress,
      required this.dropoffAddress,
      required this.pricePerSeat,
      required this.rideDate,
      required this.publishedDate,
      this.name,
      required this.vehicleName,
      this.phoneNumber,
      this.customers,
      this.ownerId,
      super.key});
  final GeoPoint startLoc;
  final GeoPoint endLoc;
  // final RideRequestModel request;
  final String pickupAddress;
  final String dropoffAddress;
  final String pricePerSeat;
  final DateTime rideDate;
  final DateTime publishedDate;
  final String? name;
  final String vehicleName;
  final String? phoneNumber;
  final String? ownerId;

  final List<AcceptedUser>? customers;

  @override
  State<GoogleMapRouteCustomer> createState() => _GoogleMapRouteCustomerState();
}

class _GoogleMapRouteCustomerState extends State<GoogleMapRouteCustomer> {
  late GoogleMapController googleMapController;
  final Completer<GoogleMapController> completer = Completer();
  List<Marker> markers = [];
  // final Set<Polyline> _polyline = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  final _chatController = Get.find<ChatController>();
  final _authController = Get.find<AuthController>();
  int randomNumber = 0;
  @override
  void initState() {
    super.initState();
    pr.log(_authController.userModel.value!.interests!.toList().toString());
    Random random = Random();
    for (int i = 0; i < 2; i++) {
      if (_authController.userModel.value!.interests!.isNotEmpty) {
        randomNumber = 0 +
            random.nextInt(
                (_authController.userModel.value!.interests!.length - 1) -
                    0 +
                    1);
      }
    }
    markers = [
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(widget.startLoc.latitude, widget.startLoc.longitude),
      ),
      Marker(
        markerId: const MarkerId('2'),
        position: LatLng(widget.endLoc.latitude, widget.endLoc.longitude),
      ),
    ];
    // _polyline.add(
    //   Polyline(
    //       polylineId: const PolylineId('1'),
    //       visible: true,
    //       points: widget.latlng,
    //       color: kPrimaryColor),
    // );
    Future.delayed(Duration.zero).then(
      (_) async {
        await getDirections();
      },
    );
  }

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    if (!completer.isCompleted) {
      completer.complete(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            trafficEnabled: true,
            onMapCreated: onMapCreated,
            // polylines: _polyline,
            markers: markers.toSet(),
            polylines: Set<Polyline>.of(polylines.values),
            initialCameraPosition: CameraPosition(
              target:
                  LatLng(widget.startLoc.latitude, widget.startLoc.longitude),
              zoom: 15.0,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Material(
              elevation: 20,
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SizedBox(
                height: Get.height * 0.45,
                width: Get.width,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: MyText(
                          text: 'Driver Info',
                          size: 18,
                          weight: FontWeight.bold,
                          paddingBottom: 20,
                        ),
                      ),
                    ),
                    _authController.userModel.value!.interests!.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: MyText(
                              text: 'No interest selcted',
                              color: kDarkGreyColor,
                              weight: FontWeight.w900,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: MyText(
                              text:
                                  'Showing route with ${_authController.userModel.value?.interests?[randomNumber]}',
                              color: kPrimaryColor,
                              weight: FontWeight.w900,
                            ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MyText(
                        text:
                            '${widget.pickupAddress} ➡️ ${widget.dropoffAddress}',
                        color: kDarkGreyColor,
                        weight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MyText(
                        text: '${widget.pricePerSeat} per seat',
                        color: kDarkGreyColor,
                        weight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month),
                          const SizedBox(
                            width: 5,
                          ),
                          MyText(
                            text: DateFormat('d MMMM, h:mm a')
                                .format(widget.rideDate),
                            color: kGreyColor3,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MyText(
                        text:
                            'Published on ${DateFormat('d MMMM, h:mm a').format(widget.publishedDate)}',
                        color: kGreyColor3,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListTile(
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
                          text: widget.name ?? '',
                          color: kBlackColor,
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(Assets.carpool),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: Get.width * 0.3,
                            child: MyText(
                              text: widget.vehicleName,
                              color: kGreyColor8,
                              size: 12,
                            ),
                          ),
                          const Spacer(),
                          // TextButton(
                          //     onPressed: () =>
                          //         _launchDialer(widget.phoneNumber ?? ''),
                          //     child: MyText(
                          //       text: 'Contact Driver',
                          //       color: kPrimaryColor,
                          //       size: 12,
                          //       weight: FontWeight.w600,
                          //     ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: widget.customers!.isEmpty
                          ? Center(
                              child: MyText(
                                text: 'No other users yet',
                                paddingTop: 20,
                                paddingBottom: 20,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.customers?.length ?? 0,
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
                                    text: widget.customers?[index].name ?? '',
                                    color: kBlackColor,
                                  ),
                                  // trailing: Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   children: [
                                  //     GestureDetector(
                                  //       onTap: () async {
                                  //         final ref = await _chatController
                                  //             .getOrCreateChat(
                                  //                 widget.ownerId ?? '',
                                  //                 widget.customers?[index].id ??
                                  //                     '');

                                  //         Get.to(() => ChatScreen(
                                  //             chatId: ref.id,
                                  //             currentUserId: _authController
                                  //                 .userModel.value!.userId!));
                                  //       },
                                  //       child: const Icon(
                                  //         Icons.chat,
                                  //         color: kPrimaryColor,
                                  //       ),
                                  //     ),
                                  //     const SizedBox(width: 10),
                                  //     GestureDetector(
                                  //       onTap: () => _launchDialer(widget
                                  //               .customers?[index]
                                  //               .phoneNumber ??
                                  //           ''),
                                  //       child: const Icon(
                                  //         Icons.phone,
                                  //         color: kPrimaryColor,
                                  //       ),
                                  //     ),
                                  //     const SizedBox(width: 20),
                                  //   ],
                                  // ),
                                );
                              },
                            ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // void _launchDialer(String phoneNumber) async {
  //   final url = 'tel:$phoneNumber';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];
    List<PolylineWayPoint> polylineWayPoints = [];
    polylineWayPoints.add(PolylineWayPoint(
        location:
            "${widget.startLoc.latitude.toString()},${widget.startLoc.longitude.toString()}",
        stopOver: true));

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: "AIzaSyDugTw8Ej3isRtP1ghNonwM1r7qV51gs1I",
      request: PolylineRequest(
        origin:
            PointLatLng(widget.startLoc.latitude, widget.startLoc.longitude),
        destination:
            PointLatLng(widget.endLoc.latitude, widget.endLoc.longitude),
        mode: TravelMode.driving,
      ),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {}

    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: kPrimaryColor,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
    setState(() {});
  }
}
