import 'package:holo_challenge/core/api_service/api_service.dart';
import 'package:holo_challenge/core/constants/api_endpoints.dart';

import 'product_model.dart';

class ProductsRepository {
  static Future<List<ProductModel>?> fetchProducts({
    bool showLoader = false,
    Function(Map<String, dynamic>)? fromJson,
  }) async {
    var result = await ApiService.request(
      endpoint: ApiEndpoints.products,
      method: ApiMethod.get,
      showLoader: showLoader,
      fromJson: fromJson,
    );

    if (result != null && result is List) {
      return List.from(result);
    }

    return null;
  }

  static Future<ProductModel?> fetchProductById({
    bool showLoader = false,
    Function(Map<String, dynamic>)? fromJson,
    int? id,
  }) async {
    var result = await ApiService.request(
      endpoint: ApiEndpoints.products,
      method: ApiMethod.get,
      showLoader: showLoader,
      fromJson: fromJson,
      id: id,
    );

    if (result != null && result is ProductModel) {
      return result;
    }

    return null;
  }
}
