import 'package:benh_nhan_noi_tru_his/commons.dart';
import 'package:benh_nhan_noi_tru_his/resources/views/benhnhanngoaitru.dart';
import 'package:benh_nhan_noi_tru_his/resources/views/benhnhannoitru.dart';
import 'package:benh_nhan_noi_tru_his/resources/views/home_header.dart';
import 'package:benh_nhan_noi_tru_his/resources/views/login.dart';
import 'package:benh_nhan_noi_tru_his/resources/views/userlist.dart';
import 'package:benh_nhan_noi_tru_his/utilities/logo_home_animation.dart';
import 'package:benh_nhan_noi_tru_his/resources/views/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../utilities/helpers.dart';
import '../../utilities/popup_show.dart';

const cardItemHeight = 95.0;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Helpers.gradientDecoration(Commons.kColorBlueShade, Commons.kColor),
        child: Column(
          children: [
            const HomeHeaderScreen(),
            homeContent(context),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:
          Builder(builder: (context) => bottomNavigationBar(context)),
      drawer: const UserInfoScreen(),
    );
  }

  Expanded homeContent(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(80)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      patientSumary('B???nh nh??n kh??m h??m nay:', 3927),
                      percentSumary(true, 8),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      patientSumary('??? N???i tr??:', 2927),
                      percentSumary(false, 4),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      patientSumary('??? Ngo???i tr??:', 1000),
                      percentSumary(true, 3),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 40),
              menuItem(
                context,
                'Danh s??ch b???nh nh??n n???i tr??',
                'B???nh nh??n ??ang n???m vi???n v?? ??i???u tr???',
                Icons.wb_incandescent_outlined,
                CardEnum.noiTru,
              ),
              menuItem(
                context,
                'Danh s??ch b???nh nh??n ngo???i tr??',
                null,
                Icons.wb_iridescent,
                CardEnum.ngoaiTru,
              ),
              menuItem(
                context,
                'Danh s??ch nh??n vi??n',
                'Nh??n vi??n b???nh vi???n, bao g???m c??? b??c s??',
                Icons.groups_rounded,
                CardEnum.userList,
              )
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        PopupShow.showMesseageDialog(
          context,
          showDeleteCircle: true,
          hideButtonClose: true,
          bodyWidget: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getCompanyInfo(context)),
          ),
          buttonWidgets: [
            TextButton(
              onPressed: () {
                Clipboard.setData(
                  const ClipboardData(
                      text:
                          "C??ng ty C??? ph???n Infomed, ???ng d???ng Qu???n l?? b???nh nh??n n???i tr?? - B???nh vi???n Long Kh??nh"),
                );
                Helpers.showSnackBar(title: "???? copy");
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
      },
      elevation: 0,
      child: const LogoHomeAnimation(),
    );
  }

  BottomAppBar bottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      color: Commons.kColor.withGreen(120),
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.account_box),
            color: Colors.white,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          const SizedBox(),
          IconButton(
            icon: const Icon(
              Icons.logout,
              size: 25,
            ),
            color: Colors.white,
            onPressed: () {
              Commons.userLogin = null;
              Navigator.pushNamed(context, '$LoginScreen');
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => const LoginScreen()));
            },
          ),
        ],
      ),
    );
  }

  Widget patientSumary(String text, int? total) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
              color: Colors.black, fontSize: Commons.fontSize20),
          children: [
            TextSpan(text: '${text.trim()} '),
            TextSpan(
              text: NumberFormat('#,##0').format(total ?? 0).toString(),
              style: const TextStyle(
                  color: Commons.kColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget percentSumary(bool? isUp, int percent) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            isUp == null
                ? const Icon(Icons.commit_rounded, size: 14)
                : (isUp == true
                    ? const Icon(Icons.arrow_upward_rounded,
                        color: Colors.green, size: 14)
                    : const Icon(Icons.arrow_downward_rounded,
                        color: Colors.red, size: 14)),
            isUp == null
                ? Text('$percent')
                : (isUp == true
                    ? Text(
                        '$percent%',
                        style: const TextStyle(color: Colors.green),
                      )
                    : Text('$percent%',
                        style: const TextStyle(color: Colors.red))),
          ],
        ),
      ),
    );
  }

  Stack menuItem(BuildContext context, String? text, String? subText,
      IconData iconData, CardEnum cardNum) {
    return Stack(children: [
      Container(
        alignment: Alignment.center,
        height: cardItemHeight,
        child: Card(
          margin: const EdgeInsets.all(10),
          color: Commons.kColor.withGreen(120),
          shadowColor: Commons.kColor,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: iconMenuItem(iconData, cardNum),
                title: Text(text ?? "",
                    style: const TextStyle(
                        fontSize: Commons.fontSize20, color: Colors.white)),
                subtitle: Text(subText ?? "",
                    style: const TextStyle(color: Commons.kColorYellow)),
                onTap: () => onTapMenuItem(context, cardNum),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        right: 0,
        top: cardItemHeight / 2 - 10,
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
              width: 10,
              height: 20,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                color: Colors.white,
              )),
        ),
      )
    ]);
  }

  Widget iconMenuItem(IconData iconData, CardEnum cardNum) {
    var icon = Icon(iconData, color: Commons.kColorYellow, size: 35);

    switch (cardNum) {
      case CardEnum.noiTru:
        return Hero(tag: Commons.heroNoiTru, child: icon);

      case CardEnum.ngoaiTru:
        return Hero(tag: Commons.heroNgoaiTru, child: icon);

      case CardEnum.userList:
        return Hero(tag: Commons.heroUserList, child: icon);

      default:
        return icon;
    }
  }

  void onTapMenuItem(BuildContext context, CardEnum cardNum) {
    switch (cardNum) {
      case CardEnum.noiTru:
        Navigator.pushNamed(context, '$BenhNhanNoiTruScreen');
        break;

      case CardEnum.ngoaiTru:
        Navigator.pushNamed(context, '$BenhNhanNgoaiTruScreen');
        break;

      case CardEnum.userList:
        Navigator.pushNamed(context, '$UserListScreen');
        break;

      default:
      // C?? th??? d??ng
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (BuildContext context) => const BenhNhanNoiTruScreen()));
    }
  }

  static List<Widget> getCompanyInfo(BuildContext context) {
    List<Widget> list = [
      // Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(50),
      //   ),
      //   child: Image.asset(Constants.companyImage, fit: BoxFit.cover),
      // ),
      Row(
        children: const [
          Icon(Icons.info_outline, color: Commons.kColor),
          Text(' TH??NG TIN ???NG D???NG'),
        ],
      ),
      const SizedBox(height: 30),
      Helpers.addLineDetail(null, "QU???N L?? B???NH NH??N N???I TR??",
          fontWeight: FontWeight.bold, color: Commons.kColor),
      Helpers.addLineDetail(null, "B???NH VI???N LONG KH??NH",
          fontWeight: FontWeight.bold, color: Commons.kColorBlueShade),
      Helpers.addLineDetail("Phi??n b???n: ", "1.0.0.1"),
      const SizedBox(height: 30, child: Text('-----')),
      Helpers.addLineDetail("C??ng ty C??? ph???n ", "Infomed",
          fontWeight: FontWeight.bold),
      Helpers.addLineDetail("??i???n tho???i: ", "0934 999 734"),
      Helpers.addLineDetail("Email: ", "info@infomed.vn"),
      Helpers.addLineDetail(
          "?????a ch???: ", "1196 ???????ng 3/2, Ph?????ng 8, Qu???n 11, Tp.HCM"),
      Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        width: MediaQuery.of(context).size.width / 3,
        child: Image.asset(Commons.logoPath),
      )
    ];

    return list;
  }
}

enum CardEnum {
  noiTru,
  ngoaiTru,
  userList,
}
