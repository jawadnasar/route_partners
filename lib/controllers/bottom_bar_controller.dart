import 'package:get/get.dart';
import 'package:route_partners/core/utils/snackbars.dart';

class BottomBarController extends GetxController {
  int selectedIndex = 0;

  updateSelectedIndex(int index) {
    if (index != 4) {
      selectedIndex = index;
      update();
    } else {
      CustomSnackBars.instance
          .showFailureSnackbar(title: 'Tournaments', message: 'Coming Soon');
    }
  }

  static BottomBarController get i => Get.put(BottomBarController());
}
