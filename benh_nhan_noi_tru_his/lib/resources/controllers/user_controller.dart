import 'dart:convert';
import 'package:benh_nhan_noi_tru_his/commons.dart';
import 'package:http/http.dart' as http;
import '../models/user_model';

class UserController {
  static Future<List<UserModel>?> loadData() async {
    final response = await http.get(
      Uri.parse(Commons.apiUserList),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        //'Accept': 'application/json',
        'Authorization': 'Bearer ${Commons.userLogin?.token}',
      },
    );

    if (response.statusCode == 200) {
      var users = (json.decode(response.body) as List)
          .map((data) => UserModel.fromJson(data))
          .toList();

      return users;
    }

    return null;
  }
}
