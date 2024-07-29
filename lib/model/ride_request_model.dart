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
  int? selectedSeats;
  DateTime? rideDate;
  String? pricePerSeat;
  String? vehicleName;
  String? note;
  String? ownerPhoneNumber;
  String? rideDay;
  DateTime? publishDate;
  String? acceptedUserId;
  String? acceptedUserPhoneNumber;
  String? acceptedUserName;
  String? requestedUserId;
  String? requestedUserPhoneNumber;
  String? requestedUserName;

  RideRequestModel({
    this.requestId,
    this.ownerId,
    this.status,
    this.pickupAddress,
    this.dropOfAddress,
    this.ownerLocation,
    this.availableSeats,
    this.selectedSeats,
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
    this.acceptedUserId,
    this.acceptedUserName,
    this.acceptedUserPhoneNumber,
    this.requestedUserId,
    this.requestedUserPhoneNumber,
    this.requestedUserName,
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
      'selectedSeats': selectedSeats,
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
      'acceptedUserId': acceptedUserId,
      'acceptedUserName': acceptedUserName,
      'acceptedUserPhoneNumber': acceptedUserPhoneNumber,
      'requestedUserId': requestedUserId,
      'requestedUserPhoneNumber': requestedUserPhoneNumber,
      'requestedUserName': requestedUserName,
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
      selectedSeats: map['selectedSeats'],
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
      acceptedUserId: map['acceptedUserId'],
      acceptedUserName: map['acceptedUserName'],
      acceptedUserPhoneNumber: map['acceptedUserPhoneNumber'],
      requestedUserId: map['requestedUserId'],
      requestedUserPhoneNumber: map['requestedUserPhoneNumber'],
      requestedUserName: map['requestedUserName'],
    );
  }
}
