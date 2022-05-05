import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:testing/welcome/controller/welcome_controller.dart';
import 'package:testing/welcome/welcome_sreen.dart';

class WelcomeWidget extends StatelessWidget {
  final Widget text;
  final Widget body;
  final Widget button;

  const WelcomeWidget(
      {Key? key,
      this.text = const SizedBox(),
      this.body = const SizedBox(),
      this.button = const SizedBox()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WelcomeController());
    return Container(
      color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 830,
            margin: EdgeInsets.only(left: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                text,
                body,
              ],
            ),
          ),
          Center(
            child: Obx(
              () => Container(
                alignment: Alignment.bottomCenter,
                child: AnimatedSmoothIndicator(
                  activeIndex: controller.currentIndex.value,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    dotColor: Colors.white,
                    activeDotColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: controller.currentIndex.value < 2
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 190,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Skip',
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(width: 2, color: Colors.white),
                              primary: Colors.red,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 190,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.increment();
                            },
                            child: Text(
                              'Next',
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white, onPrimary: Colors.red),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      height: 50,
                      width: 500,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.increment();
                        },
                        child: Text(
                          'Start Now',
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white, onPrimary: Colors.red),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
