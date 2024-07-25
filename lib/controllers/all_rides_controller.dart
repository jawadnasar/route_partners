import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/core/constants/firebase_collection_references.dart';
import 'package:route_partners/services/firebase/firebase_crud.dart';

class AllRidesController extends GetxController {
  final _authController = Get.find<AuthController>();
  final _firebaseCrudService = FirebaseCRUDService.instance;
  Stream<QuerySnapshot<Object?>> getBookedRides() {
    return rideRequestsCollection
        .where('requestedUserId',
            isEqualTo: _authController.userModel.value?.userId)
        .where('status', whereIn: [
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

  Future<void> markRideAsAccepted(String requestId, String userName,
      String phoneNumber, String userId) async {
    await _firebaseCrudService.updateDocumentSingleKey(
        collection: rideRequestsCollection,
        docId: requestId,
        key: 'acceptedUserId',
        value: userId);
    await _firebaseCrudService.updateDocumentSingleKey(
        collection: rideRequestsCollection,
        docId: requestId,
        key: 'acceptedUserPhoneNumber',
        value: phoneNumber);
    await _firebaseCrudService.updateDocumentSingleKey(
        collection: rideRequestsCollection,
        docId: requestId,
        key: 'acceptedUserName',
        value: userName);
    await _firebaseCrudService.updateDocumentSingleKey(
        collection: rideRequestsCollection,
        docId: requestId,
        key: 'status',
        value: 'Accepted');
  }

  Future<void> markRideAsRejected(String requestId) async {
    await _firebaseCrudService.updateDocumentSingleKey(
        collection: rideRequestsCollection,
        docId: requestId,
        key: 'status',
        value: 'Rejected');
  }

  Future<void> markRideAsComplete(String requestId) async {
    await _firebaseCrudService.updateDocumentSingleKey(
        collection: rideRequestsCollection,
        docId: requestId,
        key: 'status',
        value: 'Completed');
  }
}
