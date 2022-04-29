import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/counter/controller/addtocart_controller.dart';
import 'package:testing/counter/controller/product_controller.dart';
import 'package:testing/counter/view/all_product.dart';
import 'package:testing/utils/cart_widget.dart';
import 'package:testing/utils/style.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  final AddToCartController addToCartController = Get.find();
  final ProductController productController = Get.find();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Get.to(const AllProduct()),
        ),
        title: const Text('Your Cart'),
        actions: const [
          CartWidget(),
        ],
      ),
      body: ListView(
        controller: scrollController,
        padding: EdgeInsets.symmetric(horizontal: pageMargin),
        children: [
          GetBuilder<AddToCartController>(
            init: AddToCartController(),
            builder: (controller) => SizedBox(
              height: cartProductViewHeight *
                  controller.productCart.length.toDouble(),
              child: ListView.builder(
                itemCount: controller.productCart.length,
                itemBuilder: (context, index) => orderedProductView(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderedProductView(int index) => Container(
        height: cartProductViewHeight,
        padding: EdgeInsets.only(top: pageMargin),
        child: Container(
          color: Colors.blue,
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        productController
                            .data[addToCartController.productCart[index]
                                ['index']]
                            .imageThumbnail!,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                width: 220,
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productController
                                  .data[addToCartController.productCart[index]
                                      ['index']]
                                  .productName!
                                  .length >
                              15
                          ? productController
                              .data[addToCartController.productCart[index]
                                  ['index']]
                              .productName!
                              .replaceRange(
                                  15,
                                  productController
                                      .data[addToCartController
                                          .productCart[index]['index']]
                                      .productName!
                                      .length,
                                  '...')
                          : productController
                              .data[addToCartController.productCart[index]
                                  ['index']]
                              .productName!,
                      style: textViewStyle,
                    ),
                    Text('\$' +
                        productController
                            .data[addToCartController.productCart[index]
                                ['index']]
                            .priceBeforeDiscount!),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            addToCartController.removeProductCart(
                                addToCartController.productCart[index]
                                    ['index']);
                            addToCartController.decrement();
                            if (addToCartController.orderCount.value == 0) {
                              Get.to(const AllProduct());
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
                            addToCartController.productCart[index]['qty']
                                .toString(),
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            addToCartController.addProductCart(
                                addToCartController.productCart[index]
                                    ['index']);
                            addToCartController.increment();
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
                    addToCartController.deleteProductCart(index);
                    if (addToCartController.productCart.isEmpty) {
                      Get.to(const AllProduct());
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
}
