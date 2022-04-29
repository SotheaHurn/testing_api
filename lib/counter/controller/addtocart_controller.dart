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
        update();
        return;
      }
    }
    productCart.add({'index': index, 'qty': 1});
    update();
  }

  void removeProductCart(int index) {
    for (int i = 0; i < productCart.length; i++) {
      if (productCart[i]['index'] == index) {
        if (productCart[i]['qty'] == 1) {
          productCart.removeAt(i);
        } else {
          productCart[i]['qty']--;
        }
      }
    }
    update();
  }

  void deleteProductCart(int index) {
    orderCount.value = orderCount.value - productCart[index]['qty'] as int;
    productCart.removeAt(index);
    update();
  }
}
