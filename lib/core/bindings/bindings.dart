import 'package:get/get.dart';
import 'package:route_partners/controllers/all_rides_controller.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/controllers/chat_controller.dart';
import 'package:route_partners/controllers/create_ride_controller.dart';
import 'package:route_partners/controllers/find_ride_controller.dart';
import 'package:route_partners/controllers/general_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<GeneralController>(GeneralController());
    Get.put<AuthController>(AuthController());
  }
}

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<CreateRideController>(CreateRideController());
    Get.put<FindRideController>(FindRideController());
    Get.put<AllRidesController>(AllRidesController());
    Get.put<ChatController>(ChatController());
  }
}
