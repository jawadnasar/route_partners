import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/core/constants/firebase_collection_references.dart';
import 'package:route_partners/model/ride_request_model.dart';
import 'package:route_partners/model/user_model.dart';
import 'package:route_partners/services/firebase/firebase_crud.dart';

/**
 * All rides are controlled from here including 
 * Knowing about Status of the ride
 * Publishing Ride
 * Accepting Ride
 * Rejecting Ride
 */
class AllRidesController extends GetxController {
  final _authController = Get.find<AuthController>();
  final _firebaseCrudService = FirebaseCRUDService.instance;
  // var requestedCustomers = <UserModel>[].obs;
  // var acceptedCustomers = <UserModel>[].obs;
  // RxBool isLoading = false.obs;
  Stream<QuerySnapshot<Object?>> getBookedRides() {
    return rideRequestsCollection.where('status', whereIn: [
      'Requested',
      'Completed',
      'Accepted',
      'Rejected'
    ]).snapshots();
  }

  Stream<QuerySnapshot<Object?>> getPublishedRides() {
    return rideRequestsCollection
        .where('ownerId', isEqualTo: _authController.userModel.value?.userId)
        .snapshots();
  }

  Future<void> unPublishRide(String requestId) async {
    await rideRequestsCollection.doc(requestId).delete();
  }

  Future<void> markRideAsAccepted({
    required String requestId,
    required String userName,
    required String phoneNumber,
    required String userId,
    required int selectedSeats,
  }) async {
    AcceptedUser acceptedUser = AcceptedUser(
      id: userId,
      name: userName,
      selectedSeats: selectedSeats,
      phoneNumber: phoneNumber,
    );
    List<RequestedUser> requestedUsers = [];
    final users = await _firebaseCrudService.readDocumentSingleKey(
      collectionReference: rideRequestsCollection,
      documentId: requestId,
      key: 'requestedUsers',
    );

    for (var u in users) {
      requestedUsers.add(RequestedUser.fromMap(u));
    }

    log('leng : ${requestedUsers.length.toString()}');
    final index = requestedUsers.indexWhere(
      (user) => user.id == userId,
    );
    await _firebaseCrudService.updateDocumentSingleKey(
        collection: rideRequestsCollection,
        docId: requestId,
        key: 'requestedUsers',
        value: FieldValue.arrayRemove([requestedUsers[index].toMap()]));
    await _firebaseCrudService.updateDocumentSingleKey(
        collection: rideRequestsCollection,
        docId: requestId,
        key: 'acceptedUsers',
        value: FieldValue.arrayUnion([acceptedUser.toMap()]));
    await _firebaseCrudService.updateDocumentSingleKey(
        collection: rideRequestsCollection,
        docId: requestId,
        key: 'availableSeats',
        value: FieldValue.increment(-acceptedUser.selectedSeats!));
    final data = await _firebaseCrudService.readDocumentSingleKey(
        collectionReference: rideRequestsCollection,
        documentId: requestId,
        key: 'availableSeats');
    final seats = int.parse(data.toString());
    if (seats == 0) {
      await _firebaseCrudService.updateDocumentSingleKey(
          collection: rideRequestsCollection,
          docId: requestId,
          key: 'status',
          value: 'Accepted');
    }
  }

  Future<void> markRideAsRejected(String requestId, String userId) async {
    List<RequestedUser> requestedUsers = [];
    final users = await _firebaseCrudService.readDocumentSingleKey(
      collectionReference: rideRequestsCollection,
      documentId: requestId,
      key: 'requestedUsers',
    );

    for (var u in users) {
      requestedUsers.add(RequestedUser.fromMap(u));
    }

    log('leng : ${requestedUsers.length.toString()}');
    final index = requestedUsers.indexWhere(
      (user) => user.id == userId,
    );
    await _firebaseCrudService.updateDocumentSingleKey(
        collection: rideRequestsCollection,
        docId: requestId,
        key: 'requestedUsers',
        value: FieldValue.arrayRemove([requestedUsers[index].toMap()]));
    await _firebaseCrudService.updateDocumentSingleKey(
        collection: rideRequestsCollection,
        docId: requestId,
        key: 'rejectedUserIds',
        value: FieldValue.arrayUnion([userId]));
  }

  Future<void> markRideAsComplete(String requestId) async {
    await _firebaseCrudService.updateDocumentSingleKey(
        collection: rideRequestsCollection,
        docId: requestId,
        key: 'status',
        value: 'Completed');
  }

  // Future<void> getRequestedCustomers(List<String> requuestedUserIds) async {
  //   List<UserModel> users = [];
  //   if (requuestedUserIds.isNotEmpty) {
  //     for (var id in requuestedUserIds) {
  //       final response = await _firebaseCrudService.readSingleDocument(
  //           collectionReference: usersCollection, docId: id);
  //       final Map<String, dynamic> data =
  //           response?.data() as Map<String, dynamic>;
  //       users.add(UserModel.fromMap(data));
  //     }
  //     requestedCustomers.value = users;
  //   }
  //   log(requestedCustomers.length.toString());
  // }

  // Future<void> getAcceptedCustomers(List<String> acceptedUserIds) async {
  //   List<UserModel> users = [];
  //   if (acceptedUserIds.isNotEmpty) {
  //     for (var id in acceptedUserIds) {
  //       final response = await _firebaseCrudService.readSingleDocument(
  //           collectionReference: usersCollection, docId: id);
  //       final Map<String, dynamic> data =
  //           response?.data() as Map<String, dynamic>;
  //       users.add(UserModel.fromMap(data));
  //     }
  //     acceptedCustomers.value = users;
  //   }
  //   log(acceptedCustomers.length.toString());
  // }
}
