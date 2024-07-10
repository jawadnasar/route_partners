import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  final pickupLocationController = TextEditingController();
  final dropoffLocationController = TextEditingController();
  final noteController = TextEditingController();
  RxBool isCreatingLoading = false.obs;
  LatLng? pickupLatLng;
  LatLng? dropoffLatLng;

  Future<void> createRide() async {
    isCreatingLoading.value = true;
    final requestId = const Uuid().v4();
    rideRequest.value = RideRequestModel(
      requestId: requestId,
      availableSeats: selectedSeats.value,
      pickupAddress: pickupLocationController.text,
      dropOfAddress: dropoffLocationController.text,
      ownerId: _authController.userModel.value?.userId,
      ownerLocation: _authController.userModel.value?.latLng,
      pricePerSeat: selectedSeatPrice.value,
      rideDate: selectedDate.value,
      status: 'Requested',
      vehicleName: vehicleNameController.text,
    );
    await _firebaseCRUDService.createDocument(
      collectionReference: rideRequestsCollection,
      docId: requestId,
      data: rideRequest.value!.toMap(),
    );
    isCreatingLoading.value = false;
  }
}
