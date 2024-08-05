import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/core/constants/firebase_collection_references.dart';
import 'package:route_partners/model/car_model.dart';
import 'package:route_partners/services/firebase/firebase_crud.dart';
import 'package:route_partners/services/firebase/firebase_storage.dart';
import 'package:uuid/uuid.dart';

/**
 * Uploading my cars
 * Methods include to upload a new car including its information and uploading its pictures
 * Other methods include accepting or rejecting requests about mycar
 */
class CarUploadController extends GetxController {
  final _firebaseStorageService = FirebaseStorageService.instance;
  final _firebaseCrudService = FirebaseCRUDService.instance;
  final _authController = Get.find<AuthController>();
  RxList<CarModel> myCarsAds = <CarModel>[].obs;
  List<File> _files = [];
  List<File> get files => _files;

  RxBool isLoading = false.obs;
  RxBool isRequestsLoading = false.obs;

  /// Car Info
  late TextEditingController modalYear;
  late TextEditingController carModal;
  late TextEditingController carRegisteredArea;
  late TextEditingController carExteriorColor;

  /// Contact Info
  late TextEditingController sellerName;
  late TextEditingController price;
  late TextEditingController primaryMobNum;
  late TextEditingController? secondaryPhone;

  late TextEditingController address;
  late TextEditingController lat;
  late TextEditingController lng;
  clearAll() {
    address.clear();
    lat.clear();
    lng.clear();
    sellerName.clear();
    price.clear();
    primaryMobNum.clear();
    secondaryPhone?.clear();
    _files = [];
    update();
  }

  bool? whatsapp = false;

  addImage(File file) {
    files.add(file);
    update();
  }

  removeFile(int index) {
    _files.removeAt(index);
    update();
  }

  Future<List<File>?> pickImages({
    bool allowMultiple = true,
    BuildContext? context,
  }) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowedExtensions: [
        'png',
        'jpg',
      ], allowMultiple: true, type: FileType.custom, allowCompression: true);

      if (result != null) {
        List<File> files =
            result.paths.map((path) => File(path!)).toSet().toList();
        _files.addAll(files);
        update();
      }
      update();
    } catch (e) {
      log(e.toString());
    }

    update();
    return null;
  }

  Future<void> uploadCar(
      {required String modelYear,
      required String carModel,
      required String registeredArea,
      required String exteriorColor,
      required List<File> carImages,
      required String sellerName,
      required String pricePerHour,
      required String primaryMobileNumber,
      required String? secondaryMobileNumber,
      required GeoPoint latLng,
      required String address}) async {
    isLoading.value = true;
    final carId = const Uuid().v4();
    List imagesUrls = [];
    imagesUrls = await _firebaseStorageService.uploadMultipleImages(
        imagesPaths: carImages.map((file) => file).toList(), storageRef: carId);
    log(imagesUrls.toString());
    final car = CarModel(
      carId: carId,
      address: address,
      carImages: imagesUrls.cast<String>(),
      carModel: carModel,
      exteriorColor: exteriorColor,
      latLng: latLng,
      modelYear: modelYear,
      ownerId: _authController.userModel.value?.userId,
      ownerName: sellerName,
      ownerPhoneNumber: _authController.userModel.value?.phoneNumber,
      pricePerHour: pricePerHour,
      primaryMobileNumber: primaryMobileNumber,
      registeredArea: registeredArea,
      secondaryMobileNumber: secondaryMobileNumber,
      status: 'Published',
    );
    // await rentCarsCollection.add(car.toMap());
    await _firebaseCrudService.createDocument(
        collectionReference: rentCarsCollection,
        docId: carId,
        data: car.toMap());

    isLoading.value = false;
  }

  Stream<QuerySnapshot<Object?>> getUploadedCars() {
    return rentCarsCollection
        .where('ownerId', isEqualTo: _authController.userModel.value?.userId)
        .snapshots();
  }

  Future<void> rejectRequest(String carID, String rejectedUserId) async {
    isRequestsLoading.value = true;
    await _firebaseCrudService.updateDocumentSingleKey(
      collection: rentCarsCollection,
      docId: carID,
      key: 'rejectedUsersIds',
      value: FieldValue.arrayUnion([rejectedUserId]),
    );
    final snapshot = await _firebaseCrudService.readSingleDocument(
        collectionReference: rentCarsCollection, docId: carID);
    if (snapshot != null) {
      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      final CarModel car = CarModel.fromMap(data);
      if (car.requestedUsers!.isNotEmpty) {
        final List<CarRequestedUser> users = car.requestedUsers!;
        users.removeWhere((user) => user.id == rejectedUserId);
        await _firebaseCrudService.updateDocumentSingleKey(
            collection: rentCarsCollection,
            docId: carID,
            key: 'requestedUsers',
            value: users.map((user) => user.toMap()).toList());
      }
    }
    Get.back();
    isRequestsLoading.value = false;
  }

  Future<void> acceptRequest(String carId, String acceptedUserId) async {
    isRequestsLoading.value = true;
    await _firebaseCrudService.updateDocumentSingleKey(
      collection: rentCarsCollection,
      docId: carId,
      key: 'acceptedUserId',
      value: acceptedUserId,
    );
    await _firebaseCrudService.updateDocumentSingleKey(
      collection: rentCarsCollection,
      docId: carId,
      key: 'status',
      value: 'Accepted',
    );
    final snapshot = await _firebaseCrudService.readSingleDocument(
        collectionReference: rentCarsCollection, docId: carId);
    if (snapshot != null) {
      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      final CarModel car = CarModel.fromMap(data);
      if (car.requestedUsers!.isNotEmpty) {
        final List<CarRequestedUser> users = car.requestedUsers!;
        users.removeWhere((user) => user.id == acceptedUserId);
        await _firebaseCrudService.updateDocumentSingleKey(
            collection: rentCarsCollection,
            docId: carId,
            key: 'requestedUsers',
            value: users.map((user) => user.toMap()).toList());
      }
    }
    Get.back();
    isRequestsLoading.value = false;
  }

  @override
  void onInit() {
    modalYear = TextEditingController();
    carModal = TextEditingController();
    address = TextEditingController();
    carExteriorColor = TextEditingController();
    carRegisteredArea = TextEditingController();
    lat = TextEditingController();
    lng = TextEditingController();
    sellerName = TextEditingController();
    price = TextEditingController();
    primaryMobNum = TextEditingController();
    secondaryPhone = TextEditingController();

    super.onInit();
  }

  static CarUploadController get i => Get.put(CarUploadController());
}
