import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';

class MyRides extends StatelessWidget {
  MyRides({super.key});
  final _allRideController = Get.find<AllRidesController>();
  final _authController = Get.find<AuthController>();

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
                  List<RideRequestModel> filteredRequests = [];
                  snapshot.data?.docs.forEach(
                    (doc) {
                      final Map<String, dynamic> data =
                          doc.data() as Map<String, dynamic>;
                      requests.add(RideRequestModel.fromMap(data));
                    },
                  );

                  for (var request in requests) {
                    for (var req in request.acceptedUsers!) {
                      if (req.id == _authController.userModel.value?.userId) {
                        filteredRequests.add(request);
                      }
                    }
                    for (var req in request.requestedUsers!) {
                      if (req.id == _authController.userModel.value?.userId) {
                        filteredRequests.add(request);
                      }
                    }
                    if (request.rejectedUserIds!
                        .contains(_authController.userModel.value?.userId)) {
                      filteredRequests.add(request);
                    }
                  }

                  return filteredRequests.isEmpty
                      ? Center(child: MyText(text: 'No Available Rides'))
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: filteredRequests.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return RideWidget(
                              request: filteredRequests[index],
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
    RxString status = ''.obs;
    for (var r in request.requestedUsers!) {
      if (r.id == _authController.userModel.value?.userId &&
          request.status == 'Requested') {
        status.value = 'Requested';
      }
    }
    for (var r in request.acceptedUsers!) {
      if (r.id == _authController.userModel.value?.userId &&
          (request.status == 'Requested' || request.status == 'Accepted')) {
        status.value = 'Accepted';
      }
    }
    return GestureDetector(
      onTap: () {
        if (!request.rejectedUserIds!
            .contains(_authController.userModel.value?.userId)) {
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
              text: '${request.pricePerSeat} per seat',
              color: kDarkGreyColor,
              weight: FontWeight.w900,
            ),
            const SizedBox(
              height: 15,
            ),
            MyText(
              text: '${request.luggageAllowed ?? '0'} kg per seat',
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
            status.value == 'Accepted'
                ? GestureDetector(
                    onTap: () async {
                      // openComingSoonDialog();
                      final ref = await _chatController.getOrCreateChat(
                          request.ownerId!,
                          _authController.userModel.value?.userId ?? '');

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
            const SizedBox(
              height: 15,
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
                text: request.ownerName ?? 'Driver',
                color: kBlackColor,
              ),
              trailing: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: request.rejectedUserIds!
                            .contains(_authController.userModel.value?.userId)
                        ? Colors.red
                        : status.value == 'Accepted'
                            ? kPrimaryColor
                            : request.status == 'Completed'
                                ? Colors.green
                                : status.value == 'Requested'
                                    ? Colors.amber
                                    : Colors.white),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: MyText(
                  text: status.value == 'Accepted'
                      ? 'Upcoming'
                      : status.value == 'Requested'
                          ? 'Requested'
                          : request.rejectedUserIds!.contains(
                                  _authController.userModel.value?.userId)
                              ? 'Rejected'
                              : request.status == 'Completed'
                                  ? 'Completed'
                                  : '',
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

class PublishedRides extends StatefulWidget {
  final RideRequestModel request;
  PublishedRides({
    required this.request,
    super.key,
  });

  @override
  State<PublishedRides> createState() => _PublishedRidesState();
}

class _PublishedRidesState extends State<PublishedRides> {
  final _allRideController = Get.find<AllRidesController>();

  @override
  Widget build(BuildContext context) {
    final chatController = Get.find<ChatController>();
    final authController = Get.find<AuthController>();
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
              Expanded(
                child: MyText(
                  onTap: () {
                    if (widget.request.status == 'Rejected') {
                      return;
                    } else if (widget.request.status == 'Published') {
                      Get.to(() => GoogleMapRoute(
                            startLoc: widget.request.pickupLocation!,
                            endLoc: widget.request.dropoffLocation!,
                            name: widget.request.ownerName ?? 'Driver',
                            dropoffAddress: widget.request.dropOfAddress!,
                            pickupAddress: widget.request.pickupAddress!,
                            pricePerSeat: widget.request.pricePerSeat ?? '50',
                            phoneNumber: widget.request.ownerPhoneNumber ??
                                '+923211010101',
                            publishedDate:
                                widget.request.publishDate ?? DateTime.now(),
                            rideDate: widget.request.rideDate ?? DateTime.now(),
                            vehicleName:
                                widget.request.vehicleName ?? 'Other Car',
                            isCustomerInfo: false,
                          ));
                    } else {
                      Get.to(() => GoogleMapRoute(
                            startLoc: widget.request.pickupLocation!,
                            endLoc: widget.request.dropoffLocation!,
                            dropoffAddress: widget.request.dropOfAddress!,
                            pickupAddress: widget.request.pickupAddress!,
                            pricePerSeat: widget.request.pricePerSeat ?? '50',
                            publishedDate:
                                widget.request.publishDate ?? DateTime.now(),
                            rideDate: widget.request.rideDate ?? DateTime.now(),
                            vehicleName:
                                widget.request.vehicleName ?? 'Other Car',
                            isCustomerInfo: true,
                            customers: widget.request.acceptedUsers,
                            ownerId: widget.request.ownerId,
                          ));
                    }
                  },
                  text:
                      '${widget.request.pickupAddress} ➡️ ${widget.request.dropOfAddress}',
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
            text: '${widget.request.availableSeats} seats available',
            color: kDarkGreyColor,
            weight: FontWeight.w900,
          ),
          const SizedBox(
            height: 15,
          ),
          MyText(
            text: '${widget.request.pricePerSeat} per seat',
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
                    .format(widget.request.rideDate ?? DateTime.now()),
                color: kGreyColor3,
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: MyText(
                  text:
                      'Published on ${DateFormat('d MMMM, h:mm a').format(widget.request.publishDate ?? DateTime.now())}',
                  color: kGreyColor3,
                ),
              ),
              SizedBox(width: Get.width * 0.05),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: widget.request.status == 'Rejected'
                          ? Colors.red
                          : widget.request.status == 'Accepted'
                              ? kPrimaryColor
                              : widget.request.status == 'Completed'
                                  ? Colors.green
                                  : widget.request.status == 'Published'
                                      ? Colors.amber
                                      : Colors.white),
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: MyText(
                    textAlign: TextAlign.center,
                    text: widget.request.status == 'Published'
                        ? 'Published'
                        : widget.request.status == 'Requested'
                            ? 'Requested'
                            : widget.request.status == 'Accepted'
                                ? 'Upcoming'
                                : widget.request.status == 'Rejected'
                                    ? 'Rejected'
                                    : widget.request.status == 'Completed'
                                        ? 'Completed'
                                        : '',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          widget.request.status == 'Rejected' ||
                  widget.request.status == 'Completed'
              ? Container()
              : widget.request.status == 'Published'
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
                                        await _allRideController.unPublishRide(
                                            widget.request.requestId ?? '');
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
                  : widget.request.status == 'Accepted'
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
                                content: ListView(shrinkWrap: true, children: [
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
                                                    widget.request.requestId ??
                                                        '');
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
                      : widget.request.status == 'Requested'
                          ? widget.request.requestedUsers!.isEmpty
                              ? Center(child: MyText(text: 'No requests yet'))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      widget.request.requestedUsers?.length ??
                                          0,
                                  itemBuilder: (context, index) => ListTile(
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
                                      text: widget.request
                                              .requestedUsers?[index].name ??
                                          '',
                                      color: kBlackColor,
                                    ),
                                    subtitle: MyText(
                                      text:
                                          '${widget.request.requestedUsers?[index].selectedSeats ?? ''} seats',
                                      color: kGreyColor,
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.dialog(
                                              AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        text:
                                                            'Are you sure you want to reject this ride request?',
                                                        color: kPrimaryColor,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: MyButton(
                                                              onTap: () {
                                                                Get.back();
                                                              },
                                                              buttonText: 'No',
                                                              bgColor:
                                                                  Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Expanded(
                                                            child: MyButton(
                                                              onTap: () async {
                                                                Get.back();
                                                                await _allRideController.markRideAsRejected(
                                                                    widget.request
                                                                            .requestId ??
                                                                        '',
                                                                    widget
                                                                            .request
                                                                            .requestedUsers?[index]
                                                                            .id ??
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
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {
                                            Get.dialog(
                                              AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        text:
                                                            'Are you sure you want to accept this ride request?',
                                                        color: kPrimaryColor,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: MyButton(
                                                              onTap: () {
                                                                Get.back();
                                                              },
                                                              buttonText: 'No',
                                                              bgColor:
                                                                  Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Expanded(
                                                            child: MyButton(
                                                              onTap: () async {
                                                                Get.back();
                                                                await _allRideController
                                                                    .markRideAsAccepted(
                                                                  requestId: widget
                                                                          .request
                                                                          .requestId ??
                                                                      '',
                                                                  userId: widget
                                                                          .request
                                                                          .requestedUsers?[
                                                                              index]
                                                                          .id ??
                                                                      '',
                                                                  selectedSeats: widget
                                                                          .request
                                                                          .requestedUsers?[
                                                                              index]
                                                                          .selectedSeats ??
                                                                      0,
                                                                  phoneNumber: widget
                                                                          .request
                                                                          .requestedUsers?[
                                                                              index]
                                                                          .phoneNumber ??
                                                                      '',
                                                                  userName: widget
                                                                          .request
                                                                          .requestedUsers?[
                                                                              index]
                                                                          .name ??
                                                                      '',
                                                                );
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
                                          child: const Icon(
                                            Icons.done,
                                            color: kSecondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                          : Container(),
          if (widget.request.status == 'Requested') ...[
            Center(
              child: MyButton(
                onTap: () {},
                buttonText: 'GO',
                textColor: Colors.white,
              ),
            )
          ]
        ],
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
