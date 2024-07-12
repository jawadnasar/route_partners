import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:route_partners/controllers/address_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({ this.controller, super.key});
  final TextEditingController? controller;

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  String? selectedRoute = 'Islamabad Highway';
  @override
  void initState() {
    AddressController.i.getcurrentLocation().then((value) {
      AddressController.i.latitude = value.latitude;
      AddressController.i.longitude = value.longitude;
      AddressController.i.initialAddress(value.latitude, value.longitude);
      log('latitude: ${AddressController.i.latitude} , longitude ${AddressController.i.longitude}');
      AddressController.i.markers.clear();
      AddressController.i.markers.add(Marker(
          infoWindow: const InfoWindow(
              title: 'Current Location',
              snippet: 'This is my current Location'),
          position: LatLng(
              AddressController.i.latitude!, AddressController.i.longitude!),
          markerId: const MarkerId('1')));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: simpleAppBar(
            title: 'Select a Route',
          )),
      body: Padding(
        padding: AppSizes.DEFAULT,
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            Stack(
              children: [
                SizedBox(
                  height: Get.height * 0.5,
                  child: GetBuilder<AddressController>(builder: (address) {
                    return address.latitude != null && address.longitude != null
                        ? GoogleMap(
                            // myLocationEnabled: true,
                            onTap: (argument) async {
                              setState(() {
                                address.markers.clear();
                                address.markers.add(Marker(
                                    infoWindow: const InfoWindow(
                                        title: 'Current Location',
                                        snippet: 'This is my current Location'),
                                    position: LatLng(
                                        argument.latitude, argument.longitude),
                                    markerId: const MarkerId('1')));
                                address.currentPlaceList.clear();
                              });
                              GoogleMapController controller =
                                  await AddressController
                                      .i.mapController.future;

                              controller.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      zoom: 14,
                                      target: LatLng(argument.latitude,
                                          argument.longitude))));
                              log(AddressController.i.currentLocation
                                  .toString());

                              List<Placemark>? placemark =
                                  await placemarkFromCoordinates(
                                argument.latitude,
                                argument.longitude,
                              );

                              address.updateAddress(
                                  '${placemark[0].subLocality} ${placemark[0].locality} ${placemark[0].country} ${placemark[0].street}');
                              log(AddressController.address.toString());
                              address.currentLocation =
                                  await locationFromAddress(
                                      AddressController.address!);
                              widget.controller?.text =
                                  AddressController.address!;
                            },
                            initialCameraPosition: CameraPosition(
                                target: LatLng(AddressController.i.latitude!,
                                    AddressController.i.longitude!),
                                zoom: 14),
                            mapType: MapType.normal,
                            markers: Set.of(AddressController.i.markers),
                            onMapCreated: (controller) {
                              AddressController.i.mapController
                                  .complete(controller);
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  }),
                ),
                Column(
                  children: [
                    GetBuilder<AddressController>(builder: (cont) {
                      return Row(
                        children: [
                          Expanded(
                            child: MyTextField(
                              filled: true,
                              fillColor: Colors.white,
                              controller: cont.controller,
                              onChanged: (value) {
                                log(value.toString());
                                setState(() {
                                  AddressController.i.getSuggestion(value);
                                });
                              },
                              hintText: 'Search ',
                            ),
                          ),
                        ],
                      );
                    }),
                    GetBuilder<AddressController>(builder: (address) {
                      return ListView.builder(
                          itemCount: address.currentPlaceList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                if (address.currentPlaceList.isNotEmpty) {
                                  address.currentLocation =
                                      await locationFromAddress(
                                          address.currentPlaceList[index]
                                              ['description']);
                                }

                                setState(() {
                                  address.currentPlaceList.clear();
                                  address.markers.clear();
                                  address.markers.add(Marker(
                                      infoWindow: const InfoWindow(
                                          title: 'Current Location',
                                          snippet:
                                              'This is my current Location'),
                                      position: LatLng(
                                          address.currentLocation!.reversed.last
                                              .latitude,
                                          address.currentLocation!.reversed.last
                                              .longitude),
                                      markerId: const MarkerId('1')));
                                });

                                GoogleMapController controller =
                                    await AddressController
                                        .i.mapController.future;
                                controller.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            zoom: 10,
                                            target: LatLng(
                                                AddressController
                                                    .i
                                                    .currentLocation!
                                                    .reversed
                                                    .last
                                                    .latitude,
                                                AddressController
                                                    .i
                                                    .currentLocation!
                                                    .reversed
                                                    .last
                                                    .longitude))));
                                log(AddressController.i.currentLocation
                                    .toString());

                                List<Placemark>? placemark =
                                    await placemarkFromCoordinates(
                                        address.currentLocation!.last.latitude,
                                        address
                                            .currentLocation!.last.longitude);

                                address.updateAddress(
                                    '${placemark[0].subLocality} ${placemark[0].locality} ${placemark[0].country} ${placemark[0].street}');
                                log(AddressController.address.toString());
                                address.currentLocation =
                                    await locationFromAddress(
                                        AddressController.address!);
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    zoom: 10,
                                    target: LatLng(
                                        address.currentLocation!.reversed.last
                                            .latitude,
                                        address.currentLocation!.reversed.last
                                            .longitude)));
                                widget.controller?.text =
                                    AddressController.address!;
                              },
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AddressController.i.currentPlaceList[index]
                                        ['description'],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
                  ],
                ),
              ],
            ),
            // const Spacer(),
            // ListView.builder(
            //   itemCount: 2,
            //   shrinkWrap: true,
            //   itemBuilder: (context, index) {
            //     List<String> genders = ['Islamabad Highway', '9th Avenue'];
            //     return RadioListTile<String>(
            //       title: MyText(text: genders[index]),
            //       controlAffinity: ListTileControlAffinity.trailing,
            //       value: genders[index],
            //       groupValue: selectedRoute,
            //       onChanged: (value) {
            //         setState(() {
            //           selectedRoute = value;
            //         });
            //       },
            //     );
            //   },
            // ),
            const SizedBox(
              height: 50,
            ),
            MyButton(
                textSize: 14,
                buttonText: 'PROCEED',
                weight: FontWeight.w900,
                onTap: () async {
                  // Get.to(() => const PublishRideScreen());
                  Get.back();
                },
                bgColor: kPrimaryColor,
                textColor: Colors.white)
          ],
        ),
      ),
    );
  }
}
