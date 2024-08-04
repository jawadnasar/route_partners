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
import 'package:shared_preferences/shared_preferences.dart';

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
  RxBool isEditLoading = false.obs;
  List<String> selectedInterests = [];

  Future<void> singupEmailPassword() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = await _firebaseAuthService.signUpUsingEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
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
        phoneNumber:
            '${_generalController.dialCode.value}${phoneNumberController.text}',
        latLng: GeoPoint(
          position?.latitude ?? 0.0,
          position?.longitude ?? 0,
        ),
        interests: selectedInterests,
      );
      await setUserInfo();
      await getUserInfo(user.uid);
      await prefs.setString('route_partners_uid', user.uid);
      isAuth.value = true;
    }
    isLoading.value = false;
  }

  Future<void> loginEmailPassword() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final user = await _firebaseAuthService.signInUsingEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    if (user != null) {
      await getUserInfo(user.uid);
      await prefs.setString('route_partners_uid', user.uid);

      isAuth.value = true;
    }
    isLoading.value = false;
  }

  Future<void> googleLogin() async {
    isGoogleLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

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
      await prefs.setString('route_partners_uid', user.$1!.uid);

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

  Future<bool> editUserInfo(
      String firstName, String lastName, String phoneNumber) async {
    isEditLoading.value = true;
    final firstNameEdited = await _firebaseCrudService.updateDocumentSingleKey(
      collection: usersCollection,
      docId: userModel.value!.userId!,
      key: 'firstName',
      value: firstName,
    );
    final lastNameEdited = await _firebaseCrudService.updateDocumentSingleKey(
      collection: usersCollection,
      docId: userModel.value!.userId!,
      key: 'lastName',
      value: lastName,
    );
    final phoneNumberEdited =
        await _firebaseCrudService.updateDocumentSingleKey(
      collection: usersCollection,
      docId: userModel.value!.userId!,
      key: 'phoneNumber',
      value: phoneNumber,
    );

    if (firstNameEdited && lastNameEdited && phoneNumberEdited) {
      await getUserInfo(userModel.value!.userId!);
      isEditLoading.value = false;
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    await _firebaseAuthService.logout();
  }

  resetValues() {
    phoneNumberController.clear();
    firstController.clear();
    lastController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    dateOfBirthController.clear();
    userModel.value = null;
    selectedGender.value = '';
    isLoading.value = false;
    isGoogleLoading.value = false;
    isAuth.value = false;
    isObscure.value = true;
    isEditLoading.value = false;
  }

  @override
  void onClose() {
    super.onClose();
    phoneNumberController.dispose();
    firstController.dispose();
    lastController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dateOfBirthController.dispose();
    userModel.value = null;
    selectedGender.value = '';
    isLoading.value = false;
    isGoogleLoading.value = false;
    isAuth.value = false;
    isObscure.value = true;
    isEditLoading.value = false;
  }

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
    firstController.dispose();
    lastController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dateOfBirthController.dispose();
    userModel.value = null;
    selectedGender.value = '';
    isLoading.value = false;
    isGoogleLoading.value = false;
    isAuth.value = false;
    isObscure.value = true;
    isEditLoading.value = false;
  }
}
