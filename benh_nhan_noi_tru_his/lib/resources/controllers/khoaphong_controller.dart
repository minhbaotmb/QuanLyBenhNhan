import 'dart:convert';
import 'package:benh_nhan_noi_tru_his/commons.dart';
import 'package:http/http.dart' as http;
import 'package:benh_nhan_noi_tru_his/resources/models/khoaphong_model';

class KhoaPhongController {
  static Future<List<KhoaPhongModel>?> loadData() async {
    final response = await http.get(
      Uri.parse(Commons.apiKhoaPhongList),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        //'Accept': 'application/json',
        'Authorization': 'Bearer ${Commons.userLogin?.token}',
      },
    );

    if (response.statusCode == 200) {
      var khoaPhongs = (json.decode(response.body) as List)
          .map((data) => KhoaPhongModel.fromJson(data))
          .toList();

      return khoaPhongs;
    }

    return null;
  }
}
