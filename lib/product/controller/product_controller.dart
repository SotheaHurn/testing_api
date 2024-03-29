import 'package:get/get.dart';
import 'package:testing/product/repository/product_repo.dart';

import '../model/product_model.dart';

class ProductController extends GetxController {
  final _data = <Product>[].obs;
  final _isLoading = false.obs;
  var pagination = Pagination(perPage: 10);
  bool hasNext = true;

  final productRepo = Get.put(ProductRepository());

  List<Product> get data => _data.toList();

  @override
  void onInit() async {
    await getProduct();
    super.onInit();
  }

  Future<void> getProduct() async {
    try {
      if (pagination.currentPage == 0) _data.clear();
      if (pagination.currentPage < pagination.lastPage) {
        print(_isLoading.value);
        if (_isLoading.value) return Future.value();
        _isLoading.value = true;
        final response = await productRepo.getProduct(pagination);
        if (response != null) {
          _data.addAll(response['data']);
          pagination = response['pagination'];
          hasNext = _data.length < pagination.total!;
          update();
        } else {
          hasNext = false;
        }
      }
    } catch (e) {
      print(e);
    }
    _isLoading.value = false;
  }
}
