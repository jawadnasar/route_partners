import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? gender;
  String? dateOfBirth;
  String? email;
  String? imageUrl;
  String? fcmToken;
  GeoPoint? latLng;
  String? address;
  String? phoneNumber;
  List<String>? interests;
  UserModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.email,
    this.imageUrl,
    this.fcmToken,
    this.latLng,
    this.address,
    this.phoneNumber,
    this.interests,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'imageUrl': imageUrl,
      'fcmToken': fcmToken,
      'latLng': latLng,
      'address': address,
      'phoneNumber': phoneNumber,
      'interests': interests,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      dateOfBirth: map['dateOfBirth'],
      email: map['email'],
      address: map['address'],
      fcmToken: map['fcmToken'],
      gender: map['gender'],
      imageUrl: map['imageUrl'],
      latLng: map['latLng'],
      phoneNumber: map['phoneNumber'],
      interests:
          map['interests'] == null ? [] : map['interests'].cast<String>(),
    );
  }
}
