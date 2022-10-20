import 'package:benh_nhan_noi_tru_his/resources/models/user_model';
import 'package:flutter/material.dart';

class Commons {
  static UserModel? userLogin;

  static const MaterialColor kColor = Colors.blue;
  static const Color kColorBlueShade = Color.fromARGB(255, 3, 58, 160);
  static const Color kColorYellow = Colors.yellow;

  static const double fontSize20 = 20;
  static const double fontSize16 = 16;
  static const double headerSize = 300;

  static const String apiUserLogin = 'http://137.59.41.10:1051/admin/Users/Login';
  static const String apiUserList = 'http://137.59.41.10:1051/admin/Users';
  static const String apiKhoaPhongList = 'http://137.59.41.10:1051/master/Wards';
  static const String apiBenhNhanNoiTruList = 'http://137.59.41.10:1051/cis/WardAdmission/Criteria';

  static const String avatarTMBpath = 'assets/images/avatar/avaTMB.jpg';
  static const String avatarRandomPath = 'assets/images/avatar/ava{0}.png';
  static const String malePath = 'assets/images/male.png';
  static const String femalePath = 'assets/images/female.png';
  static const String logoPath = 'assets/images/logo_infomed.png';
  static const String logoSquarePath = 'assets/images/square-logoIFM.png';

  static const String heroAccount = "heroAccount";
  static const String heroNoiTru = "heroNoiTru";
  static const String heroNgoaiTru = "heroNgoaiTru";
  static const String heroUserList = "heroUserList";
}
