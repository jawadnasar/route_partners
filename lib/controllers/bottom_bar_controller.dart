import 'package:get/get.dart';

class BottomBarController extends GetxController {
  int selectedIndex = 0;

  updateSelectedIndex(int index) {
    
      selectedIndex = index;
      update();
    
  }

  static BottomBarController get i => Get.put(BottomBarController());
}
