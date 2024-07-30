import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/model/ride_request_model.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMapRoute extends StatefulWidget {
  const GoogleMapRoute(
      {required this.startLoc,
      required this.endLoc,
      // required this.request,
      required this.pickupAddress,
      required this.dropoffAddress,
      required this.pricePerSeat,
      required this.rideDate,
      required this.publishedDate,
      required this.name,
      required this.vehicleName,
      required this.phoneNumber,
      required this.isCustomerInfo,
      super.key});
  final GeoPoint startLoc;
  final GeoPoint endLoc;
  // final RideRequestModel request;
  final String pickupAddress;
  final String dropoffAddress;
  final String pricePerSeat;
  final DateTime rideDate;
  final DateTime publishedDate;
  final String name;
  final String vehicleName;
  final String phoneNumber;
  final bool isCustomerInfo;

  @override
  State<GoogleMapRoute> createState() => _GoogleMapRouteState();
}

class _GoogleMapRouteState extends State<GoogleMapRoute> {
  late GoogleMapController googleMapController;
  final Completer<GoogleMapController> completer = Completer();
  List<Marker> markers = [];
  // final Set<Polyline> _polyline = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  @override
  void initState() {
    super.initState();
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
                          text: widget.isCustomerInfo
                              ? 'Customer Info'
                              : 'Driver Info',
                          size: 18,
                          weight: FontWeight.bold,
                          paddingBottom: 20,
                        ),
                      ),
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
                          text: widget.name,
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
                          TextButton(
                              onPressed: () =>
                                  _launchDialer(widget.phoneNumber),
                              child: MyText(
                                text: 'Contact Driver',
                                color: kPrimaryColor,
                                size: 12,
                                weight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _launchDialer(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
    } else {
      log(result.errorMessage.toString());
    }

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
