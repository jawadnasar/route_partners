import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PaymentTypeController extends GetxController{

   List<String> paymentTypes = ['Cash', 'Online'];
   String selectPayment = '';

  updateSelectedPayment(String payment){
    selectPayment = payment;
    update();
  }
}