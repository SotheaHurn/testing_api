import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/counter/controller/cart_controller.dart';
import 'package:testing/counter/controller/product_controller.dart';
import 'package:testing/utils/cart_widget.dart';
import 'package:testing/utils/style.dart';

import 'detail_page.dart';

class AllProduct extends StatelessWidget {
  AllProduct({Key? key}) : super(key: key);
  final cartController = Get.put(CartController());
  final productController = Get.put(ProductController());

  final scrollController = ScrollController();
  void scrollListener() {
    // print(scrollController.offset.toInt().toString() +
    //     '\t' +
    //     ((scrollController.position.maxScrollExtent / 2).toInt()).toString());
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (productController.hasNext) {
        productController.getProduct();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(scrollListener);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: const [
          CartWidget(),
        ],
      ),
      backgroundColor: backgroundColorProduct,
      body: GetBuilder<ProductController>(
        init: ProductController(),
        builder: (proController) => ListView.builder(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: proController.data.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () => Get.to(DetatilPage(indexProduct: index)),
            child: productCard(
              image: proController.data[index].imageThumbnail!,
              name: proController.data[index].productName!,
              storeName: proController.data[index].storeName!,
              price: proController.data[index].priceBeforeDiscount!,
              status: proController.data[index].sellStatus!,
            ),
          ),
        ),
      ),
    );
  }

  Widget productCard(
          {required String image,
          required String name,
          required String storeName,
          required String price,
          required String status}) =>
      Container(
        margin: EdgeInsets.only(
            top: pageMargin, left: pageMargin, right: pageMargin),
        height: 100,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 190, 226, 255),
            borderRadius: BorderRadius.circular(circularCardView)),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(circularCardView),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(image))),
            ),
            Container(
              width: 190,
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    name.length > 15
                        ? name.replaceRange(15, name.length, '...')
                        : name,
                    style: textViewStyle,
                  ),
                  Text('\$$price'),
                  Text(
                    status,
                    style: TextStyle(
                        color:
                            status == 'AVAILABLE' ? Colors.green : Colors.red),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.store),
                  Text(
                    storeName.length > 10
                        ? storeName.replaceRange(10, storeName.length, '...')
                        : storeName,
                  )
                ],
              ),
            )
          ],
        ),
      );
}
