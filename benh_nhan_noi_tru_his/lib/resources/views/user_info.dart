import 'package:benh_nhan_noi_tru_his/commons.dart';
import 'package:benh_nhan_noi_tru_his/utilities/helpers.dart';
import 'package:flutter/material.dart';

import '../../utilities/globals.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            header(),
            menuItem('Chỉnh sửa thông tin cá nhân', Icons.person),
            menuItem('Đổi mật khẩu', Icons.key),
            menuItem('Lịch sử đăng nhập', Icons.history),
            menuItem('Cài đặt', Icons.settings),
          ],
        ),
      ),
    );
  }

  Container header() {
    var orientationPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      color: Commons.kColor,
      height: orientationPortrait ? Commons.headerSize : Commons.headerSize / 2,
      child: DrawerHeader(
        decoration: Helpers.gradientDecoration(Commons.k2Color, Commons.kColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //SizedBox(height: 100),
                  Hero(
                    tag: Commons.heroAccount,
                    child: CircleAvatar(
                      radius: orientationPortrait ? 70 : 20,
                      backgroundImage: AssetImage(Globals.avatarRandom()),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${Commons.userLogin!.fullName}',
                    style: const TextStyle(
                        color: Colors.white, fontSize: Commons.fontSize20),
                  ),
                  Text(
                    '${Commons.userLogin!.account}',
                    style: const TextStyle(
                        color: Colors.white, fontSize: Commons.fontSize16),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              'Phiên bản 1.0.0.1',
              style:
                  TextStyle(color: Colors.black87, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem(String text, IconData icon) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            icon,
            color: Commons.kColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: const TextStyle(fontSize: Commons.fontSize16),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
