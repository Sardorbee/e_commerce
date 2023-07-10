import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/user_model/user_model.dart';

class UserProvider {
  Future<List<UserModel>> getUsers() async {
    final apiUrl = 'https://fakestoreapi.com/users'; // Replace with your API endpoint

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // User data retrieved successfully
      final jsonData = json.decode(response.body);
      if (jsonData is List) {
        final userList = jsonData.map((userJson) => UserModel.fromJson(userJson)).toList();
        return userList;
      } else {
        throw Exception('Invalid JSON format');
      }
    } else {
      // Handle the API error
      print('Error: ${response.statusCode}');
      return [];
    }
  }
}