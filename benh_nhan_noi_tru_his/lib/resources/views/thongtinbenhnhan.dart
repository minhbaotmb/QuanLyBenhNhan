import 'package:benh_nhan_noi_tru_his/resources/models/benhnhannoitru_model';
import 'package:benh_nhan_noi_tru_his/utilities/popup_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../utilities/globals.dart';
import '../../utilities/helpers.dart';

class ThongTinBenhNhanScreen {
  static void showCompanyInfo(
      BuildContext context, BenhNhanNoiTruModel benhNhanNoiTru) async {
    PopupShow.showMesseageDialog(
      context,
      showDeleteCircle: true,
      hideButtonClose: true,
      bodyWidget: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getBenhNhanInfo(benhNhanNoiTru)),
      ),
      buttonWidgets: [
        TextButton(
          onPressed: () {
            Clipboard.setData(
              ClipboardData(
                  text:
                      "${benhNhanNoiTru.ptName!.toUpperCase()} ${benhNhanNoiTru.medRcdNo}"),
            );
            Helpers.showSnackBar(title: "Đã copy");
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: const [
                Icon(Icons.copy),
                SizedBox(width: 5),
                Text("Copy"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static List<Widget> getBenhNhanInfo(BenhNhanNoiTruModel benhNhanNoiTru) {
    List<Widget> list = [
      // Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(50),
      //   ),
      //   child: Image.asset(Constants.companyImage, fit: BoxFit.cover),
      // ),
      Row(
        children: [
          Globals.iconGender(benhNhanNoiTru.ptGender),
          const Text(' THÔNG TIN BỆNH NHÂN'),
        ],
      ),
      const SizedBox(height: 30),

      Helpers.addLineDetail("Họ tên: ", benhNhanNoiTru.ptName!.toUpperCase(),
          fontWeight: FontWeight.bold),
      Helpers.addLineDetail("Mã bệnh án: ", benhNhanNoiTru.medRcdNo.toString(),
          fontWeight: FontWeight.bold),
      Helpers.addLineDetail("Năm sinh: ",
          "${DateFormat("yyyy").format(DateTime.parse(benhNhanNoiTru.ptDob.toString()))} (${DateTime.now().year - DateTime.parse(benhNhanNoiTru.ptDob.toString()).year} tuổi)"),
      RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Đối tượng: ",
              style: TextStyle(color: Colors.black),
            ),
            Globals.doiTuongBenhNhan(benhNhanNoiTru.insBenefitType),
          ],
        ),
      ),
      Helpers.addLineDetail("Nhóm máu: ", benhNhanNoiTru.bloodName.toString(),
          fontWeight: FontWeight.bold),
      Helpers.addLineDetail("Khoa: ", benhNhanNoiTru.wardName.toString()),
      Helpers.addLineDetail(
          "Ngày nhập khoa: ",
          DateFormat("HH:mm dd/MM/yyyy")
              .format(DateTime.parse(benhNhanNoiTru.rcvOn.toString()))),
      Helpers.addLineDetail("Chẩn đoán: ",
          "${benhNhanNoiTru.dxInText ?? ''} (${benhNhanNoiTru.dxInICD ?? ""})"),
    ];

    return list;
  }

  
}
