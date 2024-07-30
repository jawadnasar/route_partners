// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/car_upload_controller.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';

class CarInformation extends StatefulWidget {
  const CarInformation({
    super.key,
  });

  @override
  State<CarInformation> createState() => _CarInformationState();
}

class _CarInformationState extends State<CarInformation> {
  @override
  void initState() {
    // if (RegistrationController.i.user.mobileNumber != null) {
    //   CarUploadController.i.primaryMobNum?.text =
    //       RegistrationController.i.user.mobileNumber!;
    // }

    // CarUploadController.i.sellerName.text =
    //     RegistrationController.i.user.firstName!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var contr = Get.put<CarUploadController>(CarUploadController());
    return GetBuilder<CarUploadController>(builder: (contr) {
      return SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          MyText(
            text: 'Car Information',
            size: 20,
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextField(
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Modal year is empty';
              }
              return null;
            },
            controller: CarUploadController.i.modalYear,
            radius: 10,
            hintText: 'Modal Year',
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextField(
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Car Modal is empty';
              }
              return null;
            },
            controller: CarUploadController.i.carModal,
            radius: 10,
            hintText: 'Car Modal',
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextField(
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Car Registered Area is empty';
              }
              return null;
            },
            controller: CarUploadController.i.carRegisteredArea,
            radius: 10,
            hintText: 'Car Registered Area',
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextField(
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Car exterior color is empty';
              }
              return null;
            },
            controller: CarUploadController.i.carExteriorColor,
            radius: 10,
            hintText: 'Car exterior color',
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ));
    });
  }
}
