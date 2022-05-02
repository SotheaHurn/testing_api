import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/product/controller/cart_controller.dart';
import 'package:testing/utils/style.dart';

import '../product/view/cart_page.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController addToCartController = Get.find();
    return Obx(
      () => Badge(
        position: cartBadgePosition,
        badgeContent: Text('${addToCartController.orderCount.value}'),
        showBadge: addToCartController.orderCount.value == 0 ? false : true,
        badgeColor: Colors.red,
        child: IconButton(
          onPressed: addToCartController.orderCount.value == 0
              ? null
              : () => Get.to(() => CartPage()),
          icon: Icon(
            Icons.shopping_cart,
            color: colorBlack,
          ),
        ),
      ),
    );
  }
}
