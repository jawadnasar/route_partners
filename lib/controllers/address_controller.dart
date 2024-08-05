// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/**
  * This class controls the address (reseting, updating, current location) calling in the app
 */

class AddressController extends GetxController implements GetxService {
  double? latitude;
  double? longitude;
  late TextEditingController controller;

  List<dynamic> currentPlaceList = [];
  List<Location>? currentLocation = [];
  static String? _address;
  static String? get address => _address;
  String sessionTOKEN = '1223344';

  /* Reseting the current address when called */
  resetAddress() {
    _address = null;
    latitude = null;
    longitude = null;
    update();
  }

  /* Making changes to the address and take the pointer to the new address */
  updateAddress(String value) {
    _address = value;
    if (value == '') {
      longitude = null;
      latitude = null;
    }
    update();
  }

  /**
    * Getting the current location of the user
    * This will ask for permission for getting the location of the use for the first time
   */
  Future<Position> getcurrentLocation() async {
    await Geolocator.requestPermission().then((value) {});
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  getSuggestion(String query) async {
    String kPLACES_API_KEY = 'AIzaSyDSsTtjvdKipkgZ4s0zYp2tMRVQlAfHsKA';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$query&key=$kPLACES_API_KEY&sessiontoken=$sessionTOKEN';
    var response = await http.get(Uri.parse(request));
    log(response.body);
    try {
      if (response.statusCode == 200) {
        log('here i am');
        currentPlaceList = jsonDecode(response.body.toString())['predictions'];
        log(currentPlaceList.toString());
        update();
      } else {
        log('some error');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void onQueryChanged(String query) {
    getSuggestion(query);
    update();
  }

  List<Marker> markers = [];

  @override
  void onInit() {
    controller = TextEditingController();
    // getcurrentLocation().then((value) {
    //   latitude = value.latitude;
    //   longitude = value.longitude;

    //   initialAddress(value.latitude, value.longitude);
    //   log('latitude: $latitude , longitude $longitude');
    // });

    super.onInit();
  }

  /** 
    * Geeting the address of the user and updating it accordingly
   */
  initialAddress(double latitudee, double longitudee) async {
    List<Placemark>? placemark =
        await placemarkFromCoordinates(latitudee, longitudee);
        // Calling by address or postal code
    updateAddress(
        '${placemark[0].subLocality} ${placemark[0].locality} ${placemark[0].country} ${placemark[0].street} ${placemark[0].postalCode}');

    onClose() {}
  }

  static AddressController get i => Get.put(AddressController());
}
