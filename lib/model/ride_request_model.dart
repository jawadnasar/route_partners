import 'package:cloud_firestore/cloud_firestore.dart';

class RideRequestModel {
  String? requestId;
  String? ownerName;
  String? ownerId;
  String? status;
  String? pickupAddress;
  String? dropOfAddress;
  GeoPoint? ownerLocation;
  GeoPoint? pickupLocation;
  GeoPoint? dropoffLocation;
  int? availableSeats;
  DateTime? rideDate;
  String? pricePerSeat;
  String? vehicleName;
  String? note;
  String? ownerPhoneNumber;
  String? rideDay;
  DateTime? publishDate;
<<<<<<< HEAD
  String? acceptedUserId;
  String? acceptedUserPhoneNumber;
  String? acceptedUserName;
  String? requestedUserId;
  String? requestedUserPhoneNumber;
  String? requestedUserName;
=======
  double? routeDistance;
  double? distanceToPickup;
  List<RequestedUser>? requestedUsers;
  List<AcceptedUser>? acceptedUsers;
  List<String>? rejectedUserIds;
>>>>>>> car_hiring

  RideRequestModel({
    this.requestId,
    this.ownerId,
    this.status,
    this.pickupAddress,
    this.dropOfAddress,
    this.ownerLocation,
    this.availableSeats,
    this.rideDate,
    this.pricePerSeat,
    this.vehicleName,
    this.note,
    this.ownerName,
    this.ownerPhoneNumber,
    this.pickupLocation,
    this.dropoffLocation,
    this.rideDay,
    this.publishDate,
<<<<<<< HEAD
    this.acceptedUserId,
    this.acceptedUserName,
    this.acceptedUserPhoneNumber,
    this.requestedUserId,
    this.requestedUserPhoneNumber,
    this.requestedUserName,
=======
    this.routeDistance,
    this.distanceToPickup,
    this.requestedUsers,
    this.acceptedUsers,
    this.rejectedUserIds,
>>>>>>> car_hiring
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestId': requestId,
      'ownerId': ownerId,
      'status': status,
      'pickupAddress': pickupAddress,
      'dropOfAddress': dropOfAddress,
      'ownerLocation': ownerLocation,
      'availableSeats': availableSeats,
      'rideDate': rideDate,
      'pricePerSeat': pricePerSeat,
      'vehicleName': vehicleName,
      'note': note,
      'ownerName': ownerName,
      'ownerPhoneNumber': ownerPhoneNumber,
      'pickupLocation': pickupLocation,
      'dropoffLocation': dropoffLocation,
      'rideDay': rideDay,
      'publishDate': publishDate,
      'requestedUsers': requestedUsers?.map((user) => user.toMap()).toList(),
      'acceptedUsers': acceptedUsers?.map((user) => user.toMap()).toList(),
      'rejectedUserIds': rejectedUserIds,
    };
  }

  factory RideRequestModel.fromMap(Map<String, dynamic> map) {
    return RideRequestModel(
      requestId: map['requestId'],
      ownerId: map['ownerId'],
      status: map['status'],
      pickupAddress: map['pickupAddress'],
      dropOfAddress: map['dropOfAddress'],
      ownerLocation: map['ownerLocation'],
      availableSeats: map['availableSeats'],
      rideDate: map['rideDate'].toDate(),
      pricePerSeat: map['pricePerSeat'],
      vehicleName: map['vehicleName'],
      note: map['note'],
      ownerName: map['ownerName'],
      ownerPhoneNumber: map['ownerPhoneNumber'],
      pickupLocation: map['pickupLocation'],
      dropoffLocation: map['dropoffLocation'],
      rideDay: map['rideDay'],
      publishDate: map['publishDate'].toDate(),
      requestedUsers: map['requestedUsers'] != null
          ? List<RequestedUser>.from(
              map['requestedUsers'].map((user) => RequestedUser.fromMap(user)))
          : [],
      acceptedUsers: map['acceptedUsers'] != null
          ? List<AcceptedUser>.from(
              map['acceptedUsers'].map((user) => AcceptedUser.fromMap(user)))
          : [],
      rejectedUserIds: map['rejectedUserIds'] != null
          ? List<String>.from(map['rejectedUserIds'])
          : [],
    );
  }
}

class RequestedUser {
  String? id;
  String? name;
  int? selectedSeats;
  String? phoneNumber;
  RequestedUser({
    this.id,
    this.name,
    this.selectedSeats,
    this.phoneNumber,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'selectedSeats': selectedSeats,
      'phoneNumber': phoneNumber,
    };
  }

  factory RequestedUser.fromMap(Map<String, dynamic> map) {
    return RequestedUser(
      id: map['id'],
      name: map['name'],
      selectedSeats: map['selectedSeats'],
      phoneNumber: map['phoneNumber'],
    );
  }
}

class AcceptedUser {
  String? id;
  String? name;
  int? selectedSeats;
  String? phoneNumber;
  AcceptedUser({
    this.id,
    this.name,
    this.selectedSeats,
    this.phoneNumber,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'selectedSeats': selectedSeats,
      'phoneNumber': phoneNumber,
    };
  }

  factory AcceptedUser.fromMap(Map<String, dynamic> map) {
    return AcceptedUser(
      id: map['id'],
      name: map['name'],
      selectedSeats: map['selectedSeats'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
