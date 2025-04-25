import 'package:get/get.dart';

class NavigationController extends GetxController {
  final currentIndex = 0.obs;

  void changePage(int index) {
    if (currentIndex.value == index) return;
    currentIndex.value = index;
  }
} 