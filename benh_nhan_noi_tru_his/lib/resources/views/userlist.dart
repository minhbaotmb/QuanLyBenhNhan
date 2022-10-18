import 'package:benh_nhan_noi_tru_his/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../utilities/globals.dart';
import '../../utilities/helpers.dart';
import '../controllers/user_controller.dart';
import '../models/user_model';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: const [
          Icon(
            Icons.groups_rounded,
            size: 35,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Danh sách nhân viên'),
          ),
        ],
      )),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildGridviewData(context),
          ],
        ),
      ),
    );
  }

  Widget buildGridviewData(BuildContext context) {
    return FutureBuilder<List<UserModel>?>(
      future: UserController.loadData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(''),
          );
        } else if (snapshot.data != null && snapshot.hasData) {
          return buildGridDetail(context, snapshot.data!);
        } else {
          return Align(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    color: Commons.kColor,
                  ),
                  Text(
                    'Đang tải dữ liệu',
                    style: TextStyle(fontSize: Commons.fontSize16),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildGridDetail(BuildContext context, List<UserModel> userList) {
    Size size = MediaQuery.of(context).size;
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: size.width > 500 ? 4 : 3,
      padding: const EdgeInsets.all(5.0),
      childAspectRatio: 1.1, // bề rộng của cell
      children: List.generate(
        userList.length,
        (index) => AnimationConfiguration.staggeredGrid(
          position: index,
          duration: const Duration(milliseconds: 700),
          columnCount: size.width > 500 ? 4 : 3,
          child: ScaleAnimation(
            child: FadeInAnimation(
              child: buildItem(userList[index], context),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItem(UserModel user, BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        //side: BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Hero(
                  tag: user.userId!,
                  child: Image.asset(Globals.avatarRandom(getRandom: true),
                      width: 65, fit: BoxFit.contain)),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                user.fullName!,
                style: const TextStyle(
                    fontSize: Commons.fontSize16 * 0.8,
                    color: Commons.k2Color,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              user.account!,
              style: const TextStyle(
                fontSize: Commons.fontSize16 * 0.7,
                color: Commons.k2Color,
              ),
            ),
          ],
        ),
        onTap: () {
          Helpers.showInfo(user.fullName!, user.account, positionTop: false);
        },
      ),
    );
  }
}
