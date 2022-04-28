import 'package:get/get.dart';

class AddToCartController extends GetxController {
  var orderCount = 0.obs;
  var productCart = [].obs;

  void increment() {
    orderCount.value++;
  }

  void decrement() {
    if (orderCount.value > 0) {
      orderCount.value--;
    }
  }

  void addProductCart(int index) {
    for (int i = 0; i < productCart.length; i++) {
      if (productCart[i]['index'] == index) {
        productCart[i]['qty']++;
        return;
      }
    }
    productCart.add({'index': index, 'qty': 1});
  }

  void removeProductCart(int index) {
    for (int i = 0; i < productCart.length - 1; i++) {
      if (productCart[i]['index'] == index) {
        if (productCart[i]['qty'] == 1) {
          productCart.removeAt(i);
        } else {
          productCart[i]['qty'] = productCart[i]['qty']--;
        }
        return;
      }
    }
  }
}
