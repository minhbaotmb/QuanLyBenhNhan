import 'dart:math';

import 'package:flutter/material.dart';

import '../commons.dart';

class Globals {
  static Widget iconGender(int? gender) {
    if (gender != null) {
      if (gender == 1) {
        return Image.asset(Commons.malePath, fit: BoxFit.cover);
      } else if (gender == 2) {
        return Image.asset(Commons.femalePath);
      }
    }

    return const Icon(Icons.usb_rounded);
  }

  static TextSpan doiTuongBenhNhan(int? doiTuong) {
    Color? color;
    String doiTuongText;

    if (doiTuong == null) {
      doiTuongText = "-";
      color = Colors.black;
    } else {
      switch (doiTuong.hashCode) {
        case 1:
          doiTuongText = "THU PHÍ";
          color = Colors.indigo;
          break;
        case 2:
          doiTuongText = "BHYT";
          color = Colors.green;
          break;
        case 3:
          doiTuongText = "YÊU CẦU (VIP)";
          color = Colors.amber;
          break;
        default:
          doiTuongText = "-";
          color = Colors.black;
          break;
      }
    }

    return TextSpan(
      text: doiTuongText,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }

  static String avatarRandom({
    bool getRandom = false,
    bool setToUserLogin = false,
  }) {
    String path = '';

    if (getRandom == false) {
      if (Commons.userLogin != null) {
        if (Commons.userLogin!.account! == 'baotm') {
          path = Commons.avatarTMBpath;
        } else if (Commons.userLogin!.avatarPath != null &&
            Commons.userLogin!.avatarPath!.isNotEmpty) {
          return Commons.userLogin!.avatarPath!;
        }
      }
    }

    if (path.isEmpty) {
      Random rand = Random();
      int vt = rand.nextInt(5);
      path = Commons.avatarRandomPath.replaceAll('{0}', (vt + 1).toString());
    }

    if (setToUserLogin) {
      Commons.userLogin!.avatarPath = path;
    }
    return path;
  }
}
