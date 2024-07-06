import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  
  DateTime? dateTime;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime) {
      dateTime = picked;
      update();
    }
  }

    static final HomePageController instance =
      Get.put<HomePageController>(HomePageController());

}
