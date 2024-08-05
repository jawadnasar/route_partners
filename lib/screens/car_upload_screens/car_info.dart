import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/address_controller.dart';
import 'package:route_partners/controllers/car_upload_controller.dart';
import 'package:route_partners/core/bindings/bindings.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/constants/app_images.dart';
import 'package:route_partners/core/utils/snackbars.dart';
import 'package:route_partners/screens/car_upload_screens/car_information.dart';
import 'package:route_partners/screens/car_upload_screens/contact_information.dart';
import 'package:route_partners/screens/car_upload_screens/google_maps_screen.dart';
import 'package:route_partners/screens/car_upload_screens/upload_photos.dart';
import 'package:route_partners/screens/dashboard/bottom_navigation_bar.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';
import 'package:timelines/timelines.dart';

class CarInfo extends StatefulWidget {
  const CarInfo({
    super.key,
  });

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  final _formKey = GlobalKey<FormState>();
  final cont = Get.find<CarUploadController>();

  int _pageIndex = 0;
  List<String> steps = [
    'Car Info',
    'Upload Photos',
    'Selling Price',
    'Location'
  ];

  bool? edit;

  late PageController _controller;
  List<Widget> pages = [
    const CarInformation(),
    UploadPhotos(),
    const ContactInformation(),
    CarLocationScreen(
      controller: CarUploadController.i.address,
      latController: CarUploadController.i.lat,
      lngController: CarUploadController.i.lng,
    )
  ];

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
        title: 'Upload a car for hiring',
        onLeadingTap: () {
          AddressController.i.controller.clear();
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: Get.height * 0.1,
                width: Get.width,
                child: Timeline.tileBuilder(
                  theme: TimelineThemeData(
                    nodePosition: 0.3,
                    indicatorPosition: 8,
                    direction: Axis.horizontal,
                    color: kPrimaryColor,
                    indicatorTheme: const IndicatorThemeData(
                      size: 30,
                    ),
                  ),
                  builder: TimelineTileBuilder.connected(
                    connectorBuilder: (_, index, __) => SizedBox(
                      height: 1,
                      width: Get.width * 0.06,
                      child: const MySeparator(
                        color: kPrimaryColor,
                      ),
                    ),
                    connectionDirection: ConnectionDirection.before,
                    itemCount: steps.length,
                    contentsBuilder: (_, index) => GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          steps[index],
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 12, color: kBlackColor),
                        ),
                      ),
                    ),
                    indicatorBuilder: (_, index) {
                      Color? indicatorColor;
                      if (_pageIndex > index) {
                        indicatorColor = kPrimaryColor;
                      } else {
                        indicatorColor = Colors.grey;
                      }
                      return InkWell(
                        onTap: () {
                          _controller.jumpToPage(index);
                        },
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: const Color(0xFFEEF2F6),
                          child: CircleAvatar(
                            backgroundColor: indicatorColor,
                            radius: 15,
                            child: const Icon(
                              Icons.check,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                    indicatorPositionBuilder: (_, __) => 0.5,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  dragStartBehavior: DragStartBehavior.down,
                  onPageChanged: (value) {
                    setState(() {
                      _pageIndex = value;
                    });
                  },
                  controller: _controller,
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
              ),
              _pageIndex == 3
                  ? Obx(
                      () => cont.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            )
                          : MyButton(
                              buttonText: 'Post your AD',
                              onTap: () async {
                                if (cont.address.text.isEmpty ||
                                    cont.lat.text.isEmpty ||
                                    cont.lng.text.isEmpty) {
                                  CustomSnackBars.instance.showFailureSnackbar(
                                      title: 'Error',
                                      message: 'Select location');
                                } else {
                                  await cont.uploadCar(
                                    carImages: cont.files,
                                    address: cont.address.text,
                                    carModel: cont.carModal.text,
                                    exteriorColor: cont.carExteriorColor.text,
                                    latLng: GeoPoint(
                                        double.parse(cont.lat.text),
                                        double.parse(cont.lng.text)),
                                    modelYear: cont.modalYear.text,
                                    pricePerHour: cont.price.text,
                                    primaryMobileNumber:
                                        cont.primaryMobNum.text,
                                    registeredArea: cont.carRegisteredArea.text,
                                    secondaryMobileNumber:
                                        cont.secondaryPhone?.text,
                                    sellerName: cont.sellerName.text,
                                  );
                                  modalBottomSheetSuccess(context);
                                }
                              },
                              bgColor: kPrimaryColor,
                              textColor: Colors.white,
                            ),
                    )
                  : MyButton(
                      bgColor: kGreyColor8,
                      buttonText: 'Next',
                      onTap: () async {
                        validateAndNavigate(
                            context, _formKey, _controller, _pageIndex);
                      },
                      textColor: Colors.white,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void validateAndNavigate(
    BuildContext context,
    GlobalKey<FormState> formKey,
    PageController controller,
    int pageIndex,
  ) {
    if (pageIndex < 4 && formKey.currentState!.validate()) {
      if (pageIndex == 1) {
        if (cont.files.isEmpty) {
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Error', message: 'Add atleast 1 image');
          return;
        }
      }
      switch (pageIndex) {
        case 0:
          // if (cont.selectedCity == null ||
          //     cont.selectedModalYear == null ||
          //     cont.carMakesItem == null ||
          //     cont.carModals == null ||
          //     cont.area == null ||
          //     cont.exterior == null) {
          //   CustomSnackBars.instance.showFailureSnackbar(
          //       title: 'Fill in the required Fields',
          //       message: 'Please fill in the required fields to continue');
          // } else {
          _navigateToNextPage(controller, pageIndex);
        // }
        // break;

        case 1:
          // if (cont.mileage == null ||
          //     cont.engine == null ||
          //     cont.capacity == null ||
          //     cont.transmission == null ||
          //     cont.carassembly == null) {
          //   CustomSnackBars.instance.showFailureSnackbar(
          //       title: 'Required Fields',
          //       message: 'Please fill in the required fields to continue');
          //   log(cont.mileage.toString());
          // } else {
          _navigateToNextPage(controller, pageIndex);
          // }
          break;

        case 2:
          // if (EditProfileController.i.selectedFiles!.length < 3 ||
          //     EditProfileController.i.selectedFiles!.isEmpty) {
          //   CustomSnackBars.instance.showFailureSnackbar(
          //       title: 'Required Fields',
          //       message: 'Please fill in the required fields to continue');
          // } else {
          _navigateToNextPage(controller, pageIndex);
          // }
          break;

        default:
          _navigateToNextPage(controller, pageIndex);
          break;
      }
    }
  }

  void _navigateToNextPage(PageController controller, int pageIndex) {
    controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }
}

String watsapp() {
  final cont = Get.find<CarUploadController>();
  if (cont.whatsapp == true) {
    return '1';
  } else {
    return '0';
  }
}

Future<dynamic> modalBottomSheetSuccess(BuildContext context) {
  return showModalBottomSheet(
    isDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(Assets.carImage),
            const SizedBox(
              height: 15,
            ),
            MyText(
              text: 'Your Car Ad is Live',
              size: 24,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Your car ad is now active and available for Hiring',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              onTap: () {
                Get.offAll(() => const DashBoard(), binding: HomeBindings());
              },
              buttonText: 'OK',
              textColor: Colors.white,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      );
    },
  );
}

class MySeparator extends StatelessWidget {
  const MySeparator({super.key, this.height = 1, this.color = Colors.black});
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 6.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (1.2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
