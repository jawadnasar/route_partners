import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/core/constants/firebase_collection_references.dart';
import 'package:route_partners/model/ride_request_model.dart';
import 'package:route_partners/services/firebase/firebase_crud.dart';
import 'package:uuid/uuid.dart';

class CreateRideController extends GetxController {
  final _firebaseCRUDService = FirebaseCRUDService.instance;
  final _authController = Get.find<AuthController>();
  var rideRequest = Rx<RideRequestModel?>(null);
  RxString selectedSeatPrice = '50'.obs;
  RxString selectedSeats = '1'.obs;
  var selectedDate = DateTime.now().obs;
  final vehicleNameController = TextEditingController();
  final luggageController = TextEditingController();
  final pickupLocationController = TextEditingController();
  final dropoffLocationController = TextEditingController();
  final noteController = TextEditingController();
  final pickupLatController = TextEditingController();
  final pickupLngController = TextEditingController();
  final dropoffLatController = TextEditingController();
  final dropoffLngController = TextEditingController();
  RxBool isCreatingLoading = false.obs;

  Future<void> createRide() async {
    isCreatingLoading.value = true;
    final requestId = const Uuid().v4();
    final pickupGeoPoint = GeoPoint(
      double.parse(pickupLatController.text),
      double.parse(pickupLngController.text),
    );
    final dropoffGeoPoint = GeoPoint(
      double.parse(dropoffLatController.text),
      double.parse(dropoffLngController.text),
    );
    rideRequest.value = RideRequestModel(
      requestId: requestId,
      availableSeats: int.parse(selectedSeats.value),
      pickupAddress: pickupLocationController.text,
      dropOfAddress: dropoffLocationController.text,
      ownerId: _authController.userModel.value?.userId,
      ownerLocation: _authController.userModel.value?.latLng,
      pricePerSeat: selectedSeatPrice.value,
      rideDate: selectedDate.value,
      rideDay: DateFormat('yyyy-MM-dd').format(selectedDate.value),
      status: 'Published',
      vehicleName: vehicleNameController.text,
      pickupLocation: pickupGeoPoint,
      dropoffLocation: dropoffGeoPoint,
      note: noteController.text,
      ownerPhoneNumber: _authController.userModel.value?.phoneNumber,
      publishDate: DateTime.now(),
      ownerName:
          '${_authController.userModel.value?.firstName ?? ''} ${_authController.userModel.value?.lastName ?? ''}',
      luggageAllowed: luggageController.text,
    );
    await _firebaseCRUDService.createDocument(
      collectionReference: rideRequestsCollection,
      docId: requestId,
      data: rideRequest.value!.toMap(),
    );
    isCreatingLoading.value = false;
  }
}
