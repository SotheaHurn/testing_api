import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    return Container(
      color: Colors.red,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 700,
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
            child: Container(
              margin: EdgeInsets.all(20),
              child: AnimatedSmoothIndicator(
                activeIndex: 1,
                count: 3,
                effect: const ExpandingDotsEffect(
                  spacing: 5,
                  dotColor: Colors.white,
                  activeDotColor: Colors.white,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  onPressed: () {},
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
        ],
      ),
    );
  }
}
