import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/counter/controller/counter_controller.dart';
import 'package:testing/utils/style.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterController controller = Get.find();
    return Scaffold(
      backgroundColor: backgroundColorApp,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('screen A'),
      ),
      body: Center(
        child: Obx(() => Text(controller.name.value)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.change(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
