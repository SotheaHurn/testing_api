import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:testing/counter/controller/cart_controller.dart';
import 'package:testing/counter/controller/product_controller.dart';
import 'package:testing/utils/cart_widget.dart';
import 'package:testing/utils/style.dart';

class DetatilPage extends StatelessWidget {
  final int indexProduct;
  const DetatilPage({Key? key, required this.indexProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final CartController addToCartController = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: colorBlack,
        ),
        actions: const [
          CartWidget(),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: pageMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      productController.data[indexProduct].imageThumbnail!),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Text(
                        productController
                                    .data[indexProduct].productName!.length >
                                18
                            ? productController.data[indexProduct].productName!
                                .replaceRange(
                                    16,
                                    productController
                                        .data[indexProduct].productName!.length,
                                    '...')
                            : productController.data[indexProduct].productName!,
                        style: textDetialNameStyle,
                      ),
                    ),
                    Text(
                      'Brand : ${productController.data[indexProduct].brandName!}',
                      style: textDetialStyle,
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '\$${productController.data[indexProduct].priceBeforeDiscount!}',
                      style: textDetialStyle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Description :'),
            Text(
              productController.data[indexProduct].fullDesc == null ||
                      productController.data[indexProduct].fullDesc == ''
                  ? 'Hello'
                  : productController.data[indexProduct].fullDesc!,
              style: TextStyle(color: colorBlack),
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: detialPageButtonColor,
                    ),
                    child: const Icon(Icons.store),
                  ),
                ),
                SizedBox(width: pageMargin),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        addToCartController.increment();
                        addToCartController.addProductCart(indexProduct);
                      },
                      style: ElevatedButton.styleFrom(
                          onPrimary: colorBlack,
                          primary: detialPageButtonColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text('Add To Cart'),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
