import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference usersCollection =
    FirebaseFirestore.instance.collection("users");
CollectionReference rideRequestsCollection =
    FirebaseFirestore.instance.collection("rideRequests");
CollectionReference rentCarsCollection =
    FirebaseFirestore.instance.collection("rentCars");
