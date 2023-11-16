import 'dart:convert';

import 'package:e_commerce/services/models/cart_model/cart_model.dart';
import 'package:e_commerce/services/universal_response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/product_model/products_model.dart';
import '../models/user_model/user_model.dart';

class APiProvider {
  Future<UniversalResponse> logintoProducts(
      String username, String password) async {
    const apiUrl = 'https://fakestoreapi.com/auth/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {"username": username, "password": password},
      );

      if (response.statusCode == 200) {
        print(response.body);
        return UniversalResponse(
          data: jsonDecode(response.body)['token'],
        );
      } else {
        return UniversalResponse(
          error: 'Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      return UniversalResponse(
        error: e.toString(),
      );
    }
  }

  Future<UniversalResponse> getAllProducts(
      String categoy) async {
    Uri uri = Uri.parse(
        "https://fakestoreapi.com/products$categoy");
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (jsonDecode(response.body) as List?)
                  ?.map((e) => ProductsModel.fromJson(e))
                  .toList() ??
              [],
        );
      }
      return UniversalResponse(error: "ERROR");
    } catch (error) {
      return UniversalResponse(error: error.toString());
    }
  }

  Future<UniversalResponse> getProductsByID(int id) async {
    Uri uri = Uri.parse("https://fakestoreapi.com/products/${id.toString()}");
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return UniversalResponse(
          data: ProductsModel.fromJson(jsonDecode(response.body)),
        );
      }

      return UniversalResponse(error: "ERROR");
    } catch (error) {
      return UniversalResponse(error: error.toString());
    }
  }

  Future<UniversalResponse> deleteProduct(int productId) async {
    final apiUrl = 'https://fakestoreapi.com/products/$productId';

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return UniversalResponse(
          data: ProductsModel.fromJson(jsonDecode(response.body)),
        );
      } else {
        return UniversalResponse(
          error: 'Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      return UniversalResponse(
        error: e.toString(),
      );
    }
  }

  Future<UniversalResponse> addProduct(ProductsModel product) async {
    const apiUrl = 'https://fakestoreapi.com/products';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 200) {
        return UniversalResponse(
          data: ProductsModel.fromJson(jsonDecode(response.body)),
        );
      } else {
        return UniversalResponse(
          error: 'Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      return UniversalResponse(
        error: e.toString(),
      );
    }
  }

  Future<UniversalResponse> addProductUpdate(
      ProductsModel product, int id) async {
    final apiUrl = 'https://fakestoreapi.com/products/$id';
    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 200) {
        return UniversalResponse(
          data: ProductsModel.fromJson(jsonDecode(response.body)),
        );
      } else {
        // Handle the API error
        return UniversalResponse(
          error: 'Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      return UniversalResponse(
        error: e.toString(),
      );
    }
  }

  Future<UniversalResponse> getCarts() async {
    const apiUrl = 'https://fakestoreapi.com/carts';

    final response = await http.get(Uri.parse(apiUrl));

    try {
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          final cartList =
              jsonData.map((cart) => CartModel.fromJson(cart)).toList();
          return UniversalResponse(data: cartList);
        } else {
          throw Exception('Invalid JSON format');
        }
      } else {
        return UniversalResponse(error: "Errorrr");
      }
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> getUserByID(int id) async {
    Uri uri = Uri.parse("https://fakestoreapi.com/users/${id.toString()}");
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return UniversalResponse(
          data: UserModel.fromJson(jsonDecode(response.body)),
        );
      }

      return UniversalResponse(error: "ERROR");
    } catch (error) {
      return UniversalResponse(error: error.toString());
    }
  }

  Future<ProductsModel> getCartProductsByID(int id) async {
    Uri uri = Uri.parse("https://fakestoreapi.com/products/${id.toString()}");
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return ProductsModel.fromJson(jsonDecode(response.body));
      }

      return ProductsModel(
          title: "Error",
          price: 404,
          description: 'Error',
          category: 'Error',
          image: 'Error');
    } catch (error) {
      return ProductsModel(
          title: "Error",
          price: 404,
          description: 'Error',
          category: 'Error',
          image: 'Error');
    }
  }
}
