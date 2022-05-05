import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/product/view/all_product.dart';
import 'package:testing/product/view/counter_screen.dart';
import 'package:testing/welcome/welcome_sreen.dart';
import 'package:testing/welcome/welcome_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: WelcomeScreen(),
      // home: AllProduct(),
    );
  }
}
