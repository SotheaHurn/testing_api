import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:testing/welcome/controller/welcome_controller.dart';
import 'package:testing/welcome/welcome_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

final globalKey = GlobalKey<AnimatedListState>();

class _WelcomeScreenState extends State<WelcomeScreen> {
  final controller = Get.put(WelcomeController());

  List<Widget> screens = [
    WelcomeWidget(
      text: Text(
        'Marketplace\nto buy and\nsell cars.',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
        ),
      ),
      body: Image.network(
          'https://www.lamborghini.com/sites/it-en/files/DAM/lamborghini/facelift_2019/model_gw/hero-banner/huracan/11_18_sto_lancio/Huracan_STO.png'),
    ),
    WelcomeWidget(
      text: Text(
        'Swap your\nCar\nFind, choose and contact',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
        ),
      ),
      body: Image.network(
          'https://www.lamborghini.com/sites/it-en/files/DAM/lamborghini/facelift_2019/homepage/families-gallery/mobile/Aventador_ultimae_model_mobile.png'),
    ),
    WelcomeWidget(
      text: Text(
        'Explore\navailable\nvehicles online',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
        ),
      ),
      body: Image.network(
          'https://www.lamborghini.com/sites/it-en/files/DAM/lamborghini/facelift_2019/model_detail/aventador/ultimae_roadster/menu_aven_ulti_rds.png'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CarouselSlider(
          options: CarouselOptions(
              autoPlay: false,
              viewportFraction: 1,
              aspectRatio: 2,
              enlargeCenterPage: true),
          items: screens,
        ),
      ),
    );
  }
}
