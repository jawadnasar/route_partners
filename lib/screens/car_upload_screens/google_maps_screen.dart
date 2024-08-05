import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:route_partners/controllers/address_controller.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';

class CarLocationScreen extends StatefulWidget {
  const CarLocationScreen(
      {this.controller, this.latController, this.lngController, super.key});
  final TextEditingController? controller;
  final TextEditingController? latController;
  final TextEditingController? lngController;

  @override
  State<CarLocationScreen> createState() => _CarLocationScreenState();
}

class _CarLocationScreenState extends State<CarLocationScreen> {
  Completer<GoogleMapController> mapController = Completer();

  String? selectedRoute = 'Islamabad Highway';
  @override
  void initState() {
    AddressController.i.getcurrentLocation().then((value) {
      AddressController.i.latitude = value.latitude;
      AddressController.i.longitude = value.longitude;
      AddressController.i.initialAddress(value.latitude, value.longitude);
      log('latitude: ${AddressController.i.latitude} , longitude ${AddressController.i.longitude}');
      widget.latController?.text = AddressController.i.latitude.toString();
      widget.lngController?.text = AddressController.i.longitude.toString();
      log('Address : ${AddressController.address}');
      log('Address : ${AddressController.i.latitude.toString()}');
      log('Address : ${AddressController.i.longitude.toString()}');
      AddressController.i.controller.text = AddressController.address!;
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
      body: Padding(
        padding: AppSizes.DEFAULT,
        child: Column(
          children: [
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
                                  await mapController.future;

                              controller.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      zoom: 14,
                                      target: LatLng(argument.latitude,
                                          argument.longitude))));
                              AddressController.i.controller.text =
                                  AddressController.address!;
                              // widget.controller?.text = AddressController.i.controller.text;
                              // log(AddressController.i.currentLocation
                              //         .toString() +
                              //     'hahah');
                              // log('ARG LAT : ${argument.latitude}');
                              // log('ARG LNG : ${argument.longitude}');

                              List<Placemark>? placemark =
                                  await placemarkFromCoordinates(
                                argument.latitude,
                                argument.longitude,
                              );

                              address.updateAddress(
                                  '${placemark[0].subLocality} ${placemark[0].locality} ${placemark[0].country} ${placemark[0].street} ${placemark[0].postalCode}');
                              log(AddressController.address.toString());
                              address.currentLocation =
                                  await locationFromAddress(
                                      AddressController.address!);
                              widget.controller?.text =
                                  AddressController.address!;
                              widget.latController?.text = AddressController
                                  .i.currentLocation!.last.latitude
                                  .toString();
                              widget.lngController?.text = AddressController
                                  .i.currentLocation!.last.longitude
                                  .toString();
                              log('Address : ${widget.controller!.text.toString()}');
                              log('LAT : ${widget.latController?.text}');
                              log('LNG : ${widget.lngController?.text}');
                            },
                            initialCameraPosition: CameraPosition(
                                target: LatLng(AddressController.i.latitude!,
                                    AddressController.i.longitude!),
                                zoom: 14),
                            mapType: MapType.normal,
                            markers: Set.of(AddressController.i.markers),
                            onMapCreated: (controller) {
                              mapController.complete(controller);
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
                              controller: widget.controller,
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
                            var data = address.currentPlaceList[index];
                            return InkWell(
                              onTap: () async {
                                final selectedPlace = address
                                    .currentPlaceList[index]['description'];
                                if (selectedPlace != null) {
                                  final locations =
                                      await locationFromAddress(selectedPlace);
                                  setState(() {
                                    address.currentPlaceList.clear();
                                    address.markers.clear();
                                  });
                                  widget.controller?.text = selectedPlace;
                                  GoogleMapController controller =
                                      await mapController.future;
                                  controller.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                              zoom: 10,
                                              target: LatLng(
                                                  locations.last.latitude,
                                                  locations.last.longitude))));
                                  address.markers.add(Marker(
                                      infoWindow: const InfoWindow(
                                          title: 'Current Location',
                                          snippet:
                                              'This is my current Location'),
                                      position: LatLng(locations.last.latitude,
                                          locations.last.longitude),
                                      markerId: const MarkerId('1')));
                                  List<Placemark>? placemark =
                                      await placemarkFromCoordinates(
                                          address
                                              .currentLocation!.last.latitude,
                                          address
                                              .currentLocation!.last.longitude);
                                  address.updateAddress(
                                      '${placemark[0].country} ${placemark[0].subLocality} ${placemark[0].locality} ${placemark[0].street} ${placemark[0].postalCode} ${placemark[0].administrativeArea} ${placemark[0].subAdministrativeArea} ${placemark[0].country}');
                                  // widget.controller?.text =
                                  //     AddressController.address!;
                                  
                                  widget.latController?.text =
                                      locations.last.latitude.toString();
                                  widget.lngController?.text =
                                      locations.last.longitude.toString();
                                  log('Address : ${widget.controller!.text}');
                                  log('LAT : ${widget.latController?.text}');
                                  log('LNG : ${widget.lngController?.text}');

                                  FocusManager.instance.primaryFocus?.unfocus();
                                }

                                // log(AddressController.i.currentLocation
                                //     .toString());

                                log(" hello world : ${AddressController.address.toString()}");
                                address.currentLocation =
                                    await locationFromAddress(
                                        AddressController.address!);
                                // CameraUpdate.newCameraPosition(CameraPosition(
                                //     zoom: 10,
                                //     target: LatLng(
                                //         address.currentLocation!.reversed.last
                                //             .latitude,
                                //         address.currentLocation!.reversed.last
                                //             .longitude)));

                                setState(() {});
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
          ],
        ),
      ),
    );
  }
}
