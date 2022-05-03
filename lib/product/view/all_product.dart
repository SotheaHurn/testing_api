import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:testing/product/controller/counter_controller.dart';
import 'package:testing/product/controller/product_controller.dart';
import 'package:testing/widget/cart_widget.dart';
import 'package:testing/utils/style.dart';

import '../../product/controller/cart_controller.dart';
import 'product_detail/detail_page.dart';

class AllProduct extends StatelessWidget {
  AllProduct({Key? key}) : super(key: key);
  final cartController = Get.put(CartController());
  final productController = Get.put(ProductController());
  final counterController = Get.put(CounterController());

  final scrollController = ScrollController();
  void scrollListener() {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent / 2 &&
        !scrollController.position.outOfRange) {
      if (productController.hasNext) {
        productController.getProduct();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        child: Image.network(
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/run-running-watches-1639593690.jpg?crop=1xw:1xh;center,top&resize=1200:*',
          fit: BoxFit.cover,
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        child: Image.network(
          'https://fdn.gsmarena.com/imgroot/news/22/03/xiaomi-watch-s1-s1-active-review/-1200w5/gsmarena_007.jpg',
          fit: BoxFit.cover,
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        child: Image.network(
          'https://static.euronews.com/articles/stories/06/48/94/10/1440x810_cmsv2_72145961-5fb7-5e54-852d-997299cf9e10-6489410.jpg',
          fit: BoxFit.cover,
        ),
      )
    ];
    scrollController.addListener(scrollListener);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: const [
          CartWidget(),
        ],
      ),
      backgroundColor: backgroundColorProduct,
      body: ListView(
        controller: scrollController,
        children: [
          GetBuilder<ProductController>(
            init: ProductController(),
            builder: (proController) => Column(
              children: [
                Stack(
                  children: [
                    CarouselSlider(
                      items: items,
                      options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2,
                        onPageChanged: (index, reson) =>
                            counterController.setValue(index),
                      ),
                    ),
                    Container(
                      height: 30,
                      alignment: Alignment.center,
                      child: Obx(
                        () => AnimatedSmoothIndicator(
                          activeIndex: counterController.activeIndex.value,
                          count: items.length,
                          effect: const WormEffect(
                            spacing: 20,
                            dotColor: Colors.red,
                            activeDotColor: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                for (int index = 0;
                    index < productController.data.length;
                    index++)
                  InkWell(
                    onTap: () => Get.to(DetatilPage(indexProduct: index)),
                    child: productCard(
                      image: proController.data[index].imageThumbnail!,
                      name: proController.data[index].productName!,
                      storeName: proController.data[index].storeName!,
                      price: proController.data[index].priceBeforeDiscount!,
                      status: proController.data[index].sellStatus!,
                    ),
                  )
              ],
            ),
          )
        ],
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
