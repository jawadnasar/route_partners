import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/core/constants/firebase_collection_references.dart';
import 'package:route_partners/model/ride_request_model.dart';
import 'package:route_partners/services/firebase/firebase_crud.dart';

/**
 * Searching to find a ride near to me
 * Booking a ride 
 */
class FindRideController extends GetxController {
  final _firebaseCRUDService = FirebaseCRUDService.instance;
  final _authController = Get.find<AuthController>();
  // var rideRequest = Rx<RideRequestModel?>(null);
  RxString selectedSeatPrice = '50'.obs;
  RxInt numberOfSeats = 0.obs;
  var selectedDate = DateTime.now().obs;
  final vehicleNameController = TextEditingController();
  final pickupLocationController = TextEditingController();
  final dropoffLocationController = TextEditingController();
  final noteController = TextEditingController();
  RxBool isBookLoading = false.obs;
  final pickupLatController = TextEditingController();
  final pickupLngController = TextEditingController();
  final dropoffLatController = TextEditingController();
  final dropoffLngController = TextEditingController();

  Stream<QuerySnapshot<Object?>> getRideRequestsStream() {
    return rideRequestsCollection
        .where(
          'ownerId',
          isNotEqualTo: _authController.userModel.value?.userId,
        )
        .where('status', whereIn: ['Published', 'Requested'])
        .where('rideDay',
            isEqualTo: DateFormat('yyyy-MM-dd').format(selectedDate.value))
        .where('availableSeats', isGreaterThan: 0)
        .snapshots();
  }

  Future<void> bookRide({
    required String requestId,
    required String userId,
    required String userName,
    required int selectedSeats,
    required String phoneNumber,
  }) async {
    isBookLoading.value = true;
    final RequestedUser requestedUser = RequestedUser(
      id: userId,
      name: userName,
      selectedSeats: selectedSeats,
      phoneNumber: phoneNumber,
    );
    _firebaseCRUDService.updateDocumentSingleKey(
        collection: rideRequestsCollection,
        docId: requestId,
        key: 'requestedUsers',
        value: FieldValue.arrayUnion([requestedUser.toMap()]));
    _firebaseCRUDService.updateDocumentSingleKey(
        collection: rideRequestsCollection,
        docId: requestId,
        key: 'status',
        value: 'Requested');
    isBookLoading.value = false;
  }

  void incrementSeats(int availableSeats) {
    if (numberOfSeats < availableSeats) {
      numberOfSeats++;
      update();
    }
  }

  void decrementSeats() {
    if (numberOfSeats > 0) {
      numberOfSeats--;
      update();
    }
  }
}
