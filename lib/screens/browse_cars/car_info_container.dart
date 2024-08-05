import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/model/car_model.dart';
import 'package:route_partners/screens/car_details/car_details.dart';
import 'package:route_partners/screens/car_upload_screens/car_ads.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';

class CanInfoContainer extends StatelessWidget {
  final CarModel car;
  final bool? isCarDetailsScreen;
  final bool? isThere;
  const CanInfoContainer({
    super.key,
    required this.car,
    this.isThere = true,
    this.isCarDetailsScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CarDetails(
              car: car,
              isOwner: false,
            ));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Get.width * 0.55,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: Get.height * 0.18,
                      width: Get.width * 0.55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image:
                                  CachedNetworkImageProvider(car.carImages![0]),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: MyText(
                        text: car.registeredArea ?? 'Islamabad',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                  child: MyText(
                    text: car.carModel ?? 'My Car',
                    size: 12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8).copyWith(bottom: 0),
                  child: MyText(
                    text: '${car.pricePerHour ?? '0'}/hr',
                    weight: FontWeight.bold,
                    size: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8).copyWith(bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: car.modelYear ?? '2022',
                        weight: FontWeight.bold,
                        size: 12,
                      ),
                      DividerCustom(
                        color: kDarkGreyColor,
                        height: Get.height * 0.03,
                      ),
                      MyText(
                        text: car.registeredArea ?? 'ISL',
                        textOverflow: TextOverflow.ellipsis,
                        
                      ),
                      DividerCustom(
                        color: kDarkGreyColor,
                        height: Get.height * 0.03,
                      ),
                      Text(
                        car.exteriorColor ?? 'My Car',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
