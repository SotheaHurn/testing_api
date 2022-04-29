import 'package:testing/counter/model/product_model.dart';

import '../../utils/constaint.dart';

class ProductRepository {
  Future<List<Product>?> getProduct() async {
    try {
      final respone = await dio.post('/get_newest_product');
      if (respone.statusCode == 200) {
        var responseData = respone.data['data']; //if map only 1
        return getDataModel(responseData['data']); //map inner map
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
