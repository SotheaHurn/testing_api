import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:testing/counter/controller/addtocart_controller.dart';
import 'package:testing/counter/controller/product_controller.dart';
import 'package:testing/utils/style.dart';

class DetatilPage extends StatelessWidget {
  final int indexProduct;
  const DetatilPage({Key? key, required this.indexProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final AddToCartController addToCartController = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: colorBlack,
        ),
        actions: [
          Obx(
            () => Badge(
              position: cartBadgePosition,
              badgeContent: Text('${addToCartController.orderCount.value}'),
              showBadge:
                  addToCartController.orderCount.value == 0 ? false : true,
              badgeColor: Colors.red,
              child: Icon(
                Icons.shopping_cart,
                color: colorBlack,
              ),
            ),
          ),
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
                    Container(
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
                Text(
                  '\$${productController.data[indexProduct].priceBeforeDiscount!}',
                  style: textDetialStyle,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Description :'),
            Text(
              productController.data[indexProduct].fullDesc == null ||
                      productController.data[indexProduct].fullDesc == ''
                  ? 'Hello'
                  : productController.data[indexProduct].fullDesc!,
              style: TextStyle(color: colorBlack),
            ),
            SizedBox(height: 50),
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
                    child: Icon(Icons.store),
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
                      child: Text('Add To Cart'),
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
