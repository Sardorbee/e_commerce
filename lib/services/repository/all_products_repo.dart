import 'package:get_storage/get_storage.dart';

import '../models/product_model/products_model.dart';
import '../universal_response.dart';
import '../apis/all_products.dart';

class AllProductsRepository {
  final box = GetStorage();

  AllProductsRepository({required this.aPiProvider});
  APiProvider? aPiProvider;

  Future loginrepo(
      String username, String password) async {
    UniversalResponse universalResponse =
        await aPiProvider!.logintoProducts(username, password);

    if (universalResponse.error.isEmpty) {
     await box.write('isloggedIn', true);
      
        return universalResponse.data as String;
      
    }
    return print(32);
  }

  Future<List<ProductsModel>> fetchAllProducts(
      [String? category, String? sort, int? limit]) async {
    UniversalResponse universalResponse =
        await aPiProvider!.getAllProducts(category!, sort, limit!);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<ProductsModel>;
    }
    return [];
  }

  Future<List<ProductsModel>> fetchProductsByID(int id) async {
    UniversalResponse universalResponse =
        await aPiProvider!.getProductsByID(id);
    if (universalResponse.error.isEmpty) {
      if (universalResponse.data is ProductsModel) {
        return [universalResponse.data as ProductsModel];
      } else if (universalResponse.data is List<ProductsModel>) {
        return universalResponse.data as List<ProductsModel>;
      }
    }
    return [];
  }

  Future<List<ProductsModel>> deleteProductByID(int id) async {
    UniversalResponse universalResponse = await aPiProvider!.deleteProduct(id);
    if (universalResponse.error.isEmpty) {
      if (universalResponse.data is ProductsModel) {
        return [universalResponse.data as ProductsModel];
      } else if (universalResponse.data is List<ProductsModel>) {
        return universalResponse.data as List<ProductsModel>;
      }
    }
    return [];
  }

  Future<List<ProductsModel>> addProducts(ProductsModel product) async {
    UniversalResponse universalResponse =
        await aPiProvider!.addProduct(product);

    if (universalResponse.error.isEmpty) {
      if (universalResponse.data is ProductsModel) {
        return [universalResponse.data as ProductsModel];
      } else if (universalResponse.data is List<ProductsModel>) {
        return universalResponse.data as List<ProductsModel>;
      }
    }
    return [];
  }

  Future<List<ProductsModel>> addProductUpdate(
      ProductsModel product, int id) async {
    UniversalResponse universalResponse =
        await aPiProvider!.addProductUpdate(product, id);

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
