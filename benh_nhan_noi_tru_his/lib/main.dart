import 'package:benh_nhan_noi_tru_his/resources/views/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'commons.dart';

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
      home: const LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}
