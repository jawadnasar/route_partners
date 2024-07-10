import 'package:get/get.dart';
import 'package:route_partners/controllers/auth_controller.dart';
import 'package:route_partners/controllers/create_ride_controller.dart';
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
  }
}
