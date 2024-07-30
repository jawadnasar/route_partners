import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/create_ride_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/ride_published/ride_published.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class PublishRideScreen extends StatelessWidget {
  final _createRideController = Get.find<CreateRideController>();
  PublishRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: simpleAppBar(
        elevation: 0,
        title: '',
      ),
      body: Padding(
        padding: AppSizes.DEFAULT,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset(
                Assets.check,
                height: Get.height * 0.2,
              )),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Center(
                child: MyText(
                  text: 'Your ride is created !',
                  weight: FontWeight.w900,
                  color: kGreyColor7,
                  size: 20,
                ),
              ),
              SizedBox(
                height: Get.height * 0.07,
              ),
              MyText(
                text: 'Got anything to add about the ride ? Write it here ',
                weight: FontWeight.w600,
                color: kGreyColor7,
              ),
              const SizedBox(
                height: 10,
              ),
              MyText(
                text:
                    'e.g: Flexible about when and where to meet? Need passengers to be punctual etc.',
                weight: FontWeight.w500,
                color: kGreyColor,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                hintText: 'Write upto 100 words',
                fillColor: kGreyColor9,
                filled: true,
                underLineBorderColor: kWhiteColor2,
                maxLines: 5,
                controller: _createRideController.noteController,
              ),
              const SizedBox(
                height: 20,
              ),
              // const Divider(
              //   color: kDarkGreyColor,
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // Row(
              //   children: [
              //     MyText(
              //       text: 'Luggage Allowance',
              //       color: kBlackColor2,
              //       weight: FontWeight.w700,
              //     ),
              //     const Spacer(),
              //     MyText(
              //       text: '1 carry on bag',
              //       color: kGreyColor3,
              //       weight: FontWeight.w700,
              //     ),
              //     const Icon(
              //       Icons.arrow_right_sharp,
              //       color: kGreyColor3,
              //     )
              //   ],
              // ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                color: kDarkGreyColor,
              ),
              Row(
                children: [
                  MyText(
                    text: 'Mode of payment',
                    color: kBlackColor2,
                    weight: FontWeight.w700,
                  ),
                  const Spacer(),
                  MyText(
                    text: 'Cash',
                    color: kGreyColor3,
                    weight: FontWeight.w700,
                  ),
                  const Icon(
                    Icons.arrow_right_sharp,
                    color: kGreyColor3,
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                color: kDarkGreyColor,
              ),
              Row(
                children: [
                  MyText(
                    text: 'Ride Approval',
                    color: kBlackColor2,
                    weight: FontWeight.w700,
                  ),
                  const Spacer(),
                  MyText(
                    text: 'Instant',
                    color: kGreyColor3,
                    weight: FontWeight.w700,
                  ),
                  const Icon(
                    Icons.arrow_right_sharp,
                    color: kGreyColor3,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Obx(
                () => _createRideController.isCreatingLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      )
                    : MyButton(
                        radius: 5,
                        weight: FontWeight.w900,
                        buttonText: 'PUBLISH RIDE',
                        bgColor: kPrimaryColor,
                        textColor: Colors.white,
                        onTap: () async {
                          await _createRideController.createRide();
                          Get.to(() => const RidePushSuccessful());
                        }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
