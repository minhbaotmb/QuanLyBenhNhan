import 'package:benh_nhan_noi_tru_his/commons.dart';
import 'package:benh_nhan_noi_tru_his/resources/controllers/login_controller.dart';
import 'package:benh_nhan_noi_tru_his/resources/models/user_model';
import 'package:benh_nhan_noi_tru_his/resources/views/home.dart';
import 'package:benh_nhan_noi_tru_his/utilities/helpers.dart';
import 'package:benh_nhan_noi_tru_his/utilities/unfocus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: UnFocus(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.all(50),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20.0),
                  logo(size.width),
                  title(),
                  const SizedBox(height: 60.0),
                  userNameForm(),
                  passwordForm(),
                  const SizedBox(height: 40.0),
                  loginForm(context),
                  Container(
                    padding: const EdgeInsets.only(top: 50),
                    child:
                        const Text('Bạn quên mật khẩu? chúng tôi cũng hết cách!'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logo(double width) {
    return Container(
      height: 50,
      width: width,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Commons.logoPath),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget title() {
    return const Text('QUẢN LÝ BỆNH NHÂN NỘI TRÚ',
        style: TextStyle(
            color: Colors.orange,
            fontSize: Commons.fontSize20,
            fontWeight: FontWeight.bold));
  }

  Widget userNameForm() {
    return TextField(
      controller: userNameController,
      maxLength: 20,
      decoration: const InputDecoration(
        hintText: 'Tên đăng nhập',
        icon: Icon(Icons.account_circle, color: Commons.kColor),
      ),
    );
  }

  Widget passwordForm() {
    return TextField(
      controller: passwordController,
      decoration: InputDecoration(
        hintText: 'Mật khẩu',
        icon: const Icon(Icons.lock, color: Commons.kColor),
        suffixIcon: IconButton(
          icon: Icon(isShowPassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isShowPassword = !isShowPassword;
            });
          },
        ),
      ),
      obscureText: !isShowPassword,
    );
  }

  Widget loginForm(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.check),
        label: const Text(
          'Đăng nhập',
          style: TextStyle(fontSize: 17.0),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        onPressed: () async {
          UnFocus.unfocusControls(context);

          // String isNetwork = await Helpers.checkNetwork();
          // if (isNetwork.isEmpty == false) {
          //   return;
          // }

          if (!checkValidate()) {
            return;
          }

          EasyLoading.show(status: 'Đang đăng nhập...');
          UserModel? user = await LogInController.login(
              userNameController.text, passwordController.text);
          EasyLoading.dismiss();

          if (user == null) {
            Helpers.showError(
                'Tên đăng nhập hoặc mật khẩu không chính xác', null);
            return;
          }

          Commons.userLogin = user;
          pushBenhNhanNoiTruScreen();
        },
      ),
    );
  }

  void pushBenhNhanNoiTruScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  bool checkValidate() {
    if (userNameController.text.isEmpty) {
      Helpers.showError('Chưa nhập tên đăng nhập', null);
      return false;
    }

    if (passwordController.text.isEmpty) {
      Helpers.showError('Chưa nhập mật khẩu', null);
      return false;
    }

    return true;
  }
}
