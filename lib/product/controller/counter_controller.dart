import 'package:get/get.dart';

import '../model/counter_model.dart';

class CounterController extends GetxController {
  RxString name = 'Sothea'.obs;

  void change() {
    name('Visal');
    update();
  }

  void increment() {
    // counter++;
    update(); // look here!
  }

  var user =
      User(displayName: "Sothea").obs; // declare just like any other variable

  void changeName() {
    user(User(displayName: "Visal"));
    update();
  }
}
