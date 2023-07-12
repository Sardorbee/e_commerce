import 'dart:convert';

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
      String categoy, String? sort, int limit) async {
    Uri uri = Uri.parse(
        "https://fakestoreapi.com/products$categoy?sort=$sort&limit=$limit");
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

  Future<UniversalResponse> getUsers() async {
    const apiUrl =
        'https://fakestoreapi.com/users'; // Replace with your API endpoint

    final response = await http.get(Uri.parse(apiUrl));

    try {
      if (response.statusCode == 200) {
        // User data retrieved successfully
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          final userList =
              jsonData.map((userJson) => UserModel.fromJson(userJson)).toList();
          return UniversalResponse(data: userList);
        } else {
          throw Exception('Invalid JSON format');
        }
      } else {
        // Handle the API error
        return UniversalResponse(error: "Errorrr");
      }
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }
}
