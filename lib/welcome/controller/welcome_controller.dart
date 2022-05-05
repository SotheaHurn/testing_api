import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var currentIndex = 0.obs;

  void increment() {
    if (currentIndex.value < 2)
      currentIndex.value++;
    else
      currentIndex.value = 0;
  }
}
