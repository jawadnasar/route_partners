import 'package:cloud_firestore/cloud_firestore.dart';

class RideRequestModel {
  String? requestId;
  String? ownerId;
  String? status;
  String? acceptedUserId;
  String? pickupAddress;
  String? dropOfAddress;
  GeoPoint? ownerLocation;
  String? availableSeats;
  DateTime? rideDate;
  String? pricePerSeat;
  String? vehicleName;
  String? note;

  RideRequestModel({
    this.requestId,
    this.ownerId,
    this.status,
    this.acceptedUserId,
    this.pickupAddress,
    this.dropOfAddress,
    this.ownerLocation,
    this.availableSeats,
    this.rideDate,
    this.pricePerSeat,
    this.vehicleName,
    this.note,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestId': requestId,
      'ownerId': ownerId,
      'status': status,
      'acceptedUserId': acceptedUserId,
      'pickupAddress': pickupAddress,
      'dropOfAddress': dropOfAddress,
      'ownerLocation': ownerLocation,
      'availableSeats': availableSeats,
      'rideDate': rideDate,
      'pricePerSeat': pricePerSeat,
      'vehicleName': vehicleName,
      'note': note,
    };
  }

  factory RideRequestModel.fromMap(Map<String, dynamic> map) {
    return RideRequestModel(
      requestId: map['requestId'],
      ownerId: map['ownerId'],
      status: map['status'],
      acceptedUserId: map['acceptedUserId'],
      pickupAddress: map['pickupAddress'],
      dropOfAddress: map['dropOfAddress'],
      ownerLocation: map['ownerLocation'],
      availableSeats: map['availableSeats'],
      rideDate: map['rideDate'],
      pricePerSeat: map['pricePerSeat'],
      vehicleName: map['vehicleName'],
      note: map['note'],
    );
  }
}
