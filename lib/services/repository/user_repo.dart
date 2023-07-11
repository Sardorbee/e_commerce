import 'package:e_commerce/services/apis/all_products.dart';
import 'package:e_commerce/services/models/user_model/user_model.dart';
import 'package:e_commerce/services/universal_response.dart';

class UserRepo {
  UserRepo({required this.aPiProvider});
  APiProvider? aPiProvider;
  Future<List<UserModel>> getUsers() async {
    UniversalResponse? universalResponse =
        await aPiProvider!.getUsers();
    if (universalResponse.error.isEmpty) {
      if (universalResponse.data is UserModel) {
        return [universalResponse.data as UserModel];
      } else if (universalResponse.data is List<UserModel>) {
        return universalResponse.data as List<UserModel>;
      }
    }
    return [];
  }
}
