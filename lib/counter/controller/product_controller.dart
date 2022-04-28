import 'dart:developer';

import 'package:get/get.dart';
import 'package:testing/counter/model/product_model.dart';
import 'package:testing/counter/repository/product_repo.dart';

class ProductController extends GetxController {
  final _data = <Product>[].obs;
  final productRepo = Get.put(ProductRepository());

  List<Product> get data => _data.toList();

  @override
  void onInit() async {
    await getProduct();
    super.onInit();
  }

  Future<String> getProduct() async {
    try {
      final response = await productRepo.getProduct();
      if (response != null) {
        _data.assignAll(response);
        update();
        return 'Success';
      }
    } catch (e) {
      print(e);
    }
    return 'Error';
  }
}
