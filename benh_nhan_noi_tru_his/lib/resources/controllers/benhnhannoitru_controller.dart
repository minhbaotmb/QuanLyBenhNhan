import 'dart:convert';
import 'package:benh_nhan_noi_tru_his/commons.dart';
import 'package:http/http.dart' as http;
import 'package:benh_nhan_noi_tru_his/resources/models/benhnhannoitru_model';

class BenhNhanNoiTruController {
  static Future<List<BenhNhanNoiTruModel>?> loadData(int? wardId, int medRcdType) async {
    if (wardId == null) {
      return <BenhNhanNoiTruModel>[];
    }

    final response = await http.post(
      Uri.parse(Commons.apiBenhNhanNoiTruList),
      body: jsonEncode({
        'wardId': wardId,
        'medRcdType': medRcdType, //1: Ngoại trú, 2: Nội trú
        'status': 8, // Đang thực hiện
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        //'Accept': 'application/json',
        'Authorization': 'Bearer ${Commons.userLogin?.token}',
      },
    );

    if (response.statusCode == 200) {
      // OK
      var users = (json.decode(response.body) as List)
          .map((data) => BenhNhanNoiTruModel.fromJson(data))
          .toList();

      return users;
    } else if (response.statusCode == 204) {
      // NO CONTENT
      return <BenhNhanNoiTruModel>[];
    }

    return null;
  }
}
