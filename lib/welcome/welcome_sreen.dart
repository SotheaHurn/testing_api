import 'package:flutter/material.dart';
import 'package:testing/welcome/welcome_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WelcomeWidget(
        text: Text(
          'Marketplace\nto buy and\nsell cars.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        body: Icon(
          Icons.car_repair,
          size: 20,
        ),
      ),
    );
  }
}
