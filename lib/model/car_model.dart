import 'package:cloud_firestore/cloud_firestore.dart';

class CarModel {
  String? carId;
  String? ownerId;
  String? ownerName;
  String? ownerPhoneNumber;
  String? modelYear;
  String? carModel;
  String? registeredArea;
  String? exteriorColor;
  List<String>? carImages;
  String? pricePerHour;
  String? primaryMobileNumber;
  String? secondaryMobileNumber;
  GeoPoint? latLng;
  String? address;
  List<CarRequestedUser>? requestedUsers;
  String? acceptedUserId;
  String? status;
  List<String>? rejectedUsersIds;

  CarModel({
    this.carId,
    this.ownerId,
    this.modelYear,
    this.carModel,
    this.registeredArea,
    this.exteriorColor,
    this.carImages,
    this.pricePerHour,
    this.primaryMobileNumber,
    this.secondaryMobileNumber,
    this.latLng,
    this.address,
    this.requestedUsers,
    this.status,
    this.acceptedUserId,
    this.ownerName,
    this.ownerPhoneNumber,
    this.rejectedUsersIds,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'carId': carId,
      'ownerId': ownerId,
      'modelYear': modelYear,
      'carModel': carModel,
      'registeredArea': registeredArea,
      'exteriorColor': exteriorColor,
      'carImages': carImages,
      'pricePerHour': pricePerHour,
      'primaryMobileNumber': primaryMobileNumber,
      'secondaryMobileNumber': secondaryMobileNumber,
      'latLng': latLng,
      'address': address,
      'requestedUsers': requestedUsers?.map((user) => user.toMap()).toList(),
      'status': status,
      'acceptedUserId': acceptedUserId,
      'ownerName': ownerName,
      'ownerPhoneNumber': ownerPhoneNumber,
      'rejectedUsersIds': rejectedUsersIds,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      carId: map['carId'],
      ownerId: map['ownerId'],
      modelYear: map['modelYear'],
      carModel: map['carModel'],
      registeredArea: map['registeredArea'],
      exteriorColor: map['exteriorColor'],
      carImages:
          map['carImages'] == null ? [] : map['carImages'].cast<String>(),
      pricePerHour: map['pricePerHour'],
      primaryMobileNumber: map['primaryMobileNumber'],
      secondaryMobileNumber: map['secondaryMobileNumber'],
      latLng: map['latLng'],
      address: map['address'],
      requestedUsers: map['requestedUsers'] != null
          ? List<CarRequestedUser>.from(map['requestedUsers']
              .map((user) => CarRequestedUser.fromMap(user)))
          : [],
      status: map['status'],
      acceptedUserId: map['acceptedUserId'],
      ownerName: map['ownerName'],
      ownerPhoneNumber: map['ownerPhoneNumber'],
      rejectedUsersIds: map['rejectedUsersIds'] == null
          ? []
          : map['rejectedUsersIds'].cast<String>(),
    );
  }
}

class CarRequestedUser {
  String? id;
  String? name;
  String? phoneNumber;

  CarRequestedUser({
    this.id,
    this.name,
    this.phoneNumber,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }

  factory CarRequestedUser.fromMap(Map<String, dynamic> map) {
    return CarRequestedUser(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
