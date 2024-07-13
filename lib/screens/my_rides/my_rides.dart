import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class MyRides extends StatelessWidget {
  const MyRides({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: MyText(
            text: 'My Rides',
            size: 20,
            color: kBlackColor,
            weight: FontWeight.w900,
          ),
          bottom: const TabBar(
            unselectedLabelColor: kGreyColor8,
            indicatorWeight: 3.5,
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: kGreyColor4,
            labelStyle:
                TextStyle(color: kGreyColor7, fontWeight: FontWeight.w900),
            indicatorColor: kPrimaryColor,
            tabs: [
              Tab(
                text: 'Booked Rides',
              ),
              Tab(text: 'Published Rides'),
            ],
          ),
        ),
        body: Padding(
          padding: AppSizes.DEFAULT,
          child: Column(
            children: [
              MyTextField(
                radius: 10,
                underLineBorderColor: kWhiteColor2,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                fillColor: kGreyColor9,
                hintText: 'Search in "My Rides"',
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const RideWidget();
                      },
                    ),

                    ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const PublishedRides();
                      },
                    ),
                    // Booked Rides tab content

                    // Published Rides tab content
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RideWidget extends StatelessWidget {
  const RideWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: AppSizes.DEFAULT,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              MyText(
                text: 'Gurgoon -> Meerut',
                color: kDarkGreyColor,
                weight: FontWeight.w900,
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 185, 223, 186)),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: MyText(
                  text: 'Upcoming',
                  color: kSecondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Icon(Icons.calendar_month),
              const SizedBox(
                width: 5,
              ),
              MyText(
                text: 'Saturday, 15th May 2024',
                color: kGreyColor3,
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Icon(Icons.timer_sharp),
              const SizedBox(
                width: 5,
              ),
              MyText(
                text: '11:30 AM - 2:30 PM',
                color: kGreyColor3,
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Icon(Icons.person_2_outlined),
              const SizedBox(
                width: 5,
              ),
              MyText(
                text: '1 Person',
                color: kGreyColor3,
              )
            ],
          ),
          const SizedBox(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 20,
              child: Image.asset(
                Assets.boyIcon,
                width: Get.height * 0.04,
                height: Get.height * 0.08,
                fit: BoxFit.contain,
              ),
            ),
            title: MyText(
              text: 'Arjun Singh',
              color: kBlackColor,
            ),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(
                  text: '4.5 *',
                  color: kBlackColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                MyText(
                  text: '27 ratings',
                  color: kBlackColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PublishedRides extends StatelessWidget {
  const PublishedRides({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: AppSizes.DEFAULT,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              MyText(
                text: 'Gurgoon -> Meerut',
                color: kDarkGreyColor,
                weight: FontWeight.w900,
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          MyText(
            text: '160 per seat',
            color: kDarkGreyColor,
            weight: FontWeight.w900,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(Icons.calendar_month),
              const SizedBox(
                width: 5,
              ),
              MyText(
                text: 'Saturday, 15th May 2024',
                color: kGreyColor3,
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Icon(Icons.timer_sharp),
              const SizedBox(
                width: 5,
              ),
              MyText(
                text: '11:30 AM - 2:30 PM',
                color: kGreyColor3,
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Icon(Icons.person_2_outlined),
              const SizedBox(
                width: 5,
              ),
              MyText(
                text: '2 Seats Booked',
                color: kGreyColor3,
              )
            ],
          ),
          const Divider(),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.5,
                child: MyText(
                  text: 'Published on 19th May 2021 : 02:45',
                  color: kGreyColor3,
                ),
              ),
              const Spacer(),
              const Icon(Icons.remove_red_eye_outlined),
              MyText(
                text: '32 Views',
                color: kGreyColor3,
              ),
            ],
          )
        ],
      ),
    );
  }
}
