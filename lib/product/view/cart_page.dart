import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testing/counter/controller/cart_controller.dart';
import 'package:testing/counter/controller/product_controller.dart';
import 'package:testing/widget/cart_widget.dart';
import 'package:testing/utils/style.dart';

import 'all_product.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  final CartController cartController = Get.find();
  final ProductController productController = Get.find();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Get.to( AllProduct()),
        ),
        title: const Text('Your Cart'),
        actions: const [
          CartWidget(),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: pageMargin),
        children: [
          GetBuilder<CartController>(
            init: CartController(),
            builder: (controller) => Column(
              children: [
                for (int index = 0;
                    index < cartController.productCart.length;
                    index++)
                  orderedProductView(index),
              ],
            ),
          ),
          const SizedBox(height: 40),
          GetBuilder<CartController>(
            init: CartController(),
            builder: (cartController) => Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 189, 189),
                borderRadius: BorderRadius.circular(circularCardView),
              ),
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    for (int i = 0; i < cartController.productCart.length; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productController
                                        .data[cartController.productCart[i]
                                            ['index']]
                                        .productName!
                                        .length >
                                    25
                                ? productController
                                    .data[cartController.productCart[i]
                                        ['index']]
                                    .productName!
                                    .replaceRange(
                                        20,
                                        productController
                                            .data[cartController.productCart[i]
                                                ['index']]
                                            .productName!
                                            .length,
                                        '...')
                                : productController
                                    .data[cartController.productCart[i]
                                        ['index']]
                                    .productName!,
                            style: textSubTotalStyle,
                          ),
                          Text(
                            calculateSubTotal(i),
                            style: textSubTotalStyle,
                          ),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: texTotalStyle,
                        ),
                        Text(
                          calculateTotal(),
                          style: texTotalStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            height: 50,
            width: 200,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  onPrimary: colorBlack,
                  primary: detialPageButtonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text(
                'Order',
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget orderedProductView(int index) => Container(
        height: cartProductViewHeight,
        padding: EdgeInsets.only(top: pageMargin),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColorProduct,
            borderRadius: BorderRadius.circular(circularCardView),
          ),
          child: Row(
            children: [
              Container(
                height: cartProductViewHeight - 20,
                width: cartProductViewHeight - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(circularCardView),
                  image: DecorationImage(
                      image: NetworkImage(
                        productController
                            .data[cartController.productCart[index]['index']]
                            .imageThumbnail!,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                width: 180,
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productController
                                  .data[cartController.productCart[index]
                                      ['index']]
                                  .productName!
                                  .length >
                              20
                          ? productController
                              .data[cartController.productCart[index]['index']]
                              .productName!
                              .replaceRange(
                                  15,
                                  productController
                                      .data[cartController.productCart[index]
                                          ['index']]
                                      .productName!
                                      .length,
                                  '...')
                          : productController
                              .data[cartController.productCart[index]['index']]
                              .productName!,
                      style: textViewStyle,
                    ),
                    Text('\$' +
                        productController
                            .data[cartController.productCart[index]['index']]
                            .priceBeforeDiscount!),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            cartController.removeProductCart(
                                cartController.productCart[index]['index']);
                            cartController.decrement();
                            if (cartController.orderCount.value == 0) {
                              Get.to(AllProduct());
                            }
                          },
                          icon: const Icon(
                            Icons.remove,
                            size: 30,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            cartController.productCart[index]['qty'].toString(),
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            cartController.addProductCart(
                                cartController.productCart[index]['index']);
                            cartController.increment();
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 30,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    cartController.deleteProductCart(index);
                    if (cartController.productCart.isEmpty) {
                      Get.to(AllProduct());
                    }
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    size: 40,
                  ),
                ),
              )
            ],
          ),
        ),
      );
  String calculateSubTotal(int i) => NumberFormat('\$###,##0.00').format(
      (cartController.productCart[i]['qty'] *
          double.parse(productController
              .data[cartController.productCart[i]['index']]
              .priceBeforeDiscount!)));

  String calculateTotal() {
    double total = 0;
    for (int i = 0; i < cartController.productCart.length; i++) {
      total += cartController.productCart[i]['qty'] *
          double.parse(productController
              .data[cartController.productCart[i]['index']]
              .priceBeforeDiscount!);
    }
    return NumberFormat('\$###,##0.00').format(total);
  }
}
