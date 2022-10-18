import 'dart:convert';
import 'package:benh_nhan_noi_tru_his/commons.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:benh_nhan_noi_tru_his/resources/models/user_model';

class LogInController {
  static Future<UserModel?> login(String userName, String password) async {
    String passHash = md5.convert(utf8.encode(password)).toString();
    var apiUrl = '${Commons.apiUserLogin}/$userName?pwd=$passHash';

    final response = await http.get(Uri.parse(apiUrl));
    final data = json.decode(response.body);

    UserModel? user = UserModel.fromJson(data);
    return user.userId != null ? user : null;
  }
}
