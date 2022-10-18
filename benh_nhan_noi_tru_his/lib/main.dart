import 'package:benh_nhan_noi_tru_his/resources/views/home.dart';
import 'package:benh_nhan_noi_tru_his/resources/views/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'commons.dart';
import 'resources/views/benhnhanngoaitru.dart';
import 'resources/views/benhnhannoitru.dart';
import 'resources/views/user_info.dart';
import 'resources/views/userlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quản lý bệnh nhân nội trú HIS',
      theme: ThemeData(
        primarySwatch: Commons.kColor,
      ),
      debugShowCheckedModeBanner: false,
      //home: const LoginScreen(),
      builder: EasyLoading.init(),
      initialRoute: '$LoginScreen',
      routes: {
        '$LoginScreen': (_) => const LoginScreen(),
        '$HomeScreen': (_) => const HomeScreen(),
        '$UserInfoScreen': (_) => const UserInfoScreen(),
        '$BenhNhanNoiTruScreen': (_) => const BenhNhanNoiTruScreen(),
        '$BenhNhanNgoaiTruScreen': (_) => const BenhNhanNgoaiTruScreen(),
        '$UserListScreen': (_) => const UserListScreen(),
      },
    );
  }
}
