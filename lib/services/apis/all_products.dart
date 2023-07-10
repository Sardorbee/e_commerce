import 'dart:convert';

import 'package:e_commerce/services/universal_response.dart';
import 'package:http/http.dart' as http;

import '../models/product_model/products_model.dart';

class APiProvider {
  Future<UniversalResponse> getAllProducts(
      String categoy, String? sort, int limit) async {
    print(1);
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
      print("ERRROR$error");
      return UniversalResponse(error: error.toString());
    }
  }
   Future<UniversalResponse> getProductsByLimit(int limit) async {
    Uri uri = Uri.parse("https://fakestoreapi.com/products?limit=${limit.toString()}");
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
      print("ERRROR$error");
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
      print("ERROR: $error");
      return UniversalResponse(error: error.toString());
    }
  }
}
