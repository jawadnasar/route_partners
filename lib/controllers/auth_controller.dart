import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/general_controller.dart';
import 'package:route_partners/core/constants/firebase_collection_references.dart';
import 'package:route_partners/model/user_model.dart';
import 'package:route_partners/services/firebase/firebase_authentication.dart';
import 'package:route_partners/services/firebase/firebase_crud.dart';
import 'package:route_partners/services/google_maps/google_maps.dart';

class AuthController extends GetxController {
  final _generalController = Get.find<GeneralController>();
  final _firebaseAuthService = FirebaseAuthService.instance;
  final _firebaseCrudService = FirebaseCRUDService.instance;
  final phoneNumberController = TextEditingController();
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  var userModel = Rx<UserModel?>(null);
  final List<String> genders = ['Mr', 'Ms'];
  final RxString selectedGender = ''.obs;
  final singupFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool isGoogleLoading = false.obs;
  RxBool isAuth = false.obs;
  RxBool isObscure = true.obs;

  Future<void> singupEmailPassword() async {
    isLoading.value = true;
    final user = await _firebaseAuthService.signUpUsingEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (user != null) {
      final Position? position =
          await GoogleMapsService.instance.getUserLocation();
      userModel.value = UserModel(
        userId: user.uid,
        email: user.email,
        dateOfBirth: dateOfBirthController.text,
        firstName: firstController.text,
        lastName: lastController.text,
        gender: selectedGender.value,
        phoneNumber: phoneNumberController.text,
        countryCode: _generalController.dialCode.value,
        latLng: GeoPoint(position?.latitude ?? 0.0, position?.longitude ?? 0),
      );
      await setUserInfo();
      await getUserInfo(user.uid);
      isAuth.value = true;
    }
    isLoading.value = false;
  }

  Future<void> loginEmailPassword() async {
    isLoading.value = true;
    final user = await _firebaseAuthService.signInUsingEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (user != null) {
      await getUserInfo(user.uid);
      isAuth.value = true;
    }
    isLoading.value = false;
  }

  Future<void> googleLogin() async {
    isGoogleLoading.value = true;
    final user = await _firebaseAuthService.authWithGoogle();

    if (user.$1 != null) {
      final isExists = await checkIfGoogleUserFirstTime(user.$1!.uid);
      if (!isExists) {
        final Position? position =
            await GoogleMapsService.instance.getUserLocation();
        userModel.value = UserModel(
          userId: user.$1?.uid,
          email: user.$2?.email,
          firstName: user.$2?.displayName,
          imageUrl: user.$2?.photoUrl,
          phoneNumber: user.$1?.phoneNumber,
          latLng: GeoPoint(position?.latitude ?? 0.0, position?.longitude ?? 0),
        );
        await setUserInfo();
      }
      await getUserInfo(user.$1!.uid);
      isAuth.value = true;
    }
    isGoogleLoading.value = false;
  }

  Future<void> setUserInfo() async {
    await _firebaseCrudService.createDocument(
      collectionReference: usersCollection,
      docId: userModel.value!.userId!,
      data: userModel.value!.toMap(),
    );
  }

  Future<bool> checkIfGoogleUserFirstTime(String userId) async {
    final isExists = await _firebaseCrudService.isDocExist(
        collectionReference: usersCollection, docId: userId);
    return isExists;
  }

  Future<void> getUserInfo(String userId) async {
    final snapshot = await _firebaseCrudService.readSingleDocument(
        collectionReference: usersCollection, docId: userId);
    if (snapshot != null) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      userModel.value = UserModel.fromMap(data);
    }
  }
}
