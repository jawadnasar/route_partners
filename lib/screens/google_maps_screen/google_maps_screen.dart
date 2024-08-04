import 'dart:async';
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
  const GoogleMapsScreen(
      {this.controller, this.latController, this.lngController, super.key});
  final TextEditingController? controller;
  final TextEditingController? latController;
  final TextEditingController? lngController;

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  String? selectedRoute = 'Islamabad Highway';
  Completer<GoogleMapController> mapController = Completer();

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    final currentLocation = await AddressController.i.getcurrentLocation();
    AddressController.i.latitude = currentLocation.latitude;
    AddressController.i.longitude = currentLocation.longitude;
    AddressController.i
        .initialAddress(currentLocation.latitude, currentLocation.longitude);

    log('latitude: ${AddressController.i.latitude} , longitude: ${AddressController.i.longitude}');

    widget.controller?.text = AddressController.address!;
    widget.latController?.text = AddressController.i.latitude.toString();
    widget.lngController?.text = AddressController.i.longitude.toString();
    AddressController.i.controller.text = AddressController.address!;

    log('Address: ${AddressController.address}');
    log('Latitude: ${AddressController.i.latitude}');
    log('Longitude: ${AddressController.i.longitude}');

    setState(() {
      AddressController.i.markers.clear();
      AddressController.i.markers.add(Marker(
        infoWindow: const InfoWindow(
          title: 'Current Location',
          snippet: 'This is my current Location',
        ),
        position: LatLng(
            AddressController.i.latitude!, AddressController.i.longitude!),
        markerId: const MarkerId('1'),
      ));
    });

    final controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(
            AddressController.i.latitude!, AddressController.i.longitude!),
        zoom: 14,
      ),
    ));
  }

  Future<Function(LatLng)?> _onMapTap(LatLng position) async {
    setState(() {
      AddressController.i.markers.clear();
      AddressController.i.markers.add(Marker(
        infoWindow: const InfoWindow(
          title: 'Selected Location',
          snippet: 'This is the selected Location',
        ),
        position: position,
        markerId: const MarkerId('1'),
      ));
    });

    try {
      final controller = await mapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 14,
          target: LatLng(position.latitude, position.longitude),
        ),
      ));
    } catch (e) {
      log(e.toString());
    }

    final placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    AddressController.i.updateAddress(
      '${placemark[0].subLocality} ${placemark[0].locality} ${placemark[0].country} ${placemark[0].street}  ${placemark[0].postalCode}',
    );

    widget.controller?.text = AddressController.address!;
    widget.latController?.text = position.latitude.toString();
    widget.lngController?.text = position.longitude.toString();
    AddressController.i.controller.text = AddressController.address!;

    log('Address: ${widget.controller?.text}');
    log('Latitude: ${widget.latController?.text}');
    log('Longitude: ${widget.lngController?.text}');
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: simpleAppBar(title: 'Select a Route'),
      ),
      body: Padding(
        padding: AppSizes.DEFAULT,
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.02),
            Stack(
              children: [
                SizedBox(
                  height: Get.height * 0.5,
                  child: GetBuilder<AddressController>(
                    builder: (address) {
                      return address.latitude != null &&
                              address.longitude != null
                          ? GoogleMap(
                              onTap: _onMapTap,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(AddressController.i.latitude!,
                                    AddressController.i.longitude!),
                                zoom: 14,
                              ),
                              mapType: MapType.normal,
                              markers: Set.of(AddressController.i.markers),
                              onMapCreated: (controller) =>
                                  mapController.complete(controller),
                            )
                          : const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                Column(
                  children: [
                    GetBuilder<AddressController>(
                      builder: (cont) {
                        return Row(
                          children: [
                            Expanded(
                              child: MyTextField(
                                filled: true,
                                fillColor: Colors.white,
                                controller: cont.controller,
                                onChanged: (value) {
                                  log(value);
                                  AddressController.i.getSuggestion(value);
                                },
                                hintText: 'Search',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    GetBuilder<AddressController>(
                      builder: (address) {
                        return ListView.builder(
                          itemCount: address.currentPlaceList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                final selectedPlace = address
                                    .currentPlaceList[index]['description'];
                                if (selectedPlace != null) {
                                  final locations =
                                      await locationFromAddress(selectedPlace);
                                  if (locations.isNotEmpty) {
                                    final newLocation = locations.first;

                                    setState(() {
                                      address.currentPlaceList.clear();
                                      address.markers.clear();
                                      address.markers.add(Marker(
                                        infoWindow: const InfoWindow(
                                          title: 'Selected Location',
                                          snippet:
                                              'This is the selected Location',
                                        ),
                                        position: LatLng(newLocation.latitude,
                                            newLocation.longitude),
                                        markerId: const MarkerId('1'),
                                      ));
                                    });
                                    AddressController.i.controller.text = selectedPlace;
                                    final controller =
                                        await mapController.future;
                                    controller.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        zoom: 14,
                                        target: LatLng(newLocation.latitude,
                                            newLocation.longitude),
                                      ),
                                    ));

                                    final placemark =
                                        await placemarkFromCoordinates(
                                            newLocation.latitude,
                                            newLocation.longitude);
                                    address.updateAddress(
                                      '${placemark[0].subLocality} ${placemark[0].locality} ${placemark[0].country} ${placemark[0].street}',
                                    );

                                    widget.controller?.text =
                                        AddressController.address!;
                                    widget.latController?.text =
                                        newLocation.latitude.toString();
                                    widget.lngController?.text =
                                        newLocation.longitude.toString();

                                    log('Address: ${AddressController.address}');
                                    log('Latitude: ${widget.latController?.text}');
                                    log('Longitude: ${widget.lngController?.text}');
                                    FocusManager.instance.primaryFocus?.unfocus();

                                  }
                                }
                              },
                              child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AddressController.i.currentPlaceList[index]
                                      ['description']!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            MyButton(
              textSize: 14,
              buttonText: 'PROCEED',
              weight: FontWeight.w900,
              onTap: () => Get.back(),
              bgColor: kPrimaryColor,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
