import 'package:e_commerce/services/apis/all_products.dart';
import 'package:e_commerce/services/models/cart_model/cart_model.dart';
import 'package:e_commerce/services/universal_response.dart';

class CartRepo {
  CartRepo({required this.aPiProvider});
  APiProvider? aPiProvider;
  Future<List<CartModel>> getUsers() async {
    UniversalResponse? universalResponse = await aPiProvider!.getCarts();
    if (universalResponse.error.isEmpty) {
      if (universalResponse.data is CartModel) {
        return [universalResponse.data as CartModel];
      } else if (universalResponse.data is List<CartModel>) {
        return universalResponse.data as List<CartModel>;
      }
    }
    return [];
  }
}
