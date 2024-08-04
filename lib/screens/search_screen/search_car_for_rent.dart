// ignore_for_file: library_private_types_in_public_api, unused_local_variable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/screens/browse_cars/browse_cars.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

List<String> transmission = ['Automatic', 'Manual'];
List<String> fueltype = ['Petrol', 'Diesel', 'CNG', 'Hybrid'];

class SearchForCars extends StatefulWidget {
  const SearchForCars({super.key});

  @override
  State<SearchForCars> createState() => _SearchForCarsState();
}

class _SearchForCarsState extends State<SearchForCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: simpleAppBar(title: 'Search for cars'),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                MyText(
                  text: 'Search by City',
                  size: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  radius: 10,
                  hintText: 'Search City',
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Distance in Kms ",
                      size: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: MyTextField(),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        const Text(
                          '-',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: MyTextField(),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Price Per Hour range",
                      size: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: MyTextField(),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        const Text(
                          '-',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: MyTextField(),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Model Year Range",
                      size: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: MyTextField(),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        const Text(
                          '-',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: MyTextField(),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),

                const SizedBox(
                  height: 15,
                ),
                // const BoldTitle(
                //   title: 'Registered in',
                //   fontSize: 15,
                // ),
                // const CustomTextField(
                //   borderRadius: 10,
                //   prefixIcon: Icon(Icons.search),
                //   hintText: 'Search Province, City',
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // const BoldTitle(
                //   title: 'Transmission',
                //   fontSize: 15,
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // SizedBox(
                //   height: 50,
                //   child: ListView.separated(
                //       padding: const EdgeInsets.symmetric(horizontal: 10),
                //       separatorBuilder: (context, index) => const SizedBox(
                //             width: 0.05,
                //           ),
                //       itemCount: transmission.length,
                //       scrollDirection: Axis.horizontal,
                //       shrinkWrap: true,
                //       itemBuilder: (context, index) {
                //         return TextContainer(
                //           color: ColorManager.kblackColor,
                //           margin: true,
                //           texts: transmission[index],
                //         );
                //       }),
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // const BoldTitle(
                //   title: 'Transmission',
                //   fontSize: 15,
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // SizedBox(
                //   height: 50,
                //   child: ListView.separated(
                //       padding: const EdgeInsets.symmetric(horizontal: 10),
                //       separatorBuilder: (context, index) => const SizedBox(
                //             width: 0.05,
                //           ),
                //       itemCount: fueltype.length,
                //       scrollDirection: Axis.horizontal,
                //       shrinkWrap: true,
                //       itemBuilder: (context, index) {
                //         return TextContainer(
                //           color: ColorManager.kblackColor,
                //           margin: true,
                //           texts: fueltype[index],
                //         );
                //       }),
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Engine Capacity",
                      size: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: OutlinedButton(
                          style: ButtonStyle(
                              padding: const WidgetStatePropertyAll(
                                  EdgeInsets.all(16)),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                          onPressed: () {},
                          child: const Text(
                            'Clear All',
                            style: TextStyle(fontSize: 16, color: kBlackColor),
                          ),
                        )),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 7,
                      child: MyButton(
                          buttonText: 'Search',
                          onTap: () {
                            Get.to(()=> FoundCarsForRent());
                          },
                          bgColor: kPrimaryColor,
                          textColor: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class RangeSliders extends StatefulWidget {
  final String? title;

  const RangeSliders({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  _RangeSlidersState createState() => _RangeSlidersState();
}

class _RangeSlidersState extends State<RangeSliders> {
  RangeValues _currentRangeValues = const RangeValues(0.1, 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: widget.title ?? '',
          size: 15,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // TextContainer(
            //   texts:
            //       '     ${(_currentRangeValues.start * 7000000 + 10000).toStringAsFixed(0)}    ',
            //   color: Colors.black,
            // ),
            const Text(
              '-',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            MyText(
              text:
                  '     ${(_currentRangeValues.end * 7000000 + 10000).toStringAsFixed(0)}     ',
              color: Colors.black,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        RangeSlider(
          activeColor: kPrimaryColor,
          values: _currentRangeValues,
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          },
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class TextContainer extends StatelessWidget {
  final bool? bottomSheetOpen;
  final bool? filters;
  final String? texts;
  final Color? color;
  final bool? margin;
  const TextContainer({
    super.key,
    this.texts,
    this.filters = false,
    this.color = Colors.blueGrey,
    this.margin = false,
    this.bottomSheetOpen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: filters == false ? const EdgeInsets.all(4) : EdgeInsets.zero,
      child: InkWell(
        onTap: () {},
        child: Container(
            margin: margin == true
                ? const EdgeInsets.symmetric(horizontal: 8).copyWith(left: 0)
                : EdgeInsets.zero,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFFEEF2F6)),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '$texts',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: color, fontSize: Get.height * 0.017),
                ),
                const SizedBox(
                  width: 1,
                ),
                filters == true
                    ? const Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 15,
                      )
                    : const SizedBox()
              ],
            )),
      ),
    );
  }
}
