import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/counter/controller/addtocart_controller.dart';
import 'package:testing/counter/controller/product_controller.dart';
import 'package:testing/counter/view/detail_page.dart';
import 'package:testing/utils/cart_widget.dart';
import 'package:testing/utils/style.dart';

class AllProduct extends StatelessWidget {
  const AllProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addToCartController = Get.put(AddToCartController());
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
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
