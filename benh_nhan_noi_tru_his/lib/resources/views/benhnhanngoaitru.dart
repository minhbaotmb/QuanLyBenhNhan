import 'package:benh_nhan_noi_tru_his/commons.dart';
import 'package:benh_nhan_noi_tru_his/resources/controllers/khoaphong_controller.dart';
import 'package:benh_nhan_noi_tru_his/resources/models/benhnhannoitru_model';
import 'package:benh_nhan_noi_tru_his/resources/models/khoaphong_model';
import 'package:benh_nhan_noi_tru_his/resources/views/thongtinbenhnhan.dart';
import 'package:benh_nhan_noi_tru_his/utilities/helpers.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../utilities/globals.dart';
import '../controllers/benhnhannoitru_controller.dart';

class BenhNhanNgoaiTruScreen extends StatefulWidget {
  const BenhNhanNgoaiTruScreen({Key? key}) : super(key: key);

  @override
  State<BenhNhanNgoaiTruScreen> createState() => _BenhNhanNgoaiTruScreenState();
}

class _BenhNhanNgoaiTruScreenState extends State<BenhNhanNgoaiTruScreen> {
  TextEditingController txtSearch = TextEditingController();
  List<KhoaPhongModel> khoaPhongList = [];
  KhoaPhongModel? khoaPhongSelected;
  List<BenhNhanNoiTruModel>? benhNhanNgoaiTruListDefault = [];
  List<BenhNhanNoiTruModel>? benhNhanNgoaiTruList = [];
  String title = "Bệnh nhân ngoại trú";
  int? wardIdSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: appBar(),
      ),
      body: Column(children: [
        loadDanhSachKhoaPhong(),
        buildDetail(),
      ]),
    );
  }

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 75,
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Text(title),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            height: 40,
            child: TextFormField(
              controller: txtSearch,
              textAlign: TextAlign.start,
              cursorColor: Commons.k3Color,
              style: const TextStyle(color: Commons.k3Color),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                contentPadding: const EdgeInsets.only(top: 7),
                hintText: 'Tìm kiếm...',
                hintStyle: const TextStyle(color: Commons.k3Color),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Commons.k3Color,
                  size: 20,
                ),
              ),
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                //if(value != null && value != "")
              },
              onChanged: (value) => searchFilter(value),
            ),
          ),
        ],
      ),
      automaticallyImplyLeading: true,
      // actions: [
      //   FloatingActionButton(
      //       backgroundColor: Colors.transparent,
      //       elevation: 0,
      //       heroTag: null,
      //       onPressed: () {
      //         Navigator.of(context).push(MaterialPageRoute(
      //             builder: (BuildContext context) => const LoginScreen()));
      //       },
      //       child: const Icon(
      //         Icons.logout,
      //         color: Colors.amber,
      //       )),
      // ],
    );
  }

  void searchFilter(String value) {
    value = value.trim().toUpperCase();
    setState(() {
      benhNhanNgoaiTruList = benhNhanNgoaiTruListDefault
          ?.where((x) =>
              (x.ptName != null &&
                  x.ptName.toString().toUpperCase().contains(value)) ||
              (x.bloodName != null &&
                  x.bloodName.toString().toUpperCase().contains(value)) ||
              (x.medRcdNo != null &&
                  x.medRcdNo.toString().toUpperCase().contains(value)) ||
              (x.dxInText != null &&
                  x.dxInText.toString().toUpperCase().contains(value)))
          .toList();
    });
  }

  Widget loadDanhSachKhoaPhong() {
    return FutureBuilder<List<KhoaPhongModel>?>(
      future: KhoaPhongController.loadData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var khoaPhongList = snapshot.data ?? <KhoaPhongModel>[];

          return Container(
            height: 45,
            color: Commons.k3Color.withGreen(200).withOpacity(.7),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownSearch<KhoaPhongModel?>(
                itemAsString: (item) => item?.name ?? "",
                selectedItem: khoaPhongSelected,
                items: khoaPhongList,
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  //showSelectedItems: true,
                  disabledItemFn: (KhoaPhongModel? i) =>
                      i?.wardId == khoaPhongSelected?.wardId,
                ),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  textAlign: TextAlign.center,
                  dropdownSearchDecoration: InputDecoration(
                    border: InputBorder.none,
                    //labelText: "Chọn khoa",
                    hintText: "-- Chọn khoa --",
                    hintStyle: TextStyle(color: Commons.k2Color),
                  ),
                ),
                onChanged: (item) async {
                  khoaPhongSelected = item;
                  EasyLoading.show(status: 'Đang lấy dữ liệu...');
                  var list = await BenhNhanNoiTruController.loadData(
                      khoaPhongSelected?.wardId, 1);

                  txtSearch.text = "";
                  setState(() {
                    title =
                        "Bệnh nhân ngoại trú ${list != null && list.isNotEmpty ? " (${list.length})" : ""}";
                    benhNhanNgoaiTruList = list;
                    benhNhanNgoaiTruListDefault = list;
                    EasyLoading.dismiss();
                  });
                },
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return buildProgressIndicator();
      },
    );
  }

  Widget buildProgressIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: 0.4,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildDetail() {
    if (benhNhanNgoaiTruList == null) {
      return Helpers.showEmptyList(
          isShowError: true, tag: Commons.heroNgoaiTru);
    } else if (benhNhanNgoaiTruList!.isEmpty) {
      return Helpers.showEmptyList(
          tag: Commons.heroNgoaiTru, icon: Icons.wb_iridescent);
    } else {
      return Expanded(
        child: SingleChildScrollView(
          child: ListView.builder(
            padding: const EdgeInsets.all(3),
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => Card(
              margin: const EdgeInsets.all(3),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Globals.iconGender(
                            benhNhanNgoaiTruList![index].ptGender),
                        const SizedBox(width: 5),
                        Text(
                          benhNhanNgoaiTruList![index]
                              .ptName
                              .toString()
                              .toUpperCase(),
                          style: const TextStyle(
                            color: Commons.k2Color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Text(
                        '${benhNhanNgoaiTruList![index].medRcdNo}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(benhNhanNgoaiTruList![index].ptDob != null
                            ? "Năm sinh: ${DateFormat("yyyy").format(DateTime.parse(benhNhanNgoaiTruList![index].ptDob.toString()))} (${DateTime.now().year - DateTime.parse(benhNhanNgoaiTruList![index].ptDob.toString()).year} tuổi)"
                            : ""),
                        RichText(
                          text: TextSpan(
                              style: const TextStyle(color: Colors.black54),
                              children: [
                                Globals.doiTuongBenhNhan(
                                    benhNhanNgoaiTruList![index]
                                        .insBenefitType),
                              ]),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            "Nhóm máu: ${benhNhanNgoaiTruList![index].bloodName}"),
                        Text(benhNhanNgoaiTruList![index].rcvOn != null
                            ? "Nhập viện: ${DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(benhNhanNgoaiTruList![index].rcvOn.toString()))}"
                            : ""),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  ThongTinBenhNhanScreen.showCompanyInfo(
                      context, benhNhanNgoaiTruList![index]);
                },
              ),
            ),
            itemCount: benhNhanNgoaiTruList!.length,
          ),
        ),
      );
    }
  }
}
