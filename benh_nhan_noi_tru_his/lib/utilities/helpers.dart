import 'dart:io';

import 'package:benh_nhan_noi_tru_his/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Helpers {
  // check internet
  static Future<String> checkNetwork() async {
    final Connectivity connectivity = Connectivity();
    try {
      await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      //print(e.toString());
    }

    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com')
              .timeout(const Duration(seconds: 3));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return "";
      }
      return 'Không có kết nối internet';
    } on SocketException catch (_) {
      return 'Không có kết nối internet';
    } catch (ex) {
      return 'Không có kết nối internet';
    }
  }

  static showSnackBar({
    String title = '',
    String message = '',
    Color colorText = Colors.white,
    Color backgroundColor = Colors.black54,
  }) {
    //Get.back();
    Get.snackbar(title, message,
        colorText: colorText,
        backgroundColor: backgroundColor,
        snackPosition: SnackPosition.TOP,
        instantInit: false);
  }

  static showSuccess(String title, String? mess) {
    Get.closeCurrentSnackbar();
    Get.snackbar(title, mess ?? "",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.green,
        colorText: Colors.white,
        instantInit: false);
  }

  static showInfo(String title, String? mess, {bool positionTop = true}) {
    Get.closeCurrentSnackbar();
    Get.snackbar(title, mess ?? "",
        snackPosition: positionTop ? SnackPosition.TOP : SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        backgroundColor: Commons.kColor,
        colorText: Colors.white,
        instantInit: false);
  }

  static showError(String title, String? mess) {
    Get.closeCurrentSnackbar();
    Get.snackbar(title, mess ?? "",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        instantInit: false);
  }

  static Widget addLineDetail(String? title, String? content,
      {Color? color, FontWeight? fontWeight, double? fontSize}) {
    return RichText(
      softWrap: true,
      text: TextSpan(
        style: const TextStyle(
            // fontSize: Constants.fontSize,
            // color: Constants.color_black,
            ),
        children: [
          TextSpan(
            text: title ?? "",
            style: const TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: content ?? "",
            style: TextStyle(
                color: color ?? Colors.black,
                fontWeight: fontWeight ?? FontWeight.normal,
                fontSize: fontSize),
          ),
        ],
      ),
    );
  }

  static Widget showEmptyList({
    bool isShowError = false,
    Object tag = Object,
    IconData? icon,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        Hero(
          tag: tag,
          child: Icon(
            isShowError == true
                ? Icons.error_outline_sharp
                : icon ?? Icons.cloud_done,
            color: isShowError == true ? Colors.red : Colors.blue,
            size: 40,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          isShowError == true ? "Lỗi khi lấy dữ liệu" : "Không có dữ liệu !",
          style: const TextStyle(
            color: Colors.black87,
            fontSize: Commons.fontSize16,
          ),
        )
      ],
    );
  }

  static BoxDecoration gradientDecoration(Color color1, Color color2) {
    return BoxDecoration(
      gradient: LinearGradient(
          colors: [color1, color2],
          begin: const FractionalOffset(0.0, 0.4),
          end: Alignment.topRight),
    );
  }
}
