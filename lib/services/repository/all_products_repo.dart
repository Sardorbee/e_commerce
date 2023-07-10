import 'package:e_commerce/services/apis/user_api.dart';
import 'package:e_commerce/services/models/user_model/user_model.dart';

import '../models/product_model/products_model.dart';
import '../universal_response.dart';
import '../apis/all_products.dart';

class AllProductsRepository {
  static Future<List<ProductsModel>> fetchCurrencies(
      [String? category, String? sort, int? limit]) async {
    UniversalResponse universalResponse =
    
        await APiProvider().getAllProducts(category!, sort, limit!);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<ProductsModel>;
    }
    return [];
  }
  
  static Future<List<ProductsModel>> fetchProductsByID(int id) async {
    UniversalResponse universalResponse =
        await APiProvider().getProductsByID(id);
    if (universalResponse.error.isEmpty) {
      if (universalResponse.data is ProductsModel) {
        return [universalResponse.data as ProductsModel];
      } else if (universalResponse.data is List<ProductsModel>) {
        return universalResponse.data as List<ProductsModel>;
      }
    }
    return [];
  }


}
