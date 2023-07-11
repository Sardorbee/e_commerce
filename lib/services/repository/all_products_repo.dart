import '../models/product_model/products_model.dart';
import '../universal_response.dart';
import '../apis/all_products.dart';

class AllProductsRepository {
  AllProductsRepository({required this.aPiProvider});
  APiProvider? aPiProvider;
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
