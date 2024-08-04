import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/car_hire_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/model/car_model.dart';
import 'package:route_partners/screens/car_booked/car_booked.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';

class ConfirmBooking extends StatelessWidget {
  final CarModel car;
  ConfirmBooking({required this.car, super.key});
  final _carHireController = Get.find<CarHireController>();
  // ignore: use_key_in_widget_constructors

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: Get.height * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: MyText(
                  text: "Are you sure you want to book this ride?",
                  size: 14.5,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyButton(
                      textColor: Colors.white,
                      bgColor: kPrimaryColor,
                      buttonText: "YES",
                      width: Get.width * 0.3,
                      textSize: 15,
                      onTap: () async {
                        Get.back();
                        await _carHireController.bookCar(car.carId!);
                        Get.to(() => const CarBookedSuccessfullyScreen());
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyButton(
                      textColor: Colors.white,
                      bgColor: kPrimaryColor,
                      width: Get.width * 0.3,
                      buttonText: "NO",
                      textSize: 15,
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

showHowtoPlayBottomSheet(CarModel car) {
  showModalBottomSheet(
    isDismissible: false,
    backgroundColor: Colors.transparent,
    context: Get.context!,
    builder: (BuildContext context) {
      return ConfirmBooking(
        car: car,
      );
    },
    isScrollControlled: true,
  );
}
