import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/create_ride_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/utils/formatters/date_fromatter.dart';
import 'package:route_partners/core/utils/snackbars.dart';
import 'package:route_partners/screens/browse_rides/browse_rides.dart';
import 'package:route_partners/screens/google_maps_screen/google_maps_screen.dart';
import 'package:route_partners/screens/publish_ride/publish_ride.dart';
import 'package:route_partners/screens/widget/custom_drop_down_widget.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? price = '50';
  int? index = 0;

  final _createRideController = Get.find<CreateRideController>();

  Future<DateTime> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      return picked;
    }
    return DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: simpleAppBar(
            title: 'Carpool',
            haveLeading: false,
            centerTitle: false,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.bell,
                    color: kTextColor,
                  )),
              const SizedBox(
                width: 10,
              )
            ]),
        body: SafeArea(
          minimum: const EdgeInsets.all(20).copyWith(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              TabBar(tabs: [
                Tab(
                  child: MyText(
                    text: 'Find a ride',
                    size: 13,
                    weight: FontWeight.w900,
                    color: kGreyColor3,
                  ),
                ),
                Tab(
                  child: MyText(
                    text: 'Create a ride',
                    size: 13,
                    weight: FontWeight.w900,
                    color: kGreyColor3,
                  ),
                ),
              ]),

              Expanded(
                child: TabBarView(children: [
                  ListView(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // stepperContainer(
                      //   title: 'Enter Pickup Location',
                      //   onTap: () {
                      //     // Get.to(() => const GoogleMapsScreen());
                      //   },
                      // ),
                      const Stack(
                        children: [],
                      ),
                      stepperContainer(
                        title: 'Enter Pickup Location',
                        onTap: () {
                          Get.to(() => const GoogleMapsScreen());
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: Get.width * 0.06),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                height: 20,
                                child: CustomPaint(
                                  painter: DashedLineVerticalPainter(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: Get.width * 0.06),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                  height: 20,
                                  child: FaIcon(
                                    FontAwesomeIcons.arrowDown,
                                    color: kPrimaryColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      stepperContainer(
                        title: 'Enter Drop Location',
                        onTap: () {
                          Get.to(() => const GoogleMapsScreen());
                        },
                      ),
                      MyText(
                        text: 'Date of Departure',
                        color: kGreyColor6,
                        weight: FontWeight.w900,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          selectDate(context);
                        },
                        child: Row(
                          children: [
                            MyText(
                              text: 'Saturday, 15th May',
                              color: kGreyColor8,
                              weight: FontWeight.w700,
                            ),
                            const Spacer(),
                            TextButton(
                                onPressed: () {},
                                child: MyText(
                                  text: 'TODAY',
                                  weight: FontWeight.w900,
                                  color: kPrimaryColor,
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: MyText(
                                  text: 'TOMORROW',
                                  weight: FontWeight.w900,
                                  color: kGreyColor5,
                                ))
                          ],
                        ),
                      ),
                      const Divider(
                        color: kGreyColor8,
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),

                      MyButton(
                        onTap: () {
                          Get.to(()=> const BrowseRides());
                        },
                        bgColor: kPrimaryColor,
                        buttonText: 'SEARCH',
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < 4; i++)
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                height: Get.height * 0.14,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: const Color(0xFF9C9BC6)),
                                child: Row(
                                  children: [
                                    Image.asset(Assets.boyIcon),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MyText(
                                          text:
                                              'Covid-19 Show Soliditary & Travel Safe',
                                          color: Colors.white,
                                          weight: FontWeight.w700,
                                        ),
                                        MyText(
                                          text: 'See our recommendations >',
                                          color: Colors.white,
                                          weight: FontWeight.w700,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        color: kGreyColor8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: 'Recent Searches',
                            weight: FontWeight.w900,
                          ),
                          MyText(
                            text: 'See All',
                            color: kGreyColor,
                            weight: FontWeight.w500,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < 3; i++)
                              const RecentSearchesWidget()
                          ],
                        ),
                      )
                    ],
                  ),

                  ///-----------------///

                  ListView(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 10),
                      stepperContainer(
                        title: 'Enter Pickup Location',
                        controller:
                            _createRideController.pickupLocationController,
                        onTap: () {
                          Get.to(
                            () => GoogleMapsScreen(
                              controller: _createRideController
                                  .pickupLocationController,
                            ),
                          );
                        },
                      ),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: Get.width * 0.06),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    height: 20,
                                    child: CustomPaint(
                                      painter: DashedLineVerticalPainter(),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: Get.width * 0.06),
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                      height: 20,
                                      child: FaIcon(
                                        FontAwesomeIcons.arrowDown,
                                        color: kPrimaryColor,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      stepperContainer(
                        title: 'Enter Drop Location',
                        controller:
                            _createRideController.dropoffLocationController,
                        onTap: () {
                          Get.to(() => GoogleMapsScreen(
                                controller: _createRideController
                                    .dropoffLocationController,
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      MyText(
                        text: 'Date of Departure',
                        color: kGreyColor6,
                        weight: FontWeight.w900,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => MyText(
                                text: DateFormatters.instance.formatStringDate(
                                    date: _createRideController
                                        .selectedDate.value),
                                color: kGreyColor8,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                _createRideController.selectedDate.value =
                                    await selectDate(context);
                              },
                              icon: const Icon(
                                Icons.calendar_month_outlined,
                                color: kGreyColor6,
                              )),
                        ],
                      ),
                      const Divider(
                        color: kGreyColor8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          MyText(
                            text: 'Enter your vehicle name',
                            color: kGreyColor6,
                            weight: FontWeight.w900,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Enter your vehicle name',
                            fillColor: kGreyColor9,
                            filled: true,
                            focusBorderColor: kGreyColor9,
                            controller:
                                _createRideController.vehicleNameController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => CustomDropDown(
                                      heading: 'Available Seats',
                                      hint: 'Select Available Seats',
                                      selectedValue: _createRideController
                                          .selectedSeats.value,
                                      items: const [
                                        // 'Choose Option'
                                        '1',
                                        '2',
                                        '3',
                                        '4',
                                      ],
                                      onChanged: (value) {
                                        _createRideController
                                            .selectedSeats.value = value;
                                      }),
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                child: Obx(
                                  () => CustomDropDown(
                                      heading: 'Price per seat',
                                      hint: 'Select Available Seats',
                                      selectedValue: _createRideController
                                          .selectedSeatPrice.value,
                                      items: const [
                                        // 'Choose Option'
                                        '50',
                                        '100',
                                        '150',
                                        '200',
                                        '250',
                                        '300',
                                        '350',
                                      ],
                                      onChanged: (value) {
                                        _createRideController
                                            .selectedSeatPrice.value = value;
                                      }),
                                ),
                              ),
                            ],
                          ),
                          MyButton(
                            width: Get.width,
                            radius: 5,
                            buttonText: 'CREATE',
                            bgColor: kGreyColor4,
                            textColor: Colors.white,
                            onTap: () {
                              final customSnackbars = CustomSnackBars.instance;
                              if (_createRideController
                                      .pickupLocationController.text.isEmpty ||
                                  _createRideController
                                      .dropoffLocationController.text.isEmpty) {
                                customSnackbars.showFailureSnackbar(
                                    title: 'Error',
                                    message: 'Addresses are required');
                              } else if (_createRideController
                                  .vehicleNameController.text.isEmpty) {
                                customSnackbars.showFailureSnackbar(
                                    title: 'Error',
                                    message: 'Vehicle name is required ');
                              } else {
                                Get.to(() => PublishRideScreen());
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0; i < 4; i++)
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    height: Get.height * 0.14,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: const Color(0xFF9C9BC6)),
                                    child: Row(
                                      children: [
                                        Image.asset(Assets.boyIcon),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            MyText(
                                              text:
                                                  'Covid-19 Show Soliditary & Travel Safe',
                                              color: Colors.white,
                                              weight: FontWeight.w700,
                                            ),
                                            MyText(
                                              text: 'See our recommendations >',
                                              color: Colors.white,
                                              weight: FontWeight.w700,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: kGreyColor8,
                          ),
                        ],
                      )
                    ],
                  ),
                ]),
              ),

              ///--------------------------------------------------------------------------///
            ],
          ),
        ),
      ),
    );
  }

  stepperContainer(
      {TextEditingController? controller,
      void Function()? onTap,
      String? title}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          const Stack(
            children: [
              StepperLeadingIcon(),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: MyTextField(
              controller: controller,
              hintText: '$title',
              readonly: true,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class RecentSearchesWidget extends StatelessWidget {
  const RecentSearchesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.8,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          color: kLightGreyColor6, borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(15).copyWith(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: 'Gol Market, Meerut -> Sector 29 Gurgoon',
            color: kTextColor,
            weight: FontWeight.w900,
          ),
          const SizedBox(
            height: 10,
          ),
          MyText(
            text: '25th March : 10:00 AM',
            color: kGreyColor8,
            weight: FontWeight.w900,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.person,
                size: 15,
                color: kGreyColor8,
              ),
              const SizedBox(
                width: 5,
              ),
              MyText(
                text: '2 Seats',
                color: kGreyColor8,
                weight: FontWeight.w900,
              ),
            ],
          ),
          const Divider(
            height: 10,
            color: kBlackColor,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const FaIcon(
                FontAwesomeIcons.ellipsis,
                color: kGreyColor8,
              ),
              MyText(
                text: 'SEARCH',
                weight: FontWeight.w900,
                color: kPrimaryColor,
              )
            ],
          )
        ],
      ),
    );
  }
}

class StepperLeadingIcon extends StatelessWidget {
  const StepperLeadingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 10,
      backgroundColor: kGreyColor3,
      child: CircleAvatar(
        radius: 8,
        backgroundColor: kWhiteColor2,
        child: CircleAvatar(
          radius: 5.5,
          backgroundColor: kGreyColor3,
        ),
      ),
    );
  }
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kGreyColor3
      ..strokeWidth = 2;
    const dashWidth = 5;
    const dashSpace = 3;
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
