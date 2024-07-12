import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideDetailsController extends GetxController {
  int numberOfSeats = 1;

void incrementSeats() {
  if (numberOfSeats < 8) {
    numberOfSeats++;
    update();
  }
}

void decrementSeats() {
  if (numberOfSeats > 1) {
    numberOfSeats--;
    update();
  }
}


  static final RideDetailsController instance = Get.put<RideDetailsController>(RideDetailsController());
}
