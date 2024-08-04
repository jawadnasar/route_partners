import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/core/constants/firebase_collection_references.dart';
import 'package:route_partners/model/car_model.dart';
import 'package:route_partners/services/firebase/firebase_crud.dart';

class CarHireController extends GetxController {
  final _firebaseCrudService = FirebaseCRUDService.instance;
  RxList<CarModel> availableCars = <CarModel>[].obs;
  RxList<CarModel> allAvailableCars = <CarModel>[].obs;
  final _authController = Get.find<AuthController>();
  RxBool isLoading = false.obs;

  Stream<QuerySnapshot<Object?>> getMyCars() {
    return rentCarsCollection
        .where('ownerId', isNotEqualTo: _authController.userModel.value?.userId)
        .where('status', whereIn: ['Accepted', 'Published']).snapshots();
  }

  Stream<QuerySnapshot<Object?>> getAvailableCars() {
    return rentCarsCollection
        .where('ownerId', isNotEqualTo: _authController.userModel.value?.userId)
        .where('status', isEqualTo: 'Published')
        .where('acceptedUserId', isNull: true)
        .snapshots();
  }

  Future<void> bookCar(String carId) async {
    isLoading.value = true;
    final CarRequestedUser user = CarRequestedUser(
      id: _authController.userModel.value?.userId,
      name: _authController.userModel.value?.firstName,
      phoneNumber: _authController.userModel.value?.phoneNumber,
    );
    await _firebaseCrudService.updateDocumentSingleKey(
      collection: rentCarsCollection,
      docId: carId,
      key: 'requestedUsers',
      value: FieldValue.arrayUnion([user.toMap()]),
    );
    isLoading.value = false;
  }
}
