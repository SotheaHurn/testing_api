import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:testing/counter/controller/product_controller.dart';
import 'package:testing/utils/style.dart';

import '../controller/counter_controller.dart';
import 'all_product.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final counterController = Get.put(CounterController());
  final controller = Get.put(ProductController());

  Future _refresh() async {
    await controller.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    _refresh();
    return Scaffold(
      backgroundColor: backgroundColorApp,
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () => Get.to(() =>   AllProduct()),
              icon: const Icon(Icons.arrow_right))
        ],
      ),
      body: GetBuilder<ProductController>(
        init: ProductController(),
        builder: (controller) => ListView(
          children: [
            for (int index = 0; index < controller.data.length; index++)
              Text('\n' + controller.data[index].productName!)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          log(controller.data.toString());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void waiting() {
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     duration: const Duration(seconds: 5),
  //     content: Row(
  //       children: const [
  //         CircularProgressIndicator(),
  //         Text('Signing in'),
  //       ],
  //     ),
  //   ),
  // );

  // Get.snackbar('Hello', 'hi',
  //     duration: Duration(seconds: 3),
  //     showProgressIndicator: true,
  //     snackPosition: SnackPosition.BOTTOM,
  //     overlayBlur: 0.1);

  Fluttertoast.showToast(
      msg: "This is Center Short Toast",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
