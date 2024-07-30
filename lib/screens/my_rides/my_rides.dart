import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:route_partners/controllers/all_rides_controller.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/controllers/chat_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/constants/app_sizes.dart';
import 'package:route_partners/model/ride_request_model.dart';
import 'package:route_partners/screens/chat_screens/chat_screen.dart';
import 'package:route_partners/screens/google_maps_screen/google_map_route_screen.dart';
import 'package:route_partners/screens/widget/common_image_view_widget.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class MyRides extends StatelessWidget {
  MyRides({super.key});
  final _allRideController = Get.find<AllRidesController>();

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
          child: TabBarView(
            children: [
              // Booked Rides tab content

              StreamBuilder(
                stream: _allRideController.getBookedRides(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    );
                  } else if (!snapshot.hasData) {
                    return Center(child: MyText(text: 'No Available Rides'));
                  }
                  List<RideRequestModel> requests = [];
                  snapshot.data?.docs.forEach(
                    (doc) {
                      final Map<String, dynamic> data =
                          doc.data() as Map<String, dynamic>;
                      requests.add(RideRequestModel.fromMap(data));
                    },
                  );
                  return requests.isEmpty
                      ? Center(child: MyText(text: 'No Available Rides'))
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: requests.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return RideWidget(
                              request: requests[index],
                            );
                          },
                        );
                },
              ),

              // Published Rides tab content

              StreamBuilder(
                stream: _allRideController.getPublishedRides(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    );
                  } else if (!snapshot.hasData) {
                    return Center(child: MyText(text: 'No Available Rides'));
                  }
                  List<RideRequestModel> requests = [];
                  snapshot.data?.docs.forEach(
                    (doc) {
                      final Map<String, dynamic> data =
                          doc.data() as Map<String, dynamic>;
                      requests.add(RideRequestModel.fromMap(data));
                    },
                  );
                  return requests.isEmpty
                      ? Center(child: MyText(text: 'No Available Rides'))
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: requests.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return PublishedRides(
                              request: requests[index],
                            );
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RideWidget extends StatelessWidget {
  final RideRequestModel request;

  const RideWidget({
    required this.request,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _chatController = Get.find<ChatController>();
    final _authController = Get.find<AuthController>();
    return GestureDetector(
      onTap: () {
        if (request.status != 'Rejected') {
          Get.to(() => GoogleMapRoute(
                startLoc: request.pickupLocation!,
                endLoc: request.dropoffLocation!,
                name: request.ownerName ?? 'Driver',
                dropoffAddress: request.dropOfAddress!,
                pickupAddress: request.pickupAddress!,
                pricePerSeat: request.pricePerSeat ?? '50',
                phoneNumber: request.ownerPhoneNumber ?? '+923211010101',
                publishedDate: request.publishDate ?? DateTime.now(),
                rideDate: request.rideDate ?? DateTime.now(),
                vehicleName: request.vehicleName ?? 'Other Car',
                isCustomerInfo: false,
              ));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: AppSizes.DEFAULT,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: MyText(
                    text:
                        '${request.pickupAddress} ➡️ ${request.dropOfAddress}',
                    color: kDarkGreyColor,
                    weight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            MyText(
              text: '${request.selectedSeats} seats selected',
              color: kDarkGreyColor,
              weight: FontWeight.w900,
            ),
            const SizedBox(
              height: 15,
            ),
            MyText(
              text: '${request.pricePerSeat} per seat',
              color: kDarkGreyColor,
              weight: FontWeight.w900,
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
                  text: DateFormat('d MMMM, h:mm a')
                      .format(request.rideDate ?? DateTime.now()),
                  color: kGreyColor3,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            request.status == 'Accepted'
                ? GestureDetector(
                    onTap: () async {
                      // openComingSoonDialog();
                      final ref = await _chatController.getOrCreateChat(
                          request.ownerId!, request.requestedUserId!);

                      Get.to(() => ChatScreen(
                          chatId: ref.id,
                          currentUserId:
                              _authController.userModel.value!.userId!));
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.message),
                        const SizedBox(
                          width: 5,
                        ),
                        MyText(
                          text: 'Chat',
                          color: kGreyColor3,
                        ),
                      ],
                    ),
                  )
                : Container(),
            // Row(
            //   children: [
            //     const Icon(Icons.timer_sharp),
            //     const SizedBox(
            //       width: 5,
            //     ),
            //     MyText(
            //       text: '11:30 AM - 2:30 PM',
            //       color: kGreyColor3,
            //     )
            //   ],
            // ),
            const SizedBox(
              height: 15,
            ),
            // Row(
            //   children: [
            //     const Icon(Icons.person_2_outlined),
            //     const SizedBox(
            //       width: 5,
            //     ),
            //     MyText(
            //       text: '1 Person',
            //       color: kGreyColor3,
            //     )
            //   ],
            // ),
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
                text: request.ownerName ?? 'Driver',
                color: kBlackColor,
              ),
              trailing: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: request.status == 'Rejected'
                        ? Colors.red
                        : request.status == 'Accepted'
                            ? kPrimaryColor
                            : request.status == 'Completed'
                                ? Colors.green
                                : request.status == 'Requested'
                                    ? Colors.amber
                                    : Colors.white),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: MyText(
                  text: request.status == 'Requested'
                      ? 'Requested'
                      : request.status == 'Rejected'
                          ? 'Rejected'
                          : request.status == 'Accepted'
                              ? 'Upcoming'
                              : 'Completed',
                  color: Colors.white,
                ),
              ),
              // subtitle: Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     MyText(
              //       text: '4.5 *',
              //       color: kBlackColor,
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     MyText(
              //       text: '27 ratings',
              //       color: kBlackColor,
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

class PublishedRides extends StatelessWidget {
  final RideRequestModel request;
  PublishedRides({
    required this.request,
    super.key,
  });
  final _allRideController = Get.find<AllRidesController>();

  @override
  Widget build(BuildContext context) {
    final chatController = Get.find<ChatController>();
    final authController = Get.find<AuthController>();
    return GestureDetector(
      onTap: () {
        if (request.status == 'Rejected') {
          return;
        } else if (request.status == 'Published') {
          Get.to(() => GoogleMapRoute(
                startLoc: request.pickupLocation!,
                endLoc: request.dropoffLocation!,
                name: request.ownerName ?? 'Driver',
                dropoffAddress: request.dropOfAddress!,
                pickupAddress: request.pickupAddress!,
                pricePerSeat: request.pricePerSeat ?? '50',
                phoneNumber: request.ownerPhoneNumber ?? '+923211010101',
                publishedDate: request.publishDate ?? DateTime.now(),
                rideDate: request.rideDate ?? DateTime.now(),
                vehicleName: request.vehicleName ?? 'Other Car',
                isCustomerInfo: false,
              ));
        } else {
          Get.to(() => GoogleMapRoute(
                startLoc: request.pickupLocation!,
                endLoc: request.dropoffLocation!,
                name: request.requestedUserName ?? 'User',
                dropoffAddress: request.dropOfAddress!,
                pickupAddress: request.pickupAddress!,
                pricePerSeat: request.pricePerSeat ?? '50',
                phoneNumber:
                    request.requestedUserPhoneNumber ?? '+923211010101',
                publishedDate: request.publishDate ?? DateTime.now(),
                rideDate: request.rideDate ?? DateTime.now(),
                vehicleName: request.vehicleName ?? 'Other Car',
                isCustomerInfo: true,
              ));
        }
      },
      child: Container(
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
                Expanded(
                  child: MyText(
                    text:
                        '${request.pickupAddress} ➡️ ${request.dropOfAddress}',
                    color: kDarkGreyColor,
                    weight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            MyText(
              text: '${request.availableSeats} seats available',
              color: kDarkGreyColor,
              weight: FontWeight.w900,
            ),
            const SizedBox(
              height: 15,
            ),
            if (request.status == 'Requested' ||
                request.status == 'Rejected' ||
                request.status == 'Accepted' ||
                request.status == 'Completed') ...[
              MyText(
                text: '${request.selectedSeats ?? '0'} seats selected',
                color: kDarkGreyColor,
                weight: FontWeight.w900,
              ),
              const SizedBox(
                height: 15,
              ),
            ],
            MyText(
              text: '${request.pricePerSeat} per seat',
              color: kDarkGreyColor,
              weight: FontWeight.w900,
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
                  text: DateFormat('d MMMM, h:mm a')
                      .format(request.rideDate ?? DateTime.now()),
                  color: kGreyColor3,
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            request.status == 'Accepted'
                ? GestureDetector(
                    onTap: () async {
                      // openComingSoonDialog();
                      final ref = await chatController.getOrCreateChat(
                          request.ownerId!, request.requestedUserId!);

                      Get.to(() => ChatScreen(
                          chatId: ref.id,
                          currentUserId:
                              authController.userModel.value!.userId!));
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.message),
                        const SizedBox(width: 3),
                        MyText(
                          text: 'Chat',
                          color: kGreyColor3,
                        ),
                      ],
                    ),
                  )
                : Container(),
            // Row(
            //   children: [
            //     const Icon(Icons.timer_sharp),
            //     const SizedBox(
            //       width: 5,
            //     ),
            //     MyText(
            //       text: '11:30 AM - 2:30 PM',
            //       color: kGreyColor3,
            //     )
            //   ],
            // ),
            const SizedBox(
              height: 15,
            ),
            // Row(
            //   children: [
            //     const Icon(Icons.person_2_outlined),
            //     const SizedBox(
            //       width: 5,
            //     ),
            //     MyText(
            //       text: '2 Seats Booked',
            //       color: kGreyColor3,
            //     )
            //   ],
            // ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: MyText(
                    text:
                        'Published on ${DateFormat('d MMMM, h:mm a').format(request.publishDate ?? DateTime.now())}',
                    color: kGreyColor3,
                  ),
                ),
                SizedBox(width: Get.width * 0.05),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: request.status == 'Rejected'
                            ? Colors.red
                            : request.status == 'Accepted'
                                ? kPrimaryColor
                                : request.status == 'Completed'
                                    ? Colors.green
                                    : request.status == 'Published'
                                        ? Colors.amber
                                        : Colors.white),
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: MyText(
                      textAlign: TextAlign.center,
                      text: request.status == 'Published'
                          ? 'Published'
                          : request.status == 'Requested'
                              ? 'Requested'
                              : request.status == 'Accepted'
                                  ? 'Upcoming'
                                  : request.status == 'Rejected'
                                      ? 'Rejected'
                                      : request.status == 'Completed'
                                          ? 'Completed'
                                          : '',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            request.status == 'Rejected' || request.status == 'Completed'
                ? Container()
                : request.status == 'Published'
                    ? MyBorderButton(
                        onTap: () {
                          Get.dialog(
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              title: Center(
                                child: MyText(
                                  text: 'Un Publish',
                                  weight: FontWeight.bold,
                                ),
                              ),
                              content: ListView(shrinkWrap: true, children: [
                                MyText(
                                  textAlign: TextAlign.center,
                                  text:
                                      'Are you sure you want to un publish this ride?',
                                  color: kPrimaryColor,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: MyButton(
                                        onTap: () {
                                          Get.back();
                                        },
                                        buttonText: 'No',
                                        bgColor: Colors.red,
                                        textColor: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: MyButton(
                                        onTap: () async {
                                          Get.back();
                                          await _allRideController
                                              .unPublishRide(
                                                  request.requestId ?? '');
                                        },
                                        buttonText: 'Yes',
                                        textColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          );
                        },
                        buttonText: 'Un Publish Ride',
                        borderColor: Colors.red,
                        textColor: Colors.red,
                      )
                    : request.status == 'Accepted'
                        ? MyBorderButton(
                            onTap: () {
                              Get.dialog(
                                AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  title: Center(
                                    child: MyText(
                                      text: 'Completed',
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                  content:
                                      ListView(shrinkWrap: true, children: [
                                    MyText(
                                      textAlign: TextAlign.center,
                                      text:
                                          'Are you sure you want to mark this ride as complete?',
                                      color: kPrimaryColor,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: MyButton(
                                            onTap: () {
                                              Get.back();
                                            },
                                            buttonText: 'No',
                                            bgColor: Colors.red,
                                            textColor: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: MyButton(
                                            onTap: () async {
                                              Get.back();
                                              await _allRideController
                                                  .markRideAsComplete(
                                                      request.requestId ?? '');
                                            },
                                            buttonText: 'Yes',
                                            textColor: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                ),
                              );
                            },
                            buttonText: 'Mark as Complete',
                          )
                        : request.status == 'Requested'
                            ? Row(
                                children: [
                                  Expanded(
                                    child: MyBorderButton(
                                      onTap: () {
                                        Get.dialog(
                                          AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            title: Center(
                                              child: MyText(
                                                text: 'Reject',
                                                weight: FontWeight.bold,
                                              ),
                                            ),
                                            content: ListView(
                                                shrinkWrap: true,
                                                children: [
                                                  MyText(
                                                    textAlign: TextAlign.center,
                                                    text:
                                                        'Are you sure you want to reject this ride request?',
                                                    color: kPrimaryColor,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: MyButton(
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                          buttonText: 'No',
                                                          bgColor: Colors.red,
                                                          textColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Expanded(
                                                        child: MyButton(
                                                          onTap: () async {
                                                            Get.back();
                                                            await _allRideController
                                                                .markRideAsRejected(
                                                                    request.requestId ??
                                                                        '');
                                                          },
                                                          buttonText: 'Yes',
                                                          textColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                        );
                                      },
                                      buttonText: 'Reject',
                                      borderColor: Colors.red,
                                      textColor: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: MyBorderButton(
                                      onTap: () {
                                        Get.dialog(
                                          AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            title: Center(
                                              child: MyText(
                                                text: 'Accept',
                                                weight: FontWeight.bold,
                                              ),
                                            ),
                                            content: ListView(
                                                shrinkWrap: true,
                                                children: [
                                                  MyText(
                                                    textAlign: TextAlign.center,
                                                    text:
                                                        'Are you sure you want to accept this ride request?',
                                                    color: kPrimaryColor,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: MyButton(
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                          buttonText: 'No',
                                                          bgColor: Colors.red,
                                                          textColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Expanded(
                                                        child: MyButton(
                                                          onTap: () async {
                                                            Get.back();
                                                            await _allRideController.markRideAsAccepted(
                                                                request.requestId ??
                                                                    '',
                                                                request.requestedUserName ??
                                                                    '',
                                                                request.requestedUserPhoneNumber ??
                                                                    '',
                                                                request.requestedUserId ??
                                                                    '');
                                                          },
                                                          buttonText: 'Yes',
                                                          textColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                        );
                                      },
                                      buttonText: 'Accept',
                                      borderColor: Colors.green,
                                      textColor: Colors.green,
                                    ),
                                  )
                                ],
                              )
                            : Container(),
          ],
        ),
      ),
    );
  }
}

openComingSoonDialog() {
  Get.dialog(AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    title: Center(
        child: MyText(
      text: 'Coming Soon!',
      weight: FontWeight.bold,
    )),
    content: ListView(shrinkWrap: true, children: [
      MyText(
        text: 'Chat will come soon to Route Partners',
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 20),
      MyBorderButton(
        onTap: () {
          Get.back();
        },
        buttonText: 'OK',
      )
    ]),
  ));
}
