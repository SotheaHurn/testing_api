import 'package:get/get.dart';
import 'package:testing/counter/repository/product_repo.dart';

import '../model/product_model.dart';

class ProductController extends GetxController {
  final _data = <Product>[].obs;
  var pagination = Pagination(perPage: 10);
  bool hasNext = true;

  final productRepo = Get.put(ProductRepository());

  List<Product> get data => _data.toList();

  @override
  void onInit() async {
    await getProduct();
    super.onInit();
  }

  Future<String> getProduct() async {
    try {
      if (pagination.currentPage == 0) _data.clear();
      if (pagination.currentPage < pagination.lastPage) {
        final response = await productRepo.getProduct(pagination);
        if (response != null) {
          _data.assignAll(response['data']);
          pagination = response['pagination'];
          hasNext = _data.length < pagination.total!;
          update();
          return 'Success';
        }
      }
    } catch (e) {
      print(e);
    }
    return 'Error';
  }
}
