import 'package:casa_vertical_stepper/casa_vertical_stepper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/screens/google_maps_screen/google_maps_screen.dart';
import 'package:route_partners/screens/widget/custom_drop_down_widget.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  String? selectedSeatsValue = '1';
  String? price = '50';
  int? index = 0;
  int _currentIndex = 0;
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<String> _tabs = [
    'FIND A RIDE',
    'OFFER A RIDE',
  ];

  // ignore: unused_field
  final List<Widget> _children = [
    // BackCamera(),
    // DSLR(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: List.generate(
                  _tabs.length,
                  (index) {
                    return Flexible(
                      child: GestureDetector(
                        onTap: () => _onTap(index),
                        child: AnimatedContainer(
                          width: Get.width * 0.35,
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          height: Get.height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: _currentIndex == index
                                ? kPrimaryColor
                                : kGreyColor9,
                          ),
                          child: Center(
                            child: MyText(
                              text: _tabs[index],
                              size: 13,
                              weight: FontWeight.w900,
                              color: _currentIndex == index
                                  ? kWhiteColor2
                                  : kGreyColor3,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  stepperContainer(
                    title: 'Enter Pickup Location',
                    onTap: () {
                      Get.to(() => const GoogleMapsScreen());
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
                    onTap: () {
                      Get.to(() => const GoogleMapsScreen());
                    },
                  ),
                ],
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
              InkWell(
                onTap: () {
                  selectDate(context);
                },
                child: Container(
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
              ),
              const Divider(
                color: kGreyColor8,
              ),
              _currentIndex == 1
                  ? Column(
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
                              child: CustomDropDown(
                                  heading: 'Available Seats',
                                  hint: 'Select Available Seats',
                                  selectedValue: selectedSeatsValue,
                                  items: const [
                                    // 'Choose Option'
                                    '1',
                                    '2',
                                    '3',
                                    '4',
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSeatsValue = value;
                                    });
                                  }),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Expanded(
                              child: CustomDropDown(
                                  heading: 'Price per seat',
                                  hint: 'Select Available Seats',
                                  selectedValue: price,
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
                                    setState(() {
                                      price = value;
                                    });
                                  }),
                            ),
                          ],
                        ),
                        MyButton(
                            width: Get.width,
                            radius: 5,
                            buttonText: 'SEARCH',
                            bgColor: kGreyColor4,
                            textColor: Colors.white,
                            onTap: () {}),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < 4; i++)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                    for (int i = 0; i < 3; i++) const RecentSearchesWidget()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  stepperContainer({String? title, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(color: kGreyColor9),
        height: Get.height * 0.07,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
            Text(
              '$title',
              style: const TextStyle(color: kGreyColor8),
            ),
          ],
        ),
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
      radius: 15,
      backgroundColor: kGreyColor3,
      child: CircleAvatar(
        radius: 14,
        backgroundColor: kWhiteColor2,
        child: CircleAvatar(
          radius: 8.5,
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
