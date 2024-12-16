import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // Current index for the selected tab
  var currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
