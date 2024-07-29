import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:route_partners/controllers/car_upload_controller.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';

class ContactInformation extends StatefulWidget {
  const ContactInformation({super.key});

  @override
  State<ContactInformation> createState() => _ContactInformationState();
}

class _ContactInformationState extends State<ContactInformation> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: 'Contact Information',
            size: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Seller Name is empty';
              }
              return null;
            },
            controller: CarUploadController.i.sellerName,
            radius: 10,
            hintText: 'Seller Name',
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Enter Price';
              }
              if (p0.length > 8) {
                return 'The price limit exceeded';
              }
              return null;
            },
            hintText: 'Price per hour',
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Enter Primary Mobile Number';
              }
              return null;
            },
            // keyBoardType: TextInputType.phone,
            controller: CarUploadController.i.primaryMobNum,
            radius: 10,
            hintText: 'Primary Mobile Number',
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            // keyBoardType: TextInputType.phone,
            controller: CarUploadController.i.secondaryPhone,
            radius: 10,
            hintText: 'Secondary Mobile Number',
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
