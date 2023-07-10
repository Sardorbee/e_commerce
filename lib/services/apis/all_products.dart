import 'dart:convert';

import 'package:e_commerce/services/universal_response.dart';
import 'package:http/http.dart' as http;

import '../models/product_model/products_model.dart';

class APiProvider {
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
    final apiUrl =
        'https://fakestoreapi.com/products/$productId'; // Replace with your API endpoint

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Product deleted successfully

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

  Future<UniversalResponse> addProduct(ProductsModel product) async {
    const apiUrl =
        'https://fakestoreapi.com/products'; // Replace with your API endpoint

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 200) {
        // Product deleted successfully
        

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
  Future<UniversalResponse> addProductUpdate(ProductsModel product, int id) async {
    final apiUrl =
        'https://fakestoreapi.com/products/$id'; // Replace with your API endpoint

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 200) {
        // Product deleted successfully
        

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
}
