import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/ride_details.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_fonts.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/screens/browse_rides/browse_rides.dart';
import 'package:route_partners/screens/dashboard/bottom_bar.dart';
import 'package:route_partners/screens/ride_booked/ride_booked.dart';
import 'package:route_partners/screens/widget/common_image_view_widget.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class RideDetails extends StatelessWidget {
  const RideDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(centerTitle: false, title: 'Ride Details'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            tripInfo(),
            const SizedBox(
              height: 10,
            ),
            driverDetailsAndCoPassengers()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showSelectSeatsBottomSheet();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyText(
                        text: 'Select Seats',
                        color: kTextColor4,
                        weight: FontWeight.w400,
                      ),
                      const Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
                MyButton(
                    bgColor: kPrimaryColor,
                    textColor: Colors.white,
                    radius: 5,
                    width: Get.width * 0.4,
                    onTap: () {
                      Get.to(() => const RideBookedSuccessfully());
                    })
              ],
            ),
            MyText(
              text: 'Select a Seat',
              weight: FontWeight.w900,
            ),
          ],
        ),
      ),
    );
  }

  Container driverDetailsAndCoPassengers() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: Get.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(Assets.covidFree),
              const SizedBox(
                width: 10,
              ),
              MyText(
                text: 'Follow Covid 19 Safety Measures',
                size: 12,
                color: kPrimaryColor,
                weight: FontWeight.w700,
              )
            ],
          ),
          const Divider(
            color: kDarkGreyColor,
          ),
          ListTile(
            visualDensity: VisualDensity.comfortable,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              child: CommonImageView(
                fit: BoxFit.contain,
                radius: 20,
                imagePath: Assets.boyIcon,
              ),
            ),
            title: MyText(
              text: 'Driver',
              size: 12,
              weight: FontWeight.w900,
              color: kTextColor,
            ),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(
                  text: '4.5',
                  color: kGreyColor8,
                  weight: FontWeight.w900,
                  size: 12,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                MyText(
                  text: '27 ratings',
                  color: kGreyColor8,
                  weight: FontWeight.w900,
                  size: 12,
                ),
              ],
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: kGreyColor8,
              size: 12,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(Assets.carpool),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: Get.width * 0.3,
                child: MyText(
                  text: 'Nexon HR26 7788 (blue)',
                  color: kGreyColor8,
                ),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {},
                  child: MyText(
                    text: 'Contact Driver',
                    color: kPrimaryColor,
                    weight: FontWeight.w600,
                  ))
            ],
          ),
          const Divider(
            color: kDarkGreyColor,
          ),
          MyText(
            text: 'Co-Passengers',
            color: kBlackColor,
            weight: FontWeight.bold,
          ),
          ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(Assets.boyIcon),
                  ),
                  title: MyText(
                    text: 'Sher Ali ktk',
                    color: kGreyColor8,
                  ),
                  subtitle: MyText(
                    text: 'Gurgoon -> Meerut',
                    color: kGreyColor8,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                );
              })
        ],
      ),
    );
  }

  Container tripInfo() {
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: 'Trip Info',
            color: kTextColor4,
            weight: FontWeight.w900,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                size: 15,
              ),
              const SizedBox(
                width: 10,
              ),
              MyText(
                text: 'Saturday, 15th May 2021',
                color: kGreyColor4,
                weight: FontWeight.w500,
                fontFamily: AppFonts.SYNE,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.schedule,
                size: 15,
              ),
              const SizedBox(
                width: 10,
              ),
              MyText(
                  text: '2 hr 45 minutes (Estimated)',
                  color: kGreyColor4,
                  weight: FontWeight.w500,
                  fontFamily: AppFonts.SYNE)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.route,
                size: 15,
              ),
              const SizedBox(
                width: 10,
              ),
              MyText(
                text: '110 km',
                color: kGreyColor8,
                weight: FontWeight.w500,
              )
            ],
          ),
          const Divider(
            color: kDarkGreyColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const StepperLeadingIcon(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 5, horizontal: Get.width * 0.06),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 80,
                        child: CustomPaint(
                          painter: DashedLineVerticalPainter(),
                        ),
                      ),
                    ),
                  ),
                  const StepperLeadingIcon(),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              locationWidget(),
            ],
          ),
          const Divider(
            color: kGreyColor8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: 'Seats left',
                color: kGreyColor8,
              ),
              MyText(
                text: '2',
                color: kDarkGreyColor,
                weight: FontWeight.w800,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: 'Price for one seat ',
                color: kGreyColor8,
              ),
              MyText(
                text: '240',
                color: kDarkGreyColor,
                weight: FontWeight.w800,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: 'Pay via wallet, Cash or Card',
                color: kGreyColor8,
                size: 12,
              ),
            ],
          )
        ],
      ),
    );
  }

  locationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText(
          text: 'Islamabad, Soan Gardens Society \nBlock C Street 8',
          color: kTextColor4,
          weight: FontWeight.w700,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.directions_walk,
              color: Colors.orange,
              size: 15,
            ),
            MyText(
              text: '4 km from your pickup location',
              color: kGreyColor8,
              weight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        MyText(
          text: 'Islamabad, G8 Markaz',
          color: kTextColor4,
          weight: FontWeight.w700,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.directions_walk,
              color: kGreenColor,
              size: 15,
            ),
            MyText(
              text: '1.5 km from your drop location',
              color: kGreyColor8,
              weight: FontWeight.w500,
            ),
          ],
        ),
        MyText(
          text: '2:30 PM',
          color: kGreyColor8,
          weight: FontWeight.w500,
        ),
      ],
    );
  }
}

class SelectSeat extends StatelessWidget {
  const SelectSeat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cont = Get.put<RideDetailsController>(RideDetailsController());
    return Container(
      height: Get.height * 0.6,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        color: kBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 15,
        ),
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: MyText(text: 'Close')),
                const Spacer(),
                Center(
                  child: MyText(
                    text: "Select Seats",
                    size: 18,
                    weight: FontWeight.w700,
                    fontFamily: AppFonts.DM_SANS,
                  ),
                ),
                const Spacer(
                  flex: 2,
                )
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 28,
            ),
            GetBuilder<RideDetailsController>(builder: (cont) {
              return Row(
                children: [
                  incOrDecButton(
                    icon: const Center(
                        child: Icon(
                      Icons.remove,
                      color: kPrimaryColor,
                    )),
                    onTap: () {
                      RideDetailsController.instance.decrementSeats();
                    },
                  ),
                  const Spacer(),
                  MyText(
                    text:
                        RideDetailsController.instance.numberOfSeats.toString(),
                    size: 20,
                    color: kBlackColor,
                    weight: FontWeight.w900,
                  ),
                  const Spacer(),
                  incOrDecButton(
                    icon: const Icon(
                      Icons.add,
                      color: kPrimaryColor,
                    ),
                    onTap: () {
                      RideDetailsController.instance.incrementSeats();
                    },
                  ),
                ],
              );
            }),
            RotatedBox(
                quarterTurns: 5,
                child: Image.asset(
                  Assets.car,
                  height: 100,
                )),
            MyButton(
                radius: 5,
                buttonText: 'Confirm Seats',
                textColor: Colors.white,
                bgColor: kPrimaryColor,
                onTap: () {
                  Get.back();
                })
          ],
        ),
      ),
    );
  }

  incOrDecButton({Widget? icon, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: kPrimaryColor,
        child: CircleAvatar(
            backgroundColor: Colors.white, radius: 18, child: icon),
      ),
    );
  }
}

void showSelectSeatsBottomSheet() {
  showModalBottomSheet<void>(
    context: Get.context!,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const SelectSeat(),
      );
    },
  );
}
