import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/car_upload_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_sizes.dart';

class UploadPhotos extends StatelessWidget {
  File? file;

  UploadPhotos({super.key});
  final cont = Get.find<CarUploadController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              await cont.pickImages(allowMultiple: true);
              if (cont.files.length >= 12) {
                Get.snackbar('Limit Exceeded', 'Max Upload Limit is 12',
                    colorText: Colors.white, backgroundColor: kPrimaryColor);
              } else {
                // edit.updateList(edit.selectedFiles);
              }
            },
            child: DottedBorder(
              strokeCap: StrokeCap.round,
              borderType: BorderType.Rect,
              dashPattern: const [17, 5, 8, 10],
              child: Container(
                padding: AppSizes.HORIZONTAL,
                width: Get.width,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.image),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Add or Upload image')
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Max Uploads (12)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 14, fontWeight: FontWeight.w900, color: kBlackColor),
          ),
          const SizedBox(
            height: 10,
          ),
          GetBuilder<CarUploadController>(
              init: cont,
              builder: (contr) {
                return GridView.builder(
                  itemCount: contr.files.isNotEmpty ? contr.files.length : 1,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: contr.files.isNotEmpty ? 4 : 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    if (cont.files.isEmpty) {
                      return const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '- At least 8 photos to improve check for sale',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '- jpg or png',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      );
                    } else {
                      final image = cont.files[index];
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: FileImage(image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: -10,
                            child: CircleAvatar(
                              backgroundColor: kPrimaryColor,
                              radius: 15,
                              child: IconButton(
                                onPressed: () {
                                  cont.removeFile(index);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  },
                );
              })
        ],
      ),
    );
  }
}

Uint8List base64Decode(String base64String) {
  return base64.decode(base64String);
}
