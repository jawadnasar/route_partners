import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/screens/ride_details/ride_details.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class BrowseRides extends StatefulWidget {
  const BrowseRides({super.key});

  @override
  State<BrowseRides> createState() => _BrowseRidesState();
}

class _BrowseRidesState extends State<BrowseRides>
    with TickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
          leadingIconColor: kWhiteColor2,
          bgColor: kPrimaryColor,
          titleColor: kWhiteColor2,
          title: 'Islamabad -> RawalPindi'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
                labelColor: kPrimaryColor,
                labelStyle: const TextStyle(color: kPrimaryColor),
                indicatorWeight: 3.0,
                dividerColor: kGreyColor8,
                indicatorPadding: const EdgeInsets.all(0),
                dividerHeight: 20,
                isScrollable: true,
                controller: controller,
                tabs: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Departure',
                      style: TextStyle(color: kGreyColor8),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Price',
                      style: TextStyle(color: kGreyColor8),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Ratings',
                      style: TextStyle(color: kGreyColor8),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Seat Availability',
                      style: TextStyle(color: kGreyColor8),
                    ),
                  ),
                ]),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Showing 8 results',
              style: TextStyle(color: kGreyColor8),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(()=> const RideDetails());
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText(
                                      text: 'Rawalpind -> Islamabad',
                                      color: kTextColor,
                                      size: 12,
                                      weight: FontWeight.w700,
                                    ),
                                    MyText(
                                      text: '240 rs',
                                      color: kTextColor,
                                      size: 12,
                                      weight: FontWeight.w700,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText(
                                      text: '11:30 AM - 2:30 Pm',
                                      size: 12,
                                      color: kGreyColor8,
                                      weight: FontWeight.w900,
                                    ),
                                    MyText(
                                      text: '2 Seats left',
                                      size: 12,
                                      color: kGreyColor8,
                                      weight: FontWeight.w900,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.person,
                                      size: 10,
                                      color: kGreenColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    MyText(
                                      text: '6 km',
                                      size: 12,
                                      color: kGreyColor8,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 10,
                                      color: kGreyColor8,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const FaIcon(
                                      FontAwesomeIcons.car,
                                      size: 10,
                                      color: kGreyColor8,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 10,
                                      color: kGreyColor8,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    MyText(
                                      text: '1.5 km',
                                      color: kGreyColor8,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const FaIcon(
                                      FontAwesomeIcons.person,
                                      size: 10,
                                      color: Colors.yellow,
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: kGreyColor8,
                                ),
                               const DriverProfileDetails()
                              ])),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class DriverProfileDetails extends StatelessWidget {
  const DriverProfileDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        visualDensity: VisualDensity.comfortable,
        contentPadding: EdgeInsets.zero,
        leading: const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(Assets.boyIcon),
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Assets.covidFree),
            const SizedBox(width: 10,),
            const FaIcon(FontAwesomeIcons.bolt),
            const SizedBox(width: 10,),
            Image.asset(Assets.travelbag)
          ],
        ),
        );
  }
}
