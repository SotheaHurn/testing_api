import 'package:testing/counter/model/product_model.dart';

import '../../utils/constaint.dart';

class ProductRepository {
  Future<Map<String, dynamic>?> getProduct(Pagination pagination) async {
    try {
      final respone = await dio.post('/get_newest_product', queryParameters: {
        'page': pagination.currentPage + 1,
        'table_size': pagination.perPage,
      });
      if (respone.statusCode == 200) {
        var responseData = respone.data['data'];
        return {
          'data': getProductModel(responseData['data']),
          'pagination': Pagination.fromJson(responseData['pagination']),
        };
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
