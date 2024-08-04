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
              image: DecorationImage(
                image: NetworkImage(car.carImages![0]),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: Get.height * 0.15,
                      width: Get.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                      ),
                      child: MyText(
                        text: car.registeredArea ?? 'Islamabad',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    car.carModel ?? 'My Car',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '${car.pricePerHour ?? '0'}/hr',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        car.modelYear ?? '2022',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      DividerCustom(
                        color: kDarkGreyColor,
                        height: Get.height * 0.03,
                      ),
                      Flexible(
                        child: Text(
                          car.registeredArea ?? 'ISL',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      DividerCustom(
                        color: kDarkGreyColor,
                        height: Get.height * 0.03,
                      ),
                      Text(
                        car.carModel ?? 'My Car',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
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
